from cutie import parse
from cutie import output

import numpy as np
from numpy.random import seed
import pandas as pd

import os

from scipy.stats.distributions import gamma, lognorm, norm
from scipy.linalg import toeplitz

for i in xrange(5):
    seed(i)
    n1 = 1000
    n_otu = 1000
    dep_top = toeplitz(np.arange(1.0, -1.0, -2.0/n_otu))
    mean = np.zeros(n_otu)
    cov = dep_top
    full = np.random.multivariate_normal(mean, cov, n1).T
    header = [str(x) for x in range(n1)]
    output.print_matrix(full, 'data/test_new.txt', header)
    df = pd.read_csv('data/test_new.txt', delimiter = '\t')
    df = df.loc[:, ~df.columns.str.contains('^Unnamed')]
    df1 = pd.DataFrame(df.iloc[0]).T
    df2 = df.iloc[1:n_otu]
    df1.to_csv('data/test_var1.txt',sep='\t')
    df2.to_csv('data/test_var2.txt',sep='\t')
    top_df = pd.DataFrame(dep_top)
    top_df = top_df.iloc[0]
    top_df.to_csv('data/top_df.txt', sep='\t', index=False)
    os.system('mkdir data_analysis/new_sim_test_' + str(i) + '_kpc1fdr0.05/')
    os.system('python -W ignore scripts/calculate_cutie.py -df scripts/config_defaults.ini -cf scripts/new_sim_config_' + str(i)+'.ini')

    '''
    mkdir data_analysis/new_sim_test_kpc1fdr0.05/
    python -W ignore scripts/calculate_cutie.py -df scripts/config_defaults.ini -cf scripts/new_sim_config.ini

    '''