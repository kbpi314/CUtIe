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
@click.option('-c', '--corr_compare', type=str,
              help='boolean denoting whether performing cooksd or not')
@click.option('-w', '--working_dir', type=click.Path(exists=True),
              help='working dir to save results')
@click.option('-i', '--input_dir', type=click.Path(exists=True),
              help='input dir with .txt files of data')
@click.option('-o', '--output_dir', type=click.Path(exists=True),
              help='output dir to put config files')

def gen_commands_configs(fold_value, statistic, corr_compare, working_dir, input_dir, output_dir):
    fv = fold_value
    files = glob.glob(input_dir + '*.txt')
    for file in files:
        fn = os.path.basename(file)
        out_dir = output_dir + os.path.splitext(fn)[0] + '/'
        if not os.path.isdir(out_dir):
            os.makedirs(out_dir)
        with open(out_dir + 'config_' + fv + '_' + statistic + '_' + corr_compare + '_' + fn,'w') as f:
            f.write('[input]')
            f.write('\n')
            f.write('samp_var1_fp: ' + file)
            f.write('\n')
            f.write('delimiter1: \\t')
            f.write('\n')
            f.write('samp_var2_fp: ' + file)
            f.write('\n')
            f.write('delimiter2: \\t')
            f.write('\n')
            f.write('f1type: map')
            f.write('\n')
            f.write('f2type: map')
            f.write('\n')
            f.write('skip1: 0')
            f.write('\n')
            f.write('skip2: 0')
            f.write('\n')
            f.write('minep_fp: NA')
            f.write('\n')
            f.write('pskip: 13')
            f.write('\n')
            f.write('mine_delimiter: ,')
            f.write('\n')
            f.write('startcol1: -1')
            f.write('\n')
            f.write('endcol1: -1')
            f.write('\n')
            f.write('startcol2: -1')
            f.write('\n')
            f.write('endcol2: -1')
            f.write('\n')
            f.write('paired: True')
            f.write('\n')
            f.write('overwrite: True')
            f.write('\n')
            f.write('\n')
            f.write('[output]')
            f.write('\n')
            f.write('label: L6')
            f.write('\n')
            f.write('working_dir: ' + output_dir)
            f.write('\n')
            f.write('log_dir: ' + output_dir)
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
            f.write('mc: nomc')
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

        with open(out_dir + 'commands_' + fv + '_' + statistic + '_' + corr_compare + '_' + fn,'w') as f:
            f.write('export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.7/site-packages/ && python /sc/hydra/work/buk02/CUTIE/scripts/calculate_cutie.py -df /sc/hydra/work/buk02/CUTIE/scripts/config_defaults.ini -cf ' + out_dir + 'config_' + fv + '_' + statistic + '_' + corr_compare + '_' + fn)

if __name__ == "__main__":
    gen_commands_configs()
