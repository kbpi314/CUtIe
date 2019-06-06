#!/usr/bin/env python
# File created on 30 May 2013
from __future__ import division

__author__ = "Jose Carlos Clemente Litran"
__copyright__ = "Copyright 2011, The QIIME project"
__credits__ = ["Jose Carlos Clemente Litran"]
__license__ = "GPL"
__version__ = "1.5.0-dev"
__maintainer__ = "Jose Carlos Clemente Litran"
__email__ = "jose.clemente@gmail.com"
__status__ = "Development"

import click
import os

CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])

@click.command(context_settings=CONTEXT_SETTINGS)
@click.version_option(version='0.1')

# Required arguments
@click.option('-c', '--commands_fp', type=click.Path(exists=True),
              help='Filepath with list of commands, one per line',
              required=True)
@click.option('-N', '--job_name', default='job',
              help='Job name prefix', required=True)

# Optional arguments
@click.option('-o', '--output_fp',type=click.Path(writable=True),
              help='Output directory for the lsf files', default='jobs',
              required=False)
@click.option('-w', '--walltime', default='6:00',
              help='Maximum walltime', required=False)
@click.option('-p', '--allocation', default='acc_clemej05a',
              help='Name of allocation for submission', required=False)
@click.option('-n', '--num_cores', default=1,
              help='Number of cores for main job', required=False)
@click.option('-k', '--num_cores_workers', default=1,
              help='Number of cores for worker jobs', required=False)
@click.option('-q', '--queue',default='premium',
                help='Queue to submit main job', required=False)
@click.option('-Q', '--sec_queue', default='alloc',
                help='Queue to submit worker jobs', required=False)
@click.option('-m', '--modules', default='qiime',
              help='Module(s) to load, comma-separated', required=False)
@click.option('-s', '--submit', default=False,
              help='Submit jobs', required=False)
@click.option('--submit', 'submit', is_flag=True,
                flag_value=True,
              required=False, help='True if submitting')

def split_commands(commands_fp, walltime, job_name, allocation,
                   num_cores, num_cores_workers, output_fp, modules,
                   queue, sec_queue, submit):
    """
    """

    # Should be fine even without check
    if not os.path.exists(output_fp):
        os.makedirs(output_fp)

    module_list = modules.split(',')
    if versions:
        version_list = versions.split(',')
    else:
        version_list = []

    i = 0
    fc = open(commands_fp)
    for line in fc:
        out_fname = job_name + "." + str(i)
        out_fp = open(output_fp + "/" + out_fname, 'w')
        out_fp.write('#!/bin/bash\n')
        out_fp.write('#BSUB -q ' + queue + '\n')
        out_fp.write('#BSUB -W ' + walltime + '\n')
        out_fp.write('#BSUB -J ' + out_fname + '\n')
        out_fp.write('#BSUB -P ' + allocation + '\n')
        out_fp.write('#BSUB -B\n')
        out_fp.write('#BSUB -n ' + str(num_cores) + '\n')
        out_fp.write('#BSUB -R \"span[hosts=1]\"\n')
        out_fp.write('#BSUB -o %J.stdout\n')
        out_fp.write('#BSUB -eo %J.stderr\n')
        out_fp.write('#BSUB -L /bin/bash\n')
        out_fp.write('\n')
        if len(module_list) >= 1:
            if len(version_list) == len(module_list):
                for v in zip(module_list, version_list):
                    out_fp.write('module load ' + v[0] + '/' + v[1] + '\n')
            else:
                for m in module_list:
                    out_fp.write('module load ' + m + '\n')
        else:
            out_fp.write('module load ' + module_list[0] + '\n')
        out_fp.write('\n')
        out_fp.write('export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.7/site-packages/' + '\n')
        out_fp.write('\n')
        out_fp.write(line)
        i += 1
        out_fp.close()
        if submit:
            if os.path.exists(output_fp):
                command = "cd " + output_fp + ";bsub <" + out_fname + "; cd .."
                os.system(command)
            else:
                os.system("bsub <"+out_fname)

if __name__ == "__main__":
    split_commands()
