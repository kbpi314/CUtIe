import glob
import os
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
@click.option('-w', '--working_dir', type=click.Path(exists=True),
              help='working dir to save results')
@click.option('-o', '--output_dir', type=click.Path(exists=True),
              help='output dir to put config files')

def gen_commands_configs(fold_value, statistic, multi_corr, corr_compare,
                         working_dir, output_dir):
    data_to_params = {
        'hdac': {
            'samp_var1_fp': '/sc/hydra/work/buk02/HDAC_data/GSE15222_series_matrix_x100.txt',
            'samp_var2_fp': '/sc/hydra/work/buk02/HDAC_data/GSE15222_series_matrix_x100.txt',
            'f1type': 'otu',
            'f2type': 'otu',
            'skip1': '62',
            'skip2': '62',
            'startcol1': '-1',
            'endcol1': '-1',
            'startcol2': '-1',
            'endcol2': '-1',
            'paired': 'True'},
        'lungc': {
            'samp_var1_fp': '/sc/hydra/work/buk02/pre_sparcc_MSQ/otu_table.MSQ34_L6.txt',
            'samp_var2_fp': '/sc/hydra/work/buk02/pre_sparcc_MSQ/otu_table.MSQ34_L6.txt',
            'f1type': 'otu',
            'f2type': 'otu',
            'skip1': '1',
            'skip2': '1',
            'startcol1': '-1',
            'endcol1': '-1',
            'startcol2': '-1',
            'endcol2': '-1',
            'paired': 'True'},
        'lungpt': {
            'samp_var1_fp': '/sc/hydra/work/buk02/lungpt_data/otu_table_MultiO_merged___L6.txt',
            'samp_var2_fp': '/sc/hydra/work/buk02/lungpt_data/Mapping.Pneumotype.Multiomics.RL.NYU.w_metabolites.w_inflamm.txt',
            'f1type': 'otu',
            'f2type': 'map',
            'skip1': '1',
            'skip2': '0',
            'startcol1': '-1',
            'endcol1': '-1',
            'startcol2': '17',
            'endcol2': '100',
            'paired': 'False'},
        'who': {
            'samp_var1_fp': '/sc/hydra/work/buk02/MINE_data/WHOfix.txt',
            'samp_var2_fp': '/sc/hydra/work/buk02/MINE_data/WHOfix.txt',
            'f1type': 'map',
            'f2type': 'map',
            'skip1': '0',
            'skip2': '0',
            'startcol1': '3',
            'endcol1': '357',
            'startcol2': '3',
            'endcol2': '357',
            'paired': 'True'}}

    fv = fold_value
    # files = glob.glob(input_dir + '*.txt')

    datasets = ['hdac','lungc','lungpt','who']
    for data in datasets:
        param_to_str = data_to_params[data]

        # for fp in files:
        # fn = os.path.basename(fp)
        f_id = multi_corr + '_' + fv + '_' + statistic + '_' + corr_compare + '_' + data
        # output_dir = '/sc/hydra/work/buk02/real_data_analysis/'
        out_dir = output_dir + f_id + '/'
        try:
            os.makedirs(out_dir)
        except:
            pass
        # working_dir = '/sc/hydra/scratch/buk02/real_data_analysis/'
        working_outdir = working_dir + f_id + '/'
        try:
            os.makedirs(working_outdir)
        except:
            pass
        with open(out_dir + 'config_' + f_id + '.txt','w') as f:
            f.write('[input]')
            f.write('\n')
            f.write('samp_var1_fp: ' + param_to_str['samp_var1_fp'])
            f.write('\n')
            f.write('delimiter1: \\t')
            f.write('\n')
            f.write('samp_var2_fp: ' + param_to_str['samp_var2_fp'])
            f.write('\n')
            f.write('delimiter2: \\t')
            f.write('\n')
            f.write('f1type: ' + param_to_str['f1type'])
            f.write('\n')
            f.write('f2type: ' + param_to_str['f2type'])
            f.write('\n')
            f.write('skip1: ' + param_to_str['skip1'])
            f.write('\n')
            f.write('skip2: ' + param_to_str['skip2'])
            f.write('\n')
            f.write('minep_fp: NA')
            f.write('\n')
            f.write('pskip: 13')
            f.write('\n')
            f.write('mine_delimiter: ,')
            f.write('\n')
            f.write('startcol1: ' + param_to_str['startcol1'])
            f.write('\n')
            f.write('endcol1: ' + param_to_str['endcol1'])
            f.write('\n')
            f.write('startcol2: ' + param_to_str['startcol2'])
            f.write('\n')
            f.write('endcol2: ' + param_to_str['endcol2'])
            f.write('\n')
            f.write('paired: ' + param_to_str['paired'])
            f.write('\n')
            f.write('overwrite: True')
            f.write('\n')
            f.write('\n')
            f.write('[output]')
            f.write('\n')
            f.write('label: L6')
            f.write('\n')
            f.write('working_dir: ' + working_outdir)
            f.write('\n')
            f.write('log_dir: ' + working_outdir)
            f.write('\n')
            f.write('\n')
            f.write('[stats]')
            f.write('\n')
            f.write('statistic: ' + statistic)
            f.write('\n')
            f.write('resample_k: 1')
            f.write('\n')
            f.write('alpha: 0.05')
            f.write('\n')
            f.write('mc: ' + multi_corr)
            f.write('\n')
            f.write('fold: True')
            f.write('\n')
            f.write('fold_value: ' + fv)
            f.write('\n')
            f.write('n_replicates: 1000')
            f.write('\n')
            f.write('log_transform1: False')
            f.write('\n')
            f.write('log_transform2: False')
            f.write('\n')
            f.write('ci_method: none')
            f.write('\n')
            f.write('sim: False')
            f.write('\n')
            f.write('corr_compare: ' + corr_compare)
            f.write('\n')
            f.write('corr_path: NA')
            f.write('\n')
            f.write('\n')
            f.write('[graph]')
            f.write('\n')
            f.write('graph_bound: 30')
            f.write('\n')
            f.write('fix_axis: False')

        with open(out_dir + 'commands_' + f_id + '.txt','w') as f:
            f.write('export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.7/site-packages/ && python /sc/hydra/work/buk02/CUTIE/scripts/calculate_cutie.py -df /sc/hydra/work/buk02/CUTIE/scripts/config_defaults.ini -cf ' + out_dir + 'config_' + f_id + '.txt')

if __name__ == "__main__":
    gen_commands_configs()
