###############
# CUtIe Paper #
###############

###
# Simulations
###

# generating simulated datasets
python scripts/generate_copula.py

# datasets and correlation matrices (truths)
/sc/orga/work/buk02/simulated_data

# technically the correlation matrices are all the same
# norm
/sc/orga/work/buk02/simulated_data/copula_n50_norm_0_1.txt
/sc/orga/work/buk02/simulated_data/correlation_matrix_copula_n50_norm_0_1.txt
* DO NOT USE copula_table3_n50_norm_0_1.txt

# gamma
/sc/orga/work/buk02/simulated_data/copula_table2_n50_gamma_1_0_100.txt
/sc/orga/work/buk02/simulated_data/  correlation_matrix_copula_table2_n50_gamma_1_0_100.txt

# logn
/sc/orga/work/buk02/simulated_data/copula_table1_n50_lognorm_3_0.txt
/sc/orga/work/buk02/simulated_data/correlation_matrix_copula_table1_n50_lognorm_3_0.txt

# zi logn
# has skip = 0
/sc/orga/work/buk02/simulated_data/zero_infl_otu_copula_table1_n50_lognorm_3_0.txt
/sc/orga/work/buk02/simulated_data/correlation_matrix_copula_table1_n50_lognorm_3_0.txt

# MINE relevant files
minep_fp: /sc/orga/work/buk02/MIC_MSQ/mine_pvals/n=50,alpha=0.6.csv
pskip: 13
mine_delimiter: ,

n=100,alpha=0.6.csv  n=150,alpha=0.6.csv  n=25,alpha=0.6.csv   n=35,alpha=0.6.csv   n=50,alpha=0.6.csv   n=65,alpha=0.6.csv   n=80,alpha=0.6.csv
n=110,alpha=0.6.csv  n=170,alpha=0.6.csv  n=260,alpha=0.6.csv  n=380,alpha=0.6.csv  n=520,alpha=0.6.csv  n=680,alpha=0.6.csv  n=85,alpha=0.6.csv
n=120,alpha=0.6.csv  n=190,alpha=0.6.csv  n=300,alpha=0.6.csv  n=40,alpha=0.6.csv   n=55,alpha=0.6.csv   n=70,alpha=0.6.csv   n=90,alpha=0.6.csv
n=130,alpha=0.6.csv  n=20,alpha=0.6.csv   n=30,alpha=0.6.csv   n=440,alpha=0.6.csv  n=600,alpha=0.6.csv  n=75,alpha=0.6.csv   n=95,alpha=0.6.csv
n=140,alpha=0.6.csv  n=220,alpha=0.6.csv  n=340,alpha=0.6.csv  n=45,alpha=0.6.csv   n=60,alpha=0.6.csv   n=760,alpha=0.6.csv

###
# Run all analysis
###

module load python/2.7.14 && module load py_packages/2.7

cd /sc/orga/work/buk02/data_analysis/
python /sc/orga/work/buk02/CUTIE/scripts/cutie_analysis.py


###
# Unit Testing
###

# minepy installation
http://minepy.sourceforge.net/docs/0.3.5/install.html

# install
source activate cutie
cd /Users/KevinBu/Desktop/clemente_lab/CUTIE
export PYTHONPATH=/Users/KevinBu/tools/sandbox/lib/python3.7/site-packages/
Python3 setup.py install  --prefix=/Users/KevinBu/tools/sandbox/

# navigate to dir
cd /Users/KevinBu/Desktop/clemente_lab/CUTIE/tests/

# mk test directory
mkdir /Users/KevinBu/Desktop/clemente_lab/CUTIE/tests/lungpt_1pc_point_unit_test0.05/

# run cutie
python3 /Users/KevinBu/Desktop/clemente_lab/CUTIE/scripts/calculate_cutie.py -df /Users/KevinBu/Desktop/clemente_lab/CUTIE/tests/config_defaults.ini -cf /Users/KevinBu/Desktop/clemente_lab/CUTIE/tests/lungpt_1pc_point_unit_test_kkc1fdr0.05/test_config.ini



###
# HPC analog
###

# quick unit test (hpc)
module load python/2.7.14 && module load py_packages/2.7

# mkdir work based directory
mkdir /sc/orga/work/buk02/data_analysis/lungpt_1pc_point_unit_test0.05/
emacs -nw /sc/orga/work/buk02/data_analysis/lungpt_1pc_point_unit_test0.05/commands.txt

# paste command
export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python2.7/site-packages/ && python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/work/buk02/data_analysis/lungpt_1pc_point_unit_test0.05/test_config_hpc.ini

# generate lsf file
mkdir /sc/orga/scratch/buk02/data_analysis/lungpt_1pc_point_unit_test0.05/
python /sc/orga/projects/clemej05a/labtools/scripts/generate_lsf.py -c /sc/orga/work/buk02/data_analysis/lungpt_1pc_point_unit_test0.05/commands.txt -m qiime/1.9.1 -N cutie -o /sc/orga/work/buk02/data_analysis/lungpt_1pc_point_unit_test0.05/ -n 1 -w 1:00 -s True

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/lungpt_1pc_point_unit_test0.05 data_analysis/


###
# Config files
###


# changing config files
find . -name '*.ini' -exec sed -i -e 's/\/clemente_lab//g' {} \;
find . -name '*.ini' -exec sed -i -e 's/ci_method: Log/ci_method: log/g' {} \;
find . -name '*.ini' -exec sed -i -e 's/ci_method: log/ci_method: none/g' {} \;
find . -name '*.ini' -exec sed -i -e 's/fix_axis: True/fix_axis False/g' {} \;
find . -name '*.ini' -exec sed -i -e 's/fix_axis False/fix_axis: False/g' {} \;
/sc/orga/work/buk02/simulated_data/zero_infl_otu_copula_table1_n50_lognorm_3_0.txt
/sc/orga/work/buk02/simulated_data/correlation_matrix_copula_table1_n50_lognorm_3_0.txt

echo dir1 dir2 dir3 | xargs -n 1 cp file1




###############
# DEVELOPMENT #
###############



###
# HMP
###
/sc/orga/scratch/buk02/HMP/SRS011061/SRS011061.denovo_duplicates_marked.trimmed.1.fastq
/sc/orga/scratch/buk02/HMP/SRS011061/SRS011061.denovo_duplicates_marked.trimmed.2.fastq
/sc/orga/scratch/buk02/HMP/SRS011061/SRS011061.denovo_duplicates_marked.trimmed.singleton.fastq

emacs -nw /sc/orga/scratch/buk02/HMP/SRS011061/command.txt

# remove 1.9.1

python /sc/orga/projects/clemej05a/labtools/scripts/generate_lsf.py -c /sc/orga/scratch/buk02/HMP/SRS011302/command.txt -m metaphlan,bowtie2 -N SRS011302.mp2 -o /sc/orga/scratch/buk02/HMP/SRS011302/ -n 4 -w 2:00

metaphlan2.py /sc/orga/scratch/buk02/HMP/SRS011302/SRS011302.denovo_duplicates_marked.trimmed.1.fastq,/sc/orga/scratch/buk02/HMP/SRS011302/SRS011302.denovo_duplicates_marked.trimmed.2.fastq --bowtie2out /sc/orga/scratch/buk02/HMP/SRS011302/SRS011302.bt2 -o /sc/orga/scratch/buk02/HMP/SRS011302/SRS011302_profile.txt --input_type fastq --mpa_pkl /hpc/packages/minerva-common/metaphlan/f0bfc8620578/biobakery-metaphlan2-f0bfc8620578/db_v20/mpa_v20_m200.pkl --bowtie2db /hpc/packages/minerva-common/metaphlan/f0bfc8620578/biobakery-metaphlan2-f0bfc8620578/db_v20/mpa_v20_m200


###
# iclust
###


source activate yourenv
cd /Users/KevinBu/Desktop/clemente_lab/Software/imagecluster
export PYTHONPATH=$PYTHONPATH:/Users/KevinBu/tools/sandbox/lib/python3.5/site-packages/
python3 setup.py install  --prefix=/Users/KevinBu/tools/sandbox/
cd /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis

python3
from imagecluster import main
dirs =['SSC-A_Blue1-A', 'FSC-W_Blue1-A', 'SSC-A_SSC-W', 'FSC-A_SSC-W', 'SSC-W_Blue1-A', 'FSC-A_FSC-W', 'FSC-W_SSC-A', 'FSC-A_Blue1-A', 'SSC-W_Blue4-A', 'FSC-A_Blue4-A', 'Blue1-A_Blue4-A', 'FSC-A_SSC-A', 'SSC-A_Blue4-A', 'FSC-W_SSC-W', 'FSC-W_Blue4-A']

for d in dirs:
    main.main('/Users/KevinBu/Desktop/clemente_lab/iclust/data/FCM_data/' + d + '/plots/', '/Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/FCM_data/' + d + '/', sim=2)
# sim here doesn't matter, we are only interested in the distance feature matrix

# directory of images and then directory of output










