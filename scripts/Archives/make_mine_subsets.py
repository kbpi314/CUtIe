#!/usr/bin/env python
from __future__ import division

import click
import os
import time
import numpy as np

from collections import defaultdict

from cutie import parse
from cutie import statistics
from cutie import output
from cutie import __version__


CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])

@click.command(context_settings=CONTEXT_SETTINGS)

@click.option('-mf', '--mine_fp', required=True,
              type=click.Path(exists=True),
              help='MINE script file path')
@click.option('-i', '--input_fp', required=True,
              type=click.Path(exists=True),
              help='Input file path')
@click.option('-s', '--skip', default=1, required=False,
              type=int, help='row of otu table to skip')              
@click.option('-n', '--n_samp', required=True,
              type=int, help='sample size')
@click.option('-l', '--label', required=True,
              type=str, help='label to split on for data files')
@click.option('-d', '--working_dir', default='', required=False,
              help='Directory to save files')
@click.option('-c', '--command_fp',type=click.Path(writable=True),
              help='Output directory for the command files', default='jobs',
              required=False)
@click.option('--transpose', 'transpose', is_flag=True,
                flag_value=True,
              required=False, help='True if transposing file')
@click.option('--otu', 'ftype', flag_value='otu',
              default=True, required=True, help='')
@click.option('--map', 'ftype', flag_value='map',
              default=False, required=True, help='')

def make_mine_subsets(mine_fp, input_fp, skip, n_samp, label, working_dir, command_fp, transpose, ftype):
    """
    """
    start_time = time.time()
    
    if transpose:
        transposed_fn = label + '_transpose' + input_fp.split(label)[1]
    else:
        transposed_fn = label + input_fp.split(label)[1]

    transposed_fp = working_dir + transposed_fn
    # transpose input csv file (mine_fp), checking if it exists first
    # transposed_fp = data_analysis/MIC_MSQ_test2/otu_transpose_table_small.MSQ34_L6.csv
    # tr '\r' '\n' <a.txt> b.txt
    if os.path.isfile(transposed_fp) == False and transpose == True:
        with open(input_fp, "r") as f:
            parse.transpose_csv(f, transposed_fp, skip)

    with open(command_fp,'w') as f:
        f.write("java -jar " + mine_fp + " " + transposed_fp + \
                " '-allPairs' cv=0.1 exp=0.6 c=10 fewBoxes" + '\n')
        for i in xrange(n_samp):
            sub_transposed_fn = str(i) + "_" + transposed_fn
            sub_transposed_fp = working_dir + sub_transposed_fn
            f.write("java -jar " + mine_fp + " " + sub_transposed_fp + \
                " '-allPairs' cv=0.1 exp=0.6 c=10 fewBoxes" + '\n')

    print 'Created ' + str(n_samp) + ' MINE subset commands for ' + input_fp

    parse.subset_data(n_samp, transposed_fn, transposed_fp, working_dir, ftype)
    print 'Created ' + str(n_samp) + ' MINE subsetted files for ' + input_fp
    
    print time.time() - start_time
    return

if __name__ == "__main__":
    make_mine_subsets()
