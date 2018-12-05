#!/usr/bin/env python
from __future__ import division

from cutie import parse
from cutie import statistics
from cutie import output
from cutie import __version__

import time
import click
import os
import numpy as np
from scipy import stats


CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])

@click.command(context_settings=CONTEXT_SETTINGS)
@click.version_option(version=__version__)

@click.option('-l', '--label', required=True,
              help='label to save files as')
@click.option('-s1', '--samp_var1_fp', required=True,
              type=click.Path(exists=True),
              help='Input  samp variable 1 file')
@click.option('-dl1', '--delimiter1', default='\t',
                required=False, help='delimiter for first file')
@click.option('-s2', '--samp_var2_fp', required=True,
              type=click.Path(exists=True),
              help='Input  samp variable 2 file')
@click.option('-dl2', '--delimiter2', default='\t',
                required=False, help='delimiter for second file')
@click.option('--otu1', 'f1type', flag_value='otu',
              default=True, required=True, help='')
@click.option('--map1', 'f1type', flag_value='map',
              default=False, required=True, help='')
@click.option('--map2', 'f2type', flag_value='map',
              default=True, required=True, help='')
@click.option('--otu2', 'f2type', flag_value='otu',
              required=False, help='')
@click.option('-d', '--working_dir', default='', required=False,
              help='Directory to save files')
@click.option('-skip', '--skip', default=1, required=False,
              type=int, help='row of otu table to skip')
@click.option('-sc', '--startcol', default=17, required=False,
              type=int, help='starting metabolite col')
@click.option('-ec', '--endcol', default=100, required=False,
              type=int, help='ending metabolite col')
@click.option('-stat', '--statistic', default='kpc',
                type=str, required=True, help='statistic to use')
@click.option('-k', '--resample_k', default=1, required=False,
              type=int, help='number to resample')
@click.option('-rz', '--rm_zero', default=False, required=False,
              help='True if removing 0s')
@click.option('-p', '--paired', default=False, required=False,
                type=bool, help='boolean, true if correlating variable to self')
@click.option('-a', '--alpha', default=0.05, required=False,
              type=float, help='threshold value')
@click.option('--nomc', 'mc', flag_value='nomc',
              default=True, required=False,
              help='True if no mc correction used')
@click.option('--bc', 'mc', flag_value='bc',
              required=False, help='True if using Bonferroni correction')
@click.option('--fwer', 'mc', flag_value='fwer',
              required=False, help='True if using FWER correction')
@click.option('--fdr', 'mc', flag_value='fdr',
              required=False, help='True if using FDR correction')
@click.option('-ss', '--stat_names', required=False,
              type=str,
              help='Input ')
@click.option('-sf', '--stat_files', required=False,
              type=str,
              help='Input ')
@click.option('--lt1', 'log_transform1', is_flag=True,
                flag_value=True,
              required=False, help='True if log-transforming data 1')
@click.option('--lt2', 'log_transform2', is_flag=True,
                flag_value=True,
              required=False, help='True if log-transforming data 2')

def create_json(label, samp_var1_fp, delimiter1, samp_var2_fp, delimiter2, 
                    f1type, f2type, 
                    working_dir, skip, startcol, endcol, statistic, 
                    resample_k, rm_zero, 
                    paired, alpha, mc, stat_names, stat_files, log_transform1, log_transform2):
  

    start_time = time.clock()

    ### 
    # Parsing and Pre-processing
    ###

    # create subfolder to hold data analysis files
    if os.path.exists(working_dir + 'data_processing') is not True:
        os.makedirs(working_dir + 'data_processing')
        
    # file handling and parsing decisions
    # file 1 is the 'dominant' file type and should always contain the OTU file
    # we let the dominant fil 'override' the sample_id list ordering
    samp_ids, var2_names, samp_to_var2, n_var2, n_samp = \
        parse.parse_input(f2type, samp_var2_fp, startcol, endcol, delimiter2, skip)
    samp_ids, var1_names, samp_to_var1, n_var1, n_samp = \
        parse.parse_input(f1type, samp_var1_fp, startcol, endcol, delimiter1, skip)  

    # convert dictionaries to matrices
    samp_var1, avg_var1, norm_avg_var1, var_var1, norm_var_var1, skew_var1 = \
        parse.dict_to_matrix(samp_to_var1, samp_ids)
    samp_var2, avg_var2, norm_avg_var2, var_var2, norm_var_var2, skew_var2 = \
        parse.dict_to_matrix(samp_to_var2, samp_ids)

    ###
    # Simple Linear Regression: Spearman and Pearson
    ### 
    pearson_stats = ['kpc', 'jkp' , 'bsp', 'rpc', 'rjkp', 'rbsp']
    spearman_stats = ['ksc', 'jks','bss', 'rsc', 'rjks', 'rbss']
    linear_stats = pearson_stats + spearman_stats

    if statistic in linear_stats:
        # statistic-specific initial output
        stat_to_matrix = statistics.assign_statistics(samp_var1, samp_var2, 
                                                      statistic, rm_zero)
        
        # unpack statistic matrices
        pvalues = stat_to_matrix['pvalues']
        corrs = stat_to_matrix['correlations']
        logpvals = stat_to_matrix['logpvals']
        r2vals = stat_to_matrix['r2vals']

        # determine significance threshold and number of correlations
        threshold, n_corr = statistics.set_threshold(pvalues, alpha, mc, paired)

        # calculate initial sig candidates
        initial_sig, all_pairs = statistics.initial_sig_SLR(n_var1, n_var2, pvalues, 
            threshold, paired)

    # def output.files_to_sets(stat_names, stat_files)
    # return infln_metrics, FP_infln_sets
    infln_metrics = [str(x) for x in stat_names.split(',')]
    stat_files = [str(x) for x in stat_files.split(',')]
    infln_files = {}
    FP_infln_sets = {}
    counter = 0 

    for metric in infln_metrics:
        infln_files[metric] = stat_files[counter]
        FP_infln_sets[metric] = set()
        counter += 1
        with open(infln_files[metric]) as f:
            f.readline()
            for line in f.readlines():
                if line:
                    parts = line.strip().split('\t')
                    point = (int(float(parts[0])), int(float(parts[1])))
                    FP_infln_sets[metric].add(point)

    # this is to test what is picked up by different statistics
    initial_sig = all_pairs

    output.print_json_matrix(n_var1, n_var2, n_corr, infln_metrics, FP_infln_sets, initial_sig, working_dir, paired, point = False)
    output.print_json_matrix(n_var1, n_var2, n_corr, infln_metrics, FP_infln_sets, initial_sig, working_dir, paired, point = True)


    # log transform of data (if log_transform1 or log_transform2 are true)
    if log_transform1 and statistic != 'prop':
        samp_var1 = statistics.log_transform(samp_var1, working_dir, 1)
    if log_transform2 and statistic != 'prop':
        samp_var2 = statistics.log_transform(samp_var2, working_dir, 2)


    # do set operations and determine which is unique to each grouping
    # e.g. comparing jkp3, jkpl, jkpn
    # and comparing jkp3, bsp3, and kpc

    print time.clock() - start_time
    return

if __name__ == "__main__":
    create_json()

