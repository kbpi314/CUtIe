import click
import os
import glob
from collections import defaultdict

CONTEXT_SETTINGS = dict(help_option_names=['-h', '--help'])

@click.command(context_settings=CONTEXT_SETTINGS)
@click.version_option(version='0.1')

# Required arguments
@click.option('-s', '--max_seed', type=int,
              help='max int seed number')

def gen_batch(max_seed):
    dirs = glob.glob('/sc/hydra/work/buk02/new_configs/*')

    if not os.path.exists('/sc/hydra/work/buk02/new_commands/batch_jobs/'):
        os.makedirs('/sc/hydra/work/buk02/new_commands/batch_jobs/')

    seed_to_dirs = defaultdict(list)

    for d in dirs:
        # fp = nomc_1_rpearson_False_4_NP_25_0.9
        fp = os.path.basename(d)
        seed = fp.split('_')[4]
        with open(d + '/commands_' + fp + '.txt', 'r') as f:
            line = f.readline()
            command = line.split('&&')[-1]
            seed_to_dirs[seed].append(command)
            
    for s in range(max_seed):
        with open('/sc/hydra/work/buk02/new_commands/batch_jobs/batch_' + str(s) + '.txt', 'w') as f:
            f.write('export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.7/site-packages/')
            for c in seed_to_dirs[str(s)]:
                f.write(' && ')
                f.write(c)

if __name__ == "__main__":
    gen_batch()
