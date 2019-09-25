import pandas as pd
import numpy as np
import glob
np.random.seed(0)
import seaborn as sns; sns.set()
import matplotlib.pyplot as plt
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
@click.option('-i', '--input_dir', type=click.Path(exists=True),
              help='input dir with .txt files of data')
@click.option('-o', '--output_dir', type=click.Path(exists=True),
              help='output dir to put config files')


def analyze_simulations_real(fold_value, statistic, multi_corr, corr_compare,
                             input_dir, output_dir):
    '''
    Script for analysis of real data by CUTIE
    '''

    def parse_log(f, cookd):
        lines = [l.strip() for l in f.readlines()]
        defaulted = False
        if cookd == 'True':
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


    headers = [
        'analysis_id',
        'distribution',
        'statistic',
        'mc_used', #NEW
        'fold_value', # NEW
        'pointwise', #NEW
        'defaulted', # binary
        'initial_corr',
        'true_corr(TP_FN)',
        'false_corr(FP_TN)',
        'rs_true_corr_TP_FN',
        'rs_false_corr_FP_TN',
        'runtime'
    ]

    for_df = pd.DataFrame()

    mcs = multi_corr.split(',')
    fvs = fold_value.split(',')
    stats = statistic.split(',')
    cds = corr_compare.split(',')
    ds = ['lungpt','lungc','who','hdac']
    for mc in mcs:
        for fv in fvs:
            for s in stats:
                for cd in cds:
                    for d in ds:
                        # nomc_10_pearson_True_lungpt
                        analysis_id = '_'.join([mc, fv, s, cd, d])
                        path = input_dir + analysis_id + '/'
                        files = sorted(glob.glob(path + '*.txt'))
                        # grab most recent log file
                        try:
                            rel_logfile = files[-1]
                            with open(rel_logfile, 'r') as f:
                                #try:
                                defaulted, initial_corr, false_corr, true_corr, rs_false, rs_true, runtime = parse_log(f,cd)

                                new_row = pd.DataFrame([[analysis_id, d, s,
                                                        mc, fv, cd,
                                                        defaulted, initial_corr, true_corr, false_corr, rs_true, rs_false, runtime]], columns=headers)

                                for_df = for_df.append(new_row)
                                #except:
                                #    print(analysis_id)
                        except:
                            if cd == 'True':
                                if s == 'pearson':
                                    print(analysis_id)
                            else:
                                print(analysis_id)



    header = [
        'Micrometa',
        'Microbiome',
        'Gene Expression',
        'WHO'
    ]

    index1 = [
        'Pearson_cd_nomc',
        '% initial sig',
        'Pearson_fv1_nomc',
        '% initial sig',
        'Pearson_fv10_nomc',
        '% initial sig']

    ids1 = ['nomc_1_pearson_True',
            'nomc_1_pearson_False',
            'nomc_10_pearson_False']

    index2 = [
        'Pearson_cd_fdr',
        '% initial sig',
        'Pearson_fv1_fdr',
        '% initial sig',
        'Pearson_fv10_fdr',
        '% initial sig']

    ids2 = ['fdr_1_pearson_True',
            'fdr_1_pearson_False',
            'fdr_10_pearson_False']

    index3 = [
        'Pearson_cd_nomc',
        '% initial sig',
        'Pearson_fv1_nomc',
        '% initial sig',
        'Pearson_fv10_nomc',
        '% initial sig',
        'Spearman_fv1_nomc',
        '% initial sig',
        'Spearman_fv10_nomc',
        '% initial sig',
        'Kendall_fv1_nomc',
        '% initial sig',
        'Kendall_fv10_nomc',
        '% initial sig']
    ids3 = ['nomc_1_pearson_True',
            'nomc_1_pearson_False',
            'nomc_10_pearson_False',
            'nomc_1_spearman_False',
            'nomc_10_spearman_False',
            'nomc_1_kendall_False',
            'nomc_10_kendall_False']

    index4 = [
        'Pearson_cd_fdr',
        '% initial sig',
        'Pearson_fv1_fdr',
        '% initial sig',
        'Pearson_fv10_fdr',
        '% initial sig',
        'Spearman_fv1_fdr',
        '% initial sig',
        'Spearman_fv10_fdr',
        '% initial sig',
        'Kendall_fv1_fdr',
        '% initial sig',
        'Kendall_fv10_fdr',
        '% initial sig']

    ids4 = ['fdr_1_pearson_True',
            'fdr_1_pearson_False',
            'fdr_10_pearson_False',
            'fdr_1_spearman_False',
            'fdr_10_spearman_False',
            'fdr_1_kendall_False',
            'fdr_10_kendall_False']

    index5 = [
        'Pearson_fv1_nomc',
        '% initial insig',
        'Pearson_fv10_nomc',
        '% initial insig',
        'Spearman_fv1_nomc',
        '% initial insig',
        'Spearman_fv10_nomc',
        '% initial insig',
        'Kendall_fv1_nomc',
        '% initial insig',
        'Kendall_fv10_nomc',
        '% initial insig']

    ids5 = ['nomc_1_rpearson_False',
            'nomc_10_rpearson_False',
            'nomc_1_rspearman_False',
            'nomc_10_rspearman_False',
            'nomc_1_rkendall_False',
            'nomc_10_rkendall_False']

    index6 = [
        'Pearson_fv1_fdr',
        '% initial insig',
        'Pearson_fv10_fdr',
        '% initial insig',
        'Spearman_fv1_fdr',
        '% initial insig',
        'Spearman_fv10_fdr',
        '% initial insig',
        'Kendall_fv1_fdr',
        '% initial insig',
        'Kendall_fv10_fdr',
        '% initial insig']

    ids6 = ['fdr_1_rpearson_False',
            'fdr_10_rpearson_False',
            'fdr_1_rspearman_False',
            'fdr_10_rspearman_False',
            'fdr_1_rkendall_False',
            'fdr_10_rkendall_False']

    index7 = [
        'Pearson_cd_fdr',
        '% initial sig',
        'Pearson_fv10_fdr',
        '% initial sig',
        'Spearman_fv10_fdr',
        '% initial sig',
        'Kendall_fv10_fdr',
        '% initial sig']

    ids7 = ['fdr_1_pearson_True',
            'fdr_10_pearson_False',
            'fdr_10_spearman_False',
            'fdr_10_kendall_False']

    index8 = [
        'Pearson_fv10_fdr',
        '% initial insig',
        'Spearman_fv10_fdr',
        '% initial insig',
        'Kendall_fv10_fdr',
        '% initial insig']

    ids8 = ['fdr_10_rpearson_False',
            'fdr_10_rspearman_False',
            'fdr_10_rkendall_False']




    id_sets = [ids1, ids2, ids3, ids4, ids5, ids6, ids7, ids8]
    indices = [index1, index2, index3, index4, index5, index6, index7, index8]

    dists = ['lungpt', 'lungc', 'hdac', 'who']
    # method = ['cutie','cookd']# 'jackknife', 'bootstrap', 'cookd']
    dist_to_corr = {
        'lungpt': 83 * 897,
        'lungc': 748 * 747 / 2,
        'hdac': 100 * 99 / 2,
        'who': 354 * 353 / 2
    }

    fv_to_id_for = {}
    fv_to_in_for = {}
    fv_to_id_rev = {}
    fv_to_in_rev = {}
    fvs = [1, 2, 3, 5, 10]
    for f in fvs:
        f = str(f)

        index_x = [
            'Pearson_fv' + f + '_fdr',
            '% initial sig',
            'Spearman_fv' + f + '_fdr',
            '% initial sig',
            'Kendall_fv' + f + '_fdr',
            '% initial sig']

        ids_x = ['fdr_' + f + '_pearson_False',
                'fdr_' + f + '_spearman_False',
                'fdr_' + f + '_kendall_False']

        index_y = [
            'Pearson_fv' + f + '_fdr',
            '% initial insig',
            'Spearman_fv' + f + '_fdr',
            '% initial insig',
            'Kendall_fv' + f + '_fdr',
            '% initial insig']

        ids_y = ['fdr_' + f + '_rpearson_False',
                'fdr_' + f + '_rspearman_False',
                'fdr_' + f + '_rkendall_False']

        id_sets.extend([ids_x, ids_y])
        indices.extend([index_x, index_y])
        fv_to_id_for[f] = ids_x
        fv_to_in_for[f] = index_x
        fv_to_id_rev[f] = ids_y
        fv_to_in_rev[f] = index_y

    fv_to_df_for = {}
    fv_to_df_rev = {}

    new_dfs = []
    for i in range(len(id_sets)):
        id_set = id_sets[i]
        df_array = []
        for idstring in id_set:
            # stat = 'Pearson'
            row_fracs = []
            mc, fv, s, cd = idstring.split('_')
            for dist in dists:
                row = for_df[(for_df['distribution'] == dist) & (for_df['statistic'] == s) \
                             & (for_df['mc_used'] == mc) & (for_df['fold_value'] == fv) & (for_df['pointwise'] == cd)]
                try:
                    row_fracs.append(float(row['true_corr(TP_FN)'] /row['initial_corr'].values)) # correctly id tp
                except:
                    row_fracs.append(np.nan)
                    print(dist, idstring)

            df_array.append(row_fracs)

            initial_sig_fracs = []
            for dist in dists:
                row = for_df[(for_df['distribution'] == dist) & (for_df['statistic'] == s) \
                             & (for_df['mc_used'] == mc) & (for_df['fold_value'] == fv) & (for_df['pointwise'] == cd)]
                # change number 249500 to n_corr depending on dataset
                try:
                    initial_sig_fracs.append(float(row['initial_corr'] / dist_to_corr[dist]))
                except:
                    initial_sig_fracs.append(np.nan)

            df_array.append(initial_sig_fracs)

        new_df = pd.DataFrame(data = df_array, index = indices[i], columns = header)
        new_df = new_df.rename_axis('Statistic')
        new_dfs.append(new_df)

    new_dfs[6].to_csv(output_dir + 'real_tpfp.csv', index = True)
    new_dfs[7].to_csv(output_dir + 'real_tnfn.csv', index = True)

    # df_real_tpfp = pd.read_csv('/Users/KevinBu/Desktop/clemente_lab/Submissions/CUtIe/final_data_fixed/real_tpfp.csv', sep = ',')
    df_real_tpfp = new_dfs[6]
    # df_real_tpfp = df_real_tpfp.iloc[0:16].set_index('Statistic')
    # df_real_tnfn = pd.read_csv('/Users/KevinBu/Desktop/clemente_lab/Submissions/CUtIe/final_data_fixed/real_tnfn.csv', sep = ',')
    df_real_tnfn = new_dfs[7]
    # df_real_tnfn = df_real_tnfn.iloc[0:16].set_index('Statistic')
    df_real_tnfn = df_real_tnfn.apply(pd.to_numeric).round(2)
    df_real_tpfp = df_real_tpfp.apply(pd.to_numeric).round(2)

    colnames = df_real_tpfp.columns.values
    print(colnames)

    # TN FN TP FP combined no micrometa no cd no rs
    fv_to_df_for = {}
    fv_to_df_rev = {}

    for i, fv in enumerate(fvs):
        fv = str(fv)
        fv_to_df_for[fv] = new_dfs[8:][2*i]
        fv_to_df_rev[fv] = new_dfs[8:][2*i+1]

    for i, fv in enumerate(fvs):
        fv = str(fv)

        df = fv_to_df_for[fv].drop(['Micrometa'],axis=1)
        current_colnames = colnames[1::]
        vals = list(df.index.values)
        new_vals = vals[0::2]
        dd = {}
        for v in new_vals:
            dd[v] = {}

        for v in new_vals:
            rows = df.iloc[vals.index(v):vals.index(v)+2,:].values
            dd[v]['TP'] = rows[0]
            dd[v]['initial_sig'] = rows[1]

        df = fv_to_df_rev[fv].drop(['Micrometa'],axis=1)
        vals = list(df.index.values)
        new_vals = vals[0::2]
        for v in new_vals:
            rows = df.iloc[vals.index(v):vals.index(v)+2,:].values
            dd[v]['FN'] = rows[0]
            dd[v]['initial_insig'] = rows[1]



        plt.figure(figsize=(30,20))
        f, axarr = plt.subplots(len(new_vals),len(current_colnames))
        # fig, ax = plt.subplots(len(new_vals),len(colnames))

        new_vals = ['Pearson_fv' + fv + '_fdr', 'Spearman_fv' + fv + '_fdr', 'Kendall_fv' + fv + '_fdr']

        for d in range(len(current_colnames)):
            for v in range(len(new_vals)):
                val = new_vals[v]
                labels = ['TP', 'FP', 'FN', 'TN']
                # TP is blue FP is red FN is green TN is purple
                colors = ['#66b3ff','#ff9999','#99ff99','#8064A2']
                TP = dd[val]['TP'][d]
                P = dd[val]['initial_sig'][d]
                FN = dd[val]['FN'][d]
                N = dd[val]['initial_insig'][d]
                sizes = [TP * P, (1-TP)*P, FN * N, (1-FN)*N]
                # print(sizes,sum(sizes))

                # plt.subplot(len(new_vals),len(colnames),i)
                # fig1, ax1 = plt.g()
                axs = axarr[v, d]
                # title = colnames[d] + ', ' + val.split('_')[0] + '\n' + str(int(dist_to_corr[colnames[d]]))
                # axs.set_title(title)
                patches, texts, autotexts = axs.pie(sizes, colors = colors, labels=None, autopct='%1.1f%%', startangle=0,
                                                   labeldistance = 1, pctdistance = 1.2)
                #plt.legend(patches, autotexts, loc='center left', bbox_to_anchor=(-0.1, 1.),fontsize=8)
                fs = 12
                ts = 12
                #patches[0].set_fontsize(fs)
                #patches[1].set_fontsize(fs)
                #patches[2].set_fontsize(fs)
                texts[0].set_fontsize(fs)
                texts[1].set_fontsize(fs)
                texts[2].set_fontsize(fs)
                texts[3].set_fontsize(fs)
                autotexts[0].set_fontsize(ts)
                autotexts[1].set_fontsize(ts)
                autotexts[2].set_fontsize(ts)
                autotexts[3].set_fontsize(ts)

                #draw circle
                centre_circle = plt.Circle((0,0),0.50,fc='white')
                fig = plt.gcf()
                fig.set_size_inches(10,10)
                #fig.gca().add_artist(centre_circle)
                axs.add_artist(centre_circle)
                # Equal aspect ratio ensures that pie is drawn as a circle
                axs.axis('equal')
                plt.tight_layout()
                #plt.show()

        f.savefig(output_dir + 'pieplots_dfreal_combined_nomicrometa_nocd_' + fv + '.pdf')
        plt.close(fig)

    # Reverse sign stuffs
    id_sets = id_sets[8:]
    indices = indices[8:]
    new_dfs2 = []
    for i in range(len(id_sets)):
        id_set = id_sets[i]
        df_array = []
        for idstring in id_set:
            # stat = 'Pearson'
            row_fracs = []
            mc, fv, s, cd = idstring.split('_')
            for dist in dists:
                row = for_df[(for_df['distribution'] == dist) & (for_df['statistic'] == s) \
                             & (for_df['mc_used'] == mc) & (for_df['fold_value'] == fv) & (for_df['pointwise'] == 'False')]
                try:
                    row_fracs.append(float(row['rs_true_corr_TP_FN'] /row['initial_corr'].values)) # correctly id tp
                except:
                    row_fracs.append(np.nan)
                    print(dist, idstring)

            df_array.append(row_fracs)

            initial_sig_fracs = []
            for dist in dists:
                row = for_df[(for_df['distribution'] == dist) & (for_df['statistic'] == s) \
                             & (for_df['mc_used'] == mc) & (for_df['fold_value'] == fv) & (for_df['pointwise'] == 'False')]
                # change number 249500 to n_corr depending on dataset
                try:
                    initial_sig_fracs.append(float(row['initial_corr'] / dist_to_corr[dist]))
                except:
                    initial_sig_fracs.append(np.nan)

            df_array.append(initial_sig_fracs)

        new_df = pd.DataFrame(data = df_array, index = indices[i], columns = header)
        new_df = new_df.rename_axis('Statistic')
        new_dfs2.append(new_df)

    # RS sign no micrometa
    fv_to_df_rsfor = {}
    fv_to_df_rsrev = {}

    for i, fv in enumerate(fvs):
        fv = str(fv)
        fv_to_df_rsfor[fv] = new_dfs2[2*i]
        fv_to_df_rsrev[fv] = new_dfs2[2*i+1]

    for i, fv in enumerate(fvs):
        fv = str(fv)

        df = fv_to_df_rsfor[fv].drop(['Micrometa'],axis=1)
        vals = list(df.index.values)
        new_vals = vals[0::2]
        dd = {}
        for v in new_vals:
            dd[v] = {}

        for v in new_vals:
            rows = df.iloc[vals.index(v):vals.index(v)+2,:].values
            dd[v]['rsTP'] = rows[0]

        df = fv_to_df_for[fv].drop(['Micrometa'],axis=1)#.iloc[2:,:]
        for v in new_vals:
            rows = df.iloc[vals.index(v):vals.index(v)+2,:].values
            dd[v]['TP'] = rows[0]
            dd[v]['initial_sig'] = rows[1]


        df = fv_to_df_rev[fv].drop(['Micrometa'],axis=1)
        vals = list(df.index.values)
        new_vals = vals[0::2]
        for v in new_vals:
            rows = df.iloc[vals.index(v):vals.index(v)+2,:].values
            dd[v]['FN'] = rows[0]
            dd[v]['initial_insig'] = rows[1]

        df = fv_to_df_rsrev[fv].drop(['Micrometa'],axis=1)#[1]
        for v in new_vals:
            rows = df.iloc[vals.index(v):vals.index(v)+2,:].values
            dd[v]['rsFN'] = rows[0]


        i = 1
        plt.figure(figsize=(30,20))
        # subset on micrometa
        new_colnames = colnames[1:]
        f, axarr = plt.subplots(len(new_vals),len(new_colnames))
        # fig, ax = plt.subplots(len(new_vals),len(colnames))

        new_vals = ['Pearson_fv' + fv + '_fdr', 'Spearman_fv' + fv + '_fdr', 'Kendall_fv' + fv + '_fdr']

        for d in range(len(new_colnames)):
            for v in range(len(new_vals)):
                val = new_vals[v]
                # labels = ['TP', 'rsTP', 'FP', 'FN', 'rsFN', 'TN']
                labels = ['TP', 'rsTP', 'FP', 'FN', 'TN']
                # TP is blue FP is red FN is green TN is purple
                # for rs case
                # reverse sign but still true FP is non reverse sign
                colors = ['#66b3ff','#ADD8E6','#ff9999','#99ff99','#8064A2']
                TP = dd[val]['TP'][d]
                rsTP = dd[val]['rsTP'][d]
                P = dd[val]['initial_sig'][d]
                FN = dd[val]['FN'][d]
                rsFN = dd[val]['rsFN'][d]
                N = dd[val]['initial_insig'][d]
                # sizes = [(TP - rsTP) * P, rsTP * P,(1-TP)*P, (FN - rsFN) * N, rsFN * N, (1-FN)*N]
                sizes = [(TP - rsTP) * P, rsTP * P,(1-TP)*P, FN * N, (1-FN)*N]
                # print(sizes,sum(sizes))

                # plt.subplot(len(new_vals),len(colnames),i)
                # fig1, ax1 = plt.g()
                axs = axarr[v, d]
                # title = colnames[d] + ', ' + val.split('_')[0] + '\n' + str(int(dist_to_corr[colnames[d]]))
                # axs.set_title(title)

                # def draw_pie(sizes, colors):
                patches, texts, autotexts = axs.pie(sizes, colors = colors, labels=None, autopct='%1.1f%%', startangle=0,
                                                   labeldistance = 1, pctdistance = 1.2)
                #plt.legend(patches, autotexts, loc='center left', bbox_to_anchor=(-0.1, 1.),fontsize=8)
                fs = 12
                ts = 12
                #patches[0].set_fontsize(fs)
                #patches[1].set_fontsize(fs)
                #patches[2].set_fontsize(fs)
                texts[0].set_fontsize(fs)
                texts[1].set_fontsize(fs)
                texts[2].set_fontsize(fs)
                texts[3].set_fontsize(fs)
                texts[4].set_fontsize(fs)
                autotexts[0].set_fontsize(ts)
                autotexts[1].set_fontsize(ts)
                autotexts[2].set_fontsize(ts)
                autotexts[3].set_fontsize(ts)
                autotexts[4].set_fontsize(ts)

                #draw circle
                centre_circle = plt.Circle((0,0),0.50,fc='white')
                fig = plt.gcf()
                fig.set_size_inches(10,10)
                #fig.gca().add_artist(centre_circle)
                axs.add_artist(centre_circle)
                # Equal aspect ratio ensures that pie is drawn as a circle
                axs.axis('equal')
                plt.tight_layout()
                #plt.show()

        f.savefig(output_dir + 'pieplots_rs_dfreal_combined_nocd_' + fv + '.pdf')
        plt.close(fig)

    # FOR COOKSD
    df = df_real_tpfp
    vals = list(df.index.values)
    new_vals = vals[0::2]
    dd = {}
    for v in new_vals:
        dd[v] = {}

    for v in new_vals:
        rows = df.iloc[vals.index(v):vals.index(v)+2,:].values
        dd[v]['TP'] = rows[0]
        dd[v]['initial_sig'] = rows[1]

    df = df_real_tnfn
    vals = list(df.index.values)
    new_vals = vals[0::2]
    for v in new_vals:
        rows = df.iloc[vals.index(v):vals.index(v)+2,:].values
        dd[v]['FN'] = rows[0]
        dd[v]['initial_insig'] = rows[1]



    i = 1
    plt.figure(figsize=(40,20))
    f, axarr = plt.subplots(len(new_vals) + 1,len(colnames))
    # fig, ax = plt.subplots(len(new_vals),len(colnames))

    new_vals = ['Pearson_fv10_fdr', 'Spearman_fv10_fdr', 'Kendall_fv10_fdr']

    for d in range(len(colnames)):
        val = 'Pearson_cd_fdr'
        labels = ['TP', 'FP', 'N']
        colors = ['#66b3ff','#ff9999','#FFC000']#,'#ffcc99']
        TP = dd[val]['TP'][d]
        P = dd[val]['initial_sig'][d]
        sizes = [TP * P, (1-TP)*P,1-P]
        # print(sizes,sum(sizes))

        # plt.subplot(len(new_vals),len(colnames),i)
        # fig1, ax1 = plt.g()
        axs = axarr[0, d]
        if val.split('_')[1] == 'cd':
            title = colnames[d] + ', ' + 'Cook\'s D' + '\n' + str(int(dist_to_corr[colnames[d]]))
        else:
            title = colnames[d] + ', ' + val.split('_')[0] # + '\n' + str(int(dist_to_corr[colnames[d]]))
        axs.set_title(title)
        patches, texts, autotexts = axs.pie(sizes, colors = colors, labels=None, autopct='%1.1f%%', startangle=0,
                                           labeldistance = 1, pctdistance = 1.2)
        #plt.legend(patches, autotexts, loc='center left', bbox_to_anchor=(-0.1, 1.),fontsize=8)
        fs = 12
        ts = 12
        #patches[0].set_fontsize(fs)
        #patches[1].set_fontsize(fs)
        #patches[2].set_fontsize(fs)
        texts[0].set_fontsize(fs)
        texts[1].set_fontsize(fs)
        texts[2].set_fontsize(fs)
        autotexts[0].set_fontsize(ts)
        autotexts[1].set_fontsize(ts)
        autotexts[2].set_fontsize(ts)

        #draw circle
        centre_circle = plt.Circle((0,0),0.50,fc='white')
        fig = plt.gcf()
        fig.set_size_inches(10,10)
        #fig.gca().add_artist(centre_circle)
        axs.add_artist(centre_circle)
        # Equal aspect ratio ensures that pie is drawn as a circle
        axs.axis('equal')
        plt.tight_layout()
        #plt.show()

        for v in range(len(new_vals)):
            val = new_vals[v]
            labels = ['TP', 'FP', 'TN', 'FN']
            # TP is blue FP is red FN is green TN is purple
            colors = ['#66b3ff','#ff9999','#99ff99','#8064A2']
            TP = dd[val]['TP'][d]
            P = dd[val]['initial_sig'][d]
            FN = dd[val]['FN'][d]
            N = dd[val]['initial_insig'][d]
            sizes = [TP * P, (1-TP)*P, FN * N, (1-FN)*N]
            # print(sizes,sum(sizes))

            # plt.subplot(len(new_vals),len(colnames),i)
            # fig1, ax1 = plt.g()
            axs = axarr[v + 1, d]
            title = colnames[d] + ', ' + val.split('_')[0] + '\n' + str(int(dist_to_corr[colnames[d]]))
            axs.set_title(title)
            patches, texts, autotexts = axs.pie(sizes, colors = colors, labels=None, autopct='%1.1f%%', startangle=0,
                                               labeldistance = 1, pctdistance = 1.2)
            #plt.legend(patches, autotexts, loc='center left', bbox_to_anchor=(-0.1, 1.),fontsize=8)
            fs = 12
            ts = 12
            #patches[0].set_fontsize(fs)
            #patches[1].set_fontsize(fs)
            #patches[2].set_fontsize(fs)
            texts[0].set_fontsize(fs)
            texts[1].set_fontsize(fs)
            texts[2].set_fontsize(fs)
            autotexts[0].set_fontsize(ts)
            autotexts[1].set_fontsize(ts)
            autotexts[2].set_fontsize(ts)

            #draw circle
            centre_circle = plt.Circle((0,0),0.50,fc='white')
            fig = plt.gcf()
            fig.set_size_inches(10,10)
            #fig.gca().add_artist(centre_circle)
            axs.add_artist(centre_circle)
            # Equal aspect ratio ensures that pie is drawn as a circle
            axs.axis('equal')
            plt.tight_layout()
            #plt.show()
            i += 1

    f.savefig(output_dir + 'pieplots_dfreal_combined.pdf')
    plt.close(fig)


if __name__ == "__main__":
    analyze_simulations_real()




