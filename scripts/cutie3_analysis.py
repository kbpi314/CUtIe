from glob import glob
from subprocess import call

paths = glob('/sc/orga/work/buk02/data_analysis/sim*') + glob('/sc/orga/work/buk02/data_analysis/cutie_WHO*') + glob('/sc/orga/work/buk02/data_analysis/cutie_HDAC*') + glob('/sc/orga/work/buk02/data_analysis/cutie_lungc*')

print(paths)
for path in paths:
    cutie_path = path + '/cutie.0'
    #cutie_path = '/sc/orga/work/buk02/temp4.txt'
    #cutie_path = '/sc/orga/work/buk02/data_analysis/cutie_igal_metaotu_A_kpc1fdr0.05/temp.lsf'
    call(["cp " + cutie_path + " " + cutie_path + '.temp.lsf'], shell = True)
    call(["sed -i 's,python -W ignore,python,g' " + cutie_path], shell = True)
    call(["sed -i 's,export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python2.7/site-packages/ && ,,g' " + cutie_path], shell = True)
    call(["sed -i 's,module load qiime/1.9.1/1.9.1,module load python/3.6.2 \&\& module load py_packages/3.6 \&\& export LC_ALL=en_US.utf-8 \&\& export LANG=en_US.utf-8 \&\& export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.6/site-packages/,g' " + cutie_path], shell = True)
    call(['bsub < ' + cutie_path], shell = True)   

