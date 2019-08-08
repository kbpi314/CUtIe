import pandas as pd
import numpy as np
import scipy.stats
import matplotlib
matplotlib.use('Agg')
import matplotlib.pyplot as plt
import glob
import os
import seaborn as sns
import click

CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])

@click.command(context_settings=CONTEXT_SETTINGS)
@click.version_option(version='0.1')

# Required arguments
@click.option('-fv', '--fold_value', type=str,
              help='fold value for criterion for p value change')
@click.option('-s', '--statistic', type=str,
              help='string denoting type of analysis')
@click.option('-m', '--multi_corr', type=str,
              help='string denoting type of multiple corrections')
@click.option('-c', '--corr_compare', type=str,
              help='boolean denoting whether performing cooksd or not')
@click.option('-cl', '--classes', type=str,
              help='types of input classes')
@click.option('-nse', '--n_seed', type=str,
              help='number of seeds used')
@click.option('-nsa', '--n_samp', type=str,
              help='number of samples used')
@click.option('-rn', '--rangestr', type=str,
              help='start stop and step of corr')
@click.option('-i', '--input_dir', type=click.Path(exists=True),
              help='input dir with .txt files of data')
@click.option('-o', '--output_dir', type=click.Path(exists=True),
              help='output dir to put config files')


def analyze_simulations(fold_value, statistic, multi_corr, corr_compare, classes,
    n_seed, n_samp, rangestr, input_dir, output_dir):

    def parse_log(f, cookd):
        lines = [l.strip() for l in f.readlines()]
        defaulted = False
        if cookd:
            for l in lines:
                if "defaulted" in l:
                    defaulted = True
                elif "initial_corr" in l:
                    initial_corr = float(l.split(' ')[-1])
                elif "false correlations according to cookd" in l:
                    false_corr = float(l.split(' ')[-1])
                elif "true correlations according to cookd" in l:
                    true_corr = float(l.split(' ')[-1])
                elif "runtime" in l:
                    runtime = float(l.split(' ')[-1])
            rs_false = np.nan
            rs_true = np.nan

        else:
            # check if FDR correction defaulted
            for l in lines:
                if "defaulted" in l:
                    defaulted = True
                elif "initial_corr" in l:
                    initial_corr = float(l.split(' ')[-1])
                elif "false correlations" in l:
                    false_corr = float(l.split(' ')[-1])
                elif "true correlations" in l:
                    true_corr = float(l.split(' ')[-1])
                elif "FP/TN1" in l:
                    rs_false = float(l.split(' ')[-1])
                elif "TP/FN1" in l:
                    rs_true = float(l.split(' ')[-1])
                elif "runtime" in l:
                    runtime = float(l.split(' ')[-1])

        return defaulted, initial_corr, false_corr, true_corr, rs_false, rs_true, runtime

    start, stop, step = [float(x) for x in rangestr.split(',')]
    df_dict = {}
    for mc in multi_corr.split(','):
        df_dict[mc] = {}
        for fv in fold_value.split(','):
            df_dict[mc][fv] = {}
            for stat in statistic.split(','):
                df_dict[mc][fv][stat] = {}
                for cc in corr_compare.split(','):
                    df_dict[mc][fv][stat][cc] = {}
                    for seed in [str(x) for x in range(int(n_seed))]:
                        df_dict[mc][fv][stat][cc][seed] = {}
                        for c in classes.split(','):
                            df_dict[mc][fv][stat][cc][seed][c] = {}
                            for samp in n_samp.split(','):
                                df_dict[mc][fv][stat][cc][seed][c][samp] = {}
                                for cor in [str(int(x*1000)/1000) for x in np.arange(start, stop+step, step)]:
                                    df_dict[mc][fv][stat][cc][seed][c][samp][cor] = (np.nan, np.nan)


    file_dirs = glob.glob(input_dir + '*')
    missing = []
    done = []
    failed = []
    for f in file_dirs:
        subset_files = glob.glob(f + '/*.txt')
        subset_files.sort()
        fn = subset_files[-1]
        with open(fn,'r') as rf:
            label = f.split('/')[-1]
            try:
                defaulted, initial_corr, false_corr, true_corr, rs_false, rs_true, runtime = parse_log(rf, cookd=False)
                mc, fv, stat, cc, seed, c, samp, cor = label.split('_')
                df_dict[mc][fv][stat][cc][seed][c][samp][cor] = (true_corr, initial_corr)
            except:
                failed.append(label)

        if not subset_files:
            missing.append(f)
        else:
            done.append(f)

    missing.sort()
    # print([os.path.basename(x) for x in missing])
    mcs = []
    fvs = []
    stats = []
    ccs = []
    seeds = []
    class_labs = []
    nsamps = []
    cors = []
    results = []
    for mc in multi_corr.split(','):
        for fv in fold_value.split(','):
            for stat in statistic.split(','):
                for cc in corr_compare.split(','):
                    for seed in [str(x) for x in range(int(n_seed))]:
                        for c in classes.split(','):
                            for samp in n_samp.split(','):
                                for cor in [str(int(x*1000)/1000) for x in np.arange(start, stop+step, step)]:
                                    d = df_dict[mc][fv][stat][cc][seed][c][samp][cor]
                                    if not np.isnan(d[0]):
                                        if d[1] == 1:
                                            mcs.append(mc)
                                            fvs.append(fv)
                                            stats.append(stat)
                                            ccs.append(cc)
                                            seeds.append(seed)
                                            class_labs.append(c)
                                            nsamps.append(samp)
                                            cors.append(cor)
                                            results.append(d[0])

    results_df = pd.DataFrame({'mc': mcs, 'fv': fvs, 'stat': stats, 'cc': ccs,
        'seeds': seeds, 'class': class_labs, 'samps': nsamps, 'cors': cors,
        'results': results})

    # combined plot
    for mc in multi_corr.split(','):
        for fv in fold_value.split(','):
            for cc in corr_compare.split(','):
                for c in classes.split(','):
                    for samp in n_samp.split(','):
                        for cor in [str(int(x*1000)/1000) for x in np.arange(start, stop+step, step)]:
                            df = results_df[results_df['mc'] == mc]
                            df = df[df['fv'] == fv]
                            df = df[df['cc'] == cc]
                            df = df[df['class'] == c]
                            df = df[df['samps'] == samp]
                            try:
                                #cmap = sns.cubehelix_palette(as_cmap=True)
                                title = 'True_corr as a function of corr in ' + c
                                plt.figure(figsize=(4,4))
                                sns.set_style("white")
                                ax = sns.pointplot(x="cors", y="results",
                                    hue="stat",data=df, ci='sd',
                                    plot_kws=dict(alpha=0.3))
                                ax.set_title(title, fontsize=15)
                                plt.tick_params(axis='both', which='both', top=False, right=False)
                                sns.despine()
                                plt.savefig(output_dir + mc + '_' + fv + '_' + cc + '_' + c + '_' + samp + '.pdf')
                                plt.close()
                            except:
                                print(mc, fv, cc, c, samp, cor)

    # indiv plots
    for mc in multi_corr.split(','):
        for fv in fold_value.split(','):
            for stat in [ ['kpc','rpc'], ['ksc','rsc'], ['kkc', 'rkc'], ['mine','rmine'] ]:
                for cc in corr_compare.split(','):
                    for c in classes.split(','):
                        for samp in n_samp.split(','):
                            for cor in [str(int(x*1000)/1000) for x in np.arange(start, stop+step, step)]:
                                # try:
                                df = results_df[results_df['mc'] == mc]
                                df = df[df['fv'] == fv]
                                df = df[df['stat'].isin(stat)]
                                df = df[df['cc'] == cc]
                                df = df[df['class'] == c]
                                df = df[df['samps'] == samp]
                                # try:
                                    #cmap = sns.cubehelix_palette(as_cmap=True)
                                title = 'True_corr as a function of corr in ' + c
                                plt.figure(figsize=(4,4))
                                sns.set_style("white")
                                ax = sns.pointplot(x="cors", y="results", hue='stat',data=df, ci='sd')
                                ax.set_title(title, fontsize=15)
                                # plt.xlim(-0.1,1.1)
                                plt.ylim(-0.2,1.2)
                                plt.tick_params(axis='both', which='both', top=False, right=False)
                                sns.despine()
                                plt.savefig(output_dir + mc + '_' + fv + '_' + str(stat) + '_' + cc + '_' + c + '_' + samp + '.pdf')
                                plt.close()
                                #

    print(len(missing),len(done),len(failed))
    print(results_df.head())
    results_df.to_csv(output_dir + 'results_df.txt', sep='\t')

if __name__ == "__main__":
    analyze_simulations()




