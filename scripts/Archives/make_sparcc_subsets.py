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

@click.option('-ifp', '--input_fp', required=True,
              type=click.Path(exists=True),
              help='Input file path')
@click.option('-n', '--n_samp', required=True,
              type=int, help='sample size')
@click.option('-i', '--n_iter', required=True,
              type=int, help='iteration number')
@click.option('-b', '--n_boot', required=True,
              type=int, help='bootstrap number')
@click.option('-d', '--working_dir', default='', required=False,
              help='Directory to save files')
@click.option('-c', '--command_fp',type=click.Path(writable=True),
              help='Output directory for the command files', default='jobs',
              required=False)

def make_sparcc_subsets(input_fp, n_samp, n_iter, n_boot, working_dir, command_fp):
    """
    """
    start_time = time.time()

    # transpose input csv file (mine_fp), checking if it exists first
    # transposed_fp = data_analysis/MIC_MSQ_test2/otu_transpose_table_small.MSQ34_L6.csv
    # tr '\r' '\n' <a.txt> b.txt
    with open(command_fp,'w') as f:
        f.write('module load sparcc && ')
        input_fn = os.path.basename(input_fp)
        f.write('SparCC.py ' + input_fp + ' -i ' + str(n_iter) + ' --cor_file=' + working_dir + 'pre.' + input_fn + '.cor_sparcc1.out && ')
        f.write('SparCC.py ' + input_fp + ' -i ' + str(n_iter) + ' --cor_file=' + working_dir + 'pre.' + input_fn + '.cor_pearson1.out' + ' -a pearson && ')
        f.write('SparCC.py ' + input_fp + ' -i ' + str(n_iter) + ' --cor_file=' + working_dir + 'pre.' + input_fn + '.cor_spearman1.out' + ' -a spearman && ')
        f.write('MakeBootstraps.py ' + input_fp + ' -n ' + str(n_boot) + ' -t permutation_#.txt ' + '-p ' + working_dir +'pvals/ && ')
        f.write('for i in {0..' + str(n_boot-1) + '};' + 'do ')
        f.write('SparCC.py '+ working_dir + 'pvals/permutation_$i.txt ' + '-i ' + str(n_iter) + ' --cor_file=' + working_dir + 'pvals/perm_cor_$i.txt; ') 
        f.write('done && ')
        f.write('PseudoPvals.py ' + working_dir + 'pre.' + input_fn + '.cor_sparcc1.out ' + working_dir + 'pvals/perm_cor_#.txt ' + str(n_boot) + ' -o ' + working_dir + 'pvals/pvals.two_sided.txt -t two_sided')
        f.write('\n')
        for k in xrange(n_samp):
            f.write('module load sparcc && ')
            current_dir = working_dir + str(k) + '_removed'
            current_fn = str(k)+ '_' + os.path.basename(input_fp)
            current_fp = current_dir + '/' + current_fn
            f.write('SparCC.py ' + current_fp + ' -i ' + str(n_iter) + ' --cor_file=' + current_dir + '/pre.' + current_fn + '.cor_sparcc1.out && ')
            f.write('SparCC.py ' + current_fp + ' -i ' + str(n_iter) + ' --cor_file=' + current_dir + '/pre.' + current_fn + '.cor_pearson1.out' + ' -a pearson && ')
            f.write('SparCC.py ' + current_fp + ' -i ' + str(n_iter) + ' --cor_file=' + current_dir + '/pre.' + current_fn + '.cor_spearman1.out' + ' -a spearman && ')
            f.write('MakeBootstraps.py ' + current_fp + ' -n ' + str(n_boot) + ' -t permutation_#.txt ' + '-p ' + current_dir +'/pvals/ && ')
            f.write('for i in {0..' + str(n_boot-1) + '};' + 'do ')
            f.write('SparCC.py '+ current_dir + '/pvals/permutation_$i.txt ' + '-i ' + str(n_iter) + ' --cor_file=' + current_dir + '/pvals/perm_cor_$i.txt; ') 
            f.write('done && ')
            f.write('PseudoPvals.py ' + current_dir + '/pre.' + current_fn + '.cor_sparcc1.out ' + current_dir + '/pvals/perm_cor_#.txt ' + str(n_boot) + ' -o ' + current_dir + '/pvals/pvals.two_sided.txt -t two_sided && ')
            f.write('rm -rf ' + current_dir + '/pvals/perm*')
            f.write('\n')

    print 'Created ' + str(n_samp) + ' sparcc subset commands for ' + input_fp

    for k in xrange(n_samp): 
        os.system('mkdir -p ' + working_dir + str(k) + '_removed/')
        resample_fp = working_dir + str(k) + '_removed/' + str(k)+ '_' + os.path.basename(input_fp)
        # sed to delete row
        # sed is 1 indexed, the top row is the header, hence the k + 2
        #os.system("sed " + str(k+2)+ "d " + input_fp + " > " + \
        #    resample_fp)
        os.system("cut -f " + str(k+2) + " --complement " + input_fp + " > " + resample_fp)

        # parse.subset_data(n_samp, transposed_fn, transposed_fp, working_dir)
 
    print 'Created ' + str(n_samp) + ' sparcc subsetted files for ' + input_fp
    
    print time.time() - start_time
    return

if __name__ == "__main__":
    make_sparcc_subsets()
