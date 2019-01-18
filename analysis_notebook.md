###
# Installation, setup, and preprocessing
###
python setup.py install <install-directory>

################
# Unit Testing #
################
# quick unit test (local)
mkdir data_analysis/lungpt_1pc_point_unit_test0.05/
python -W ignore scripts/calculate_cutie.py -df scripts/config_defaults.ini -cf scripts/test_config.ini

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


find . -name '*.ini' -exec sed -i -e 's/\/clemente_lab//g' {} \;

find . -name '*.ini' -exec sed -i -e 's/ci_method: Log/ci_method: log/g' {} \;
find . -name '*.ini' -exec sed -i -e 's/ci_method: log/ci_method: none/g' {} \;
find . -name '*.ini' -exec sed -i -e 's/fix_axis: True/fix_axis False/g' {} \;
find . -name '*.ini' -exec sed -i -e 's/fix_axis False/fix_axis: False/g' {} \;


/sc/orga/work/buk02/simulated_data/copula_n50_norm_0_1.txt
/sc/orga/work/buk02/simulated_data/correlation_matrix_copula_table3_n50_norm_0_1.txt

/sc/orga/work/buk02/simulated_data/copula_table2_n50_gamma_1_0_100.txt
/sc/orga/work/buk02/simulated_data/correlation_matrix_copula_table2_n50_gamma_1_0_100.txt

/sc/orga/work/buk02/simulated_data/copula_table1_n50_lognorm_3_0.txt
/sc/orga/work/buk02/simulated_data/correlation_matrix_copula_table1_n50_lognorm_3_0.txt

# has skip = 0 
/sc/orga/work/buk02/simulated_data/zero_infl_otu_copula_table1_n50_lognorm_3_0.txt
/sc/orga/work/buk02/simulated_data/correlation_matrix_copula_table1_n50_lognorm_3_0.txt

echo dir1 dir2 dir3 | xargs -n 1 cp file1

minep_fp: /sc/orga/work/buk02/MIC_MSQ/mine_pvals/n=50,alpha=0.6.csv
pskip: 13
mine_delimiter: ,

n=100,alpha=0.6.csv  n=150,alpha=0.6.csv  n=25,alpha=0.6.csv   n=35,alpha=0.6.csv   n=50,alpha=0.6.csv   n=65,alpha=0.6.csv   n=80,alpha=0.6.csv
n=110,alpha=0.6.csv  n=170,alpha=0.6.csv  n=260,alpha=0.6.csv  n=380,alpha=0.6.csv  n=520,alpha=0.6.csv  n=680,alpha=0.6.csv  n=85,alpha=0.6.csv
n=120,alpha=0.6.csv  n=190,alpha=0.6.csv  n=300,alpha=0.6.csv  n=40,alpha=0.6.csv   n=55,alpha=0.6.csv   n=70,alpha=0.6.csv   n=90,alpha=0.6.csv
n=130,alpha=0.6.csv  n=20,alpha=0.6.csv   n=30,alpha=0.6.csv   n=440,alpha=0.6.csv  n=600,alpha=0.6.csv  n=75,alpha=0.6.csv   n=95,alpha=0.6.csv
n=140,alpha=0.6.csv  n=220,alpha=0.6.csv  n=340,alpha=0.6.csv  n=45,alpha=0.6.csv   n=60,alpha=0.6.csv   n=760,alpha=0.6.csv



###############
# CUtIe Paper #
###############
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
/sc/orga/work/buk02/simulated_data/zero_infl_otu_copula_table1_n50_lognorm_3_0.txt
/sc/orga/work/buk02/simulated_data/correlation_matrix_copula_table1_n50_lognorm_3_0.txt 


###
# Simulated data 
###

# unit test
python -W ignore scripts/calculate_cutie.py -df scripts/config_defaults.ini -cf data_analysis/sim_copula_test/test_sim_config.ini

###
# Normal
###

### Pearson ###

# norm pearson kpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_kpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_kpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_kpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_kpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_kpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_kpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_kpc1fdr0.05/ data_analysis/

# norm pearson dep jkp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_jkp1fdr0.05
cp /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_jkp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_jkp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkp1fdr0.05/ data_analysis/

# norm pearson dep bsp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_bsp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_bsp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsp1fdr0.05/ data_analysis/

# norm pearson rpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rpc1fdr0.05/ data_analysis/


# norm pearson dep rjkp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkp1fdr0.05/ data_analysis/


# norm pearson dep rbsp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsp1fdr0.05/ data_analysis/


### Spearman ###

# norm ksc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_ksc1fdr0.05/ data_analysis/


# norm spearman dep jks
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jks1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jks1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_jks1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jks1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_jks1fdr0.05

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jks1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jks1fdr0.05/ data_analysis/


# norm spearman dep bss
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bss1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bss1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_bss1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bss1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_bss1fdr0.05/

mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bss1fdr0.05
cp /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_bss1fdr0.05/config.ini /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bss1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bss1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bss1fdr0.05/ data_analysis/



# norm rsc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rsc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rsc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rsc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rsc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rsc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rsc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rsc1fdr0.05/ data_analysis/


# norm spearman dep rjks
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjks1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjks1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rjks1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjks1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rjks1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjks1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjks1fdr0.05/ data_analysis/


# norm spearman dep rbss
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbss1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbss1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rbss1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbss1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rbss1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbss1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbss1fdr0.05/ data_analysis/


### Kendall ### 
# norm kkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_kkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_kkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_kkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_kkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_kkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_kkc1fdr0.05/ data_analysis/


# norm jkk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_jkk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_jkk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkk1fdr0.05/ data_analysis/

# norm bsk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_bsk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_bsk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsk1fdr0.05/ data_analysis/


# norm rkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rkc1fdr0.05/ data_analysis/

# norm rjkk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkk1fdr0.05/ data_analysis/

# norm bsk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsk1fdr0.05/ data_analysis/


### MIC ###

# norm mine
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_mine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_mine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_mine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_mine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_mine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_mine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_mine1fdr0.05/ data_analysis/


# norm mine dep jkm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_jkm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_jkm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_jkm1fdr0.05/ data_analysis/


# norm mine dep bsm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_bsm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_bsm1fdr0.05/

cp /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_bsm1fdr0.05/config.ini /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsm1fdr0.05

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_bsm1fdr0.05/ data_analysis/


# norm mine dep reverse
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rmine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rmine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rmine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rmine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rmine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rmine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rmine1fdr0.05/ data_analysis/


# norm mine dep rjkm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rjkm1fdr0.05/ data_analysis/


# norm mine dep rbsm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_rbsm1fdr0.05/ data_analysis/


###
# Gamma
###

### Pearson ###

# gamma pearson kpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kpc1fdr0.05/ data_analysis/



# gamma dep jkp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkp1fdr0.05/ data_analysis/


# gamma dep bsp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsp1fdr0.05/ data_analysis/


# gamma pearson rpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rpc1fdr0.05/ data_analysis/


# norm gamma dep rjkp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkp1fdr0.05/ data_analysis/


# gamma pearson rbsp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsp1fdr0.05/ data_analysis/


### Spearman ###

# gamma spearman ksc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_ksc1fdr0.05/ data_analysis/


# norm gamma dep jks
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jks1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jks1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jks1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jks1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jks1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jks1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jks1fdr0.05/ data_analysis/


# gamma  bss
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bss1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bss1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bss1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bss1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bss1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bss1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bss1fdr0.05/ data_analysis/



# gamma  rsc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rsc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rsc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rsc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rsc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rsc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rsc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rsc1fdr0.05/ data_analysis/


# gamma  rjks
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjks1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjks1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjks1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjks1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjks1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjks1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjks1fdr0.05/ data_analysis/



# norm gamma dep rbss
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbss1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbss1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbss1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbss1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbss1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbss1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbss1fdr0.05/ data_analysis/


### Kendall ###

# gamma  kkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_kkc1fdr0.05/ data_analysis/

# gamma  jkk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkk1fdr0.05/ data_analysis/

# gamma  bsk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsk1fdr0.05/ data_analysis/






# gamma  rkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rkc1fdr0.05/ data_analysis/

# gamma  rjkk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkk1fdr0.05/ data_analysis/


# gamma  rbsk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsk1fdr0.05/ data_analysis/


### MIC ###

# gamma mine dep mine
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_mine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_mine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_mine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_mine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_mine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_mine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_mine1fdr0.05/ data_analysis/


# gamma mine dep jkm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkm1fdr0.05/


python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_jkm1fdr0.05/ data_analysis/



# gamma mine dep bsm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsm1fdr0.05

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_bsm1fdr0.05/ data_analysis/



# gamma mine dep rmine
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rmine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rmine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rmine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rmine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rmine1fdr0.05/


python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rmine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rmine1fdr0.05/ data_analysis/


# gamma mine dep rjkm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rjkm1fdr0.05/ data_analysis/



# gamma mine dep rbsm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsm1fdr0.05/

cp /sc/orga/work/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsm1fdr0.05/sim_copula_n50_gamma_1_0_100_rbsm1fdr0.05/config.ini /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_rbsm1fdr0.05/ data_analysis/

###
# Lognormal
###

### Pearson ###
# lognorm pearson kpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kpc1fdr0.05/ data_analysis/


# lognorm pearson jkp

mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkp1fdr0.05/ data_analysis/


# lognorm pearson dep bsp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsp1fdr0.05/ data_analysis/


# lognorm  rpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rpc1fdr0.05/ data_analysis/


# lognorm pearson rjkp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkp1fdr0.05/ data_analysis/


# lognorm pearson rbsp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsp1fdr0.05/ data_analysis/

### Spearman ###
# lognorm  ksc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_ksc1fdr0.05/ data_analysis/

# lognorm  jks
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jks1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jks1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jks1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jks1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jks1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jks1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jks1fdr0.05/ data_analysis/


# lognorm spearman dep bss
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bss1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bss1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bss1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bss1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bss1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bss1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bss1fdr0.05/ data_analysis/


#  lognorm  rsc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rsc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rsc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rsc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rsc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rsc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rsc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rsc1fdr0.05/ data_analysis/


# lognorm  rjks
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjks1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjks1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjks1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjks1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjks1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjks1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjks1fdr0.05/ data_analysis/


# lognorm  rbss
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbss1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbss1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbss1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbss1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbss1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbss1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbss1fdr0.05/ data_analysis/


### Kendall ###


# lognorm  kkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_kkc1fdr0.05/ data_analysis/



# lognorm  jkk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkk1fdr0.05/ data_analysis/


# lognorm  bsk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsk1fdr0.05/ data_analysis/




# lognorm  rkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rkc1fdr0.05/ data_analysis/



# lognorm  rjkk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkk1fdr0.05/ data_analysis/


# lognorm  rbsk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsk1fdr0.05/ data_analysis/





### MIC ###

# lognorm mine
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_mine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_mine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_mine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_mine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_mine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_mine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_mine1fdr0.05/ data_analysis/


# lognorm mine jkm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkm1fdr0.05/config.ini

cp /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkm1fdr0.05/config.ini /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkm1fdr0.05/

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_jkm1fdr0.05/ data_analysis/


# lognorm mine dep bsm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsm1fdr0.05/config.ini

cp /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsm1fdr0.05/config.ini /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsm1fdr0.05/

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_bsm1fdr0.05/ data_analysis/


# lognorm dep reverse mine
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rmine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rmine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rmine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rmine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rmine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rmine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rmine1fdr0.05/ data_analysis/


# lognorm mine rjkm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rjkm1fdr0.05/ data_analysis/


# lognorm mine dep rbsm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_rbsm1fdr0.05/ data_analysis/



###
# ZI LogN
###

### Pearson ###

# zi lognorm kpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kpc1fdr0.05/ data_analysis/



# zi lognorm rpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rpc1fdr0.05/ data_analysis/




# zi lognorm jkp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkp1fdr0.05/ data_analysis/


# zi lognorm rjkp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkp1fdr0.05/ data_analysis/


# zi lognorm bsp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsp1fdr0.05/ data_analysis/

# zi lognorm rbsp
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsp1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsp1fdr0.05/ data_analysis/


### Spearman ###
# zi lognorm ksc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_ksc1fdr0.05/ data_analysis/


# zi lognorm jks
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jks1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jks1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jks1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jks1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jks1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jks1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jks1fdr0.05/ data_analysis/


# zi lognorm bss
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bss1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bss1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bss1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bss1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bss1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bss1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bss1fdr0.05/ data_analysis/


# zi lognorm rsc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rsc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rsc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rsc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rsc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rsc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rsc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rsc1fdr0.05/ data_analysis/


# zi lognorm rjks
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjks1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjks1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjks1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjks1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjks1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjks1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjks1fdr0.05/ data_analysis/


# zi lognorm rbss
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbss1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbss1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbss1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbss1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbss1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbss1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbss1fdr0.05/ data_analysis/

### Kendall ###
# zi lognorm kkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_kkc1fdr0.05/ data_analysis/


# zi lognorm jkk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkk1fdr0.05/ data_analysis/


# zi lognorm bsk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsk1fdr0.05/ data_analysis/


# zi lognorm rkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rkc1fdr0.05/ data_analysis/


# zi lognorm rjkk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkk1fdr0.05/ data_analysis/


# zi lognorm rbsk
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsk1fdr0.05/ data_analysis/

### MIC ###
# zi lognorm mine
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_mine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_mine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_mine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_mine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_mine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_mine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_mine1fdr0.05/ data_analysis/


# zi lognorm rmine
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rmine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rmine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rmine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rmine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rmine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rmine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rmine1fdr0.05/ data_analysis/



# zi lognorm jkm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_jkm1fdr0.05/ data_analysis/


# zi lognorm rjkm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rjkm1fdr0.05/ data_analysis/


# zi lognorm bsm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_bsm1fdr0.05/ data_analysis/


# zi lognorm rbsm
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsm1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsm1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsm1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsm1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsm1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsm1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_rbsm1fdr0.05/ data_analysis/


###
# POINTWISE FINAL
###

# NORM

# kpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kpc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kpc1fdr0.05/ data_analysis/


mkdir /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kpc1fdr0.05/
emacs -nw /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kpc1fdr0.05/commands.txt

# paste command
export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python2.7/site-packages/ && python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kpc1fdr0.05/config.ini

# generate lsf file
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kpc1fdr0.05/
module load python/2.7.14 && module load py_packages/2.7 && python /sc/orga/projects/clemej05a/labtools/scripts/generate_lsf.py -c /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kpc1fdr0.05/commands.txt -m qiime/1.9.1 -N cutie -o /sc/orga/work/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kpc1fdr0.05/ -n 2 -w 4:00 -s True

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kpc1fdr0.05 data_analysis/






# mine
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_mine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_mine1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_mine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_mine1fdr0.05/ data_analysis/


# ksc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_ksc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_ksc1fdr0.05/ data_analysis/


# kkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kkc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_norm_0_1_pointwise_kkc1fdr0.05/ data_analysis/


# LOGNORM

# kpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_kpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_kpc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_kpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_kpc1fdr0.05/ data_analysis/

# mine
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_mine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_mine1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_mine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_mine1fdr0.05/ data_analysis/


# ksc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_ksc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_ksc1fdr0.05/ data_analysis/


# kkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_kkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_kkc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_lognorm_3_0_pointwise_kkc1fdr0.05/ data_analysis/


# ZI LOGNORM

# kpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_kpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_kpc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_kpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_kpc1fdr0.05/ data_analysis/

# mine
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_mine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_mine1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_mine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_mine1fdr0.05/ data_analysis/


# ksc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_ksc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_ksc1fdr0.05/ data_analysis/


# kkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_kkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_kkc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_zero_infl_otu_copula_n50_lognorm_3_0_pointwise_kkc1fdr0.05/ data_analysis/


# GAMMA

# kpc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_kpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_kpc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_kpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_kpc1fdr0.05/ data_analysis/

# mine
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_mine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_mine1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_mine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_mine1fdr0.05/ data_analysis/


# ksc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_ksc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_ksc1fdr0.05/ data_analysis/


# kkc
mkdir /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_kkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_kkc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/sim_copula_n50_gamma_1_0_100_pointwise_kkc1fdr0.05/ data_analysis/


### 
# Real data
###

###
# LungC
### 

### Pearson ###

# final lung kpc
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_kpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_kpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kpc1fdr0.05/config.ini


scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_kpc1fdr0.05/ data_analysis/

# final lung rpc
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rpc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_rpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_rpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rpc1fdr0.05/config.ini


scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_rpc1fdr0.05/ data_analysis/



### Spearman ###

# final lung ksc

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_ksc1fdr0.05/ data_analysis/



# final lung jks

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_jks1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_jks1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_jks1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_jks1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_jks1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_jks1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_jks1fdr0.05/ data_analysis/



# final lung bss

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_bss1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_bss1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_bss1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_bss1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_bss1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_bss1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_bss1fdr0.05/ data_analysis/



# final lung rsc

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rsc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rsc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_rsc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rsc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_rsc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rsc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_rsc1fdr0.05/ data_analysis/



# final lung rjks

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rjks1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rjks1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_rjks1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rjks1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_rjks1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rjks1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_rjks1fdr0.05/ data_analysis/



# final lung rbss

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rbss1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rbss1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_rbss1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rbss1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_rbss1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rbss1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_rbss1fdr0.05/ data_analysis/



### Kendall ###


# final lung kkc
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_kkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_kkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_kkc1fdr0.05/ data_analysis/


# final lung rkc
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_kkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_kkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_kkc1fdr0.05/ data_analysis/

# final lung jkk
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_jkk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_jkk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_jkk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_jkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_jkk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_jkk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_jkk1fdr0.05/ data_analysis/



# final lung bsk
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_bsk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_bsk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_bsk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_jkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_bsk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_bsk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_bsk1fdr0.05/ data_analysis/



# final lung rkc
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_rkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_rkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_rkc1fdr0.05/ data_analysis/

# final lung rjkk
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rjkk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rjkk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_rjkk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rjkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_rjkk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rjkk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_rjkk1fdr0.05/ data_analysis/



# final lung rbsk
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rbsk1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rbsk1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_rbsk1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_jkk1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_rbsk1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rbsk1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_rbsk1fdr0.05/ data_analysis/





### MIC ###
# final lung mine
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_mine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_mine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_mine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_mine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_mine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_mine1fdr0.05/config.ini


scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_mine1fdr0.05/ data_analysis/




# final lung rmine
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rmine1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rmine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_lungc_rmine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rmine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_lungc_rmine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_lungc_rmine1fdr0.05/config.ini


scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_lungc_rmine1fdr0.05/ data_analysis/



###
# HDAC 
###

### Pearson ###
# final hdac x = 100 kpc

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_kpc1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_kpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_kpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_kpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_kpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_kpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_kpc1fdr0.05/ data_analysis/


# final hdac x = 100 jkp

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_jkp1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_jkp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_jkp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_jkp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_jkp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_jkp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_jkp1fdr0.05/ data_analysis/


# final hdac x = 100 bsp

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_bsp1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_bsp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_bsp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_bsp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_bsp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_bsp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_bsp1fdr0.05/ data_analysis/


# final hdac x = 100 rpc

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rpc1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_rpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_rpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_rpc1fdr0.05/ data_analysis/


# final hdac x = 100 rjkp

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rjkp1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rjkp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_rjkp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rjkp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_rjkp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rjkp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_rjkp1fdr0.05/ data_analysis/


# final hdac x = 100 rbsp

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rbsp1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rbsp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_rbsp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rbsp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_rbsp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rbsp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_rbsp1fdr0.05/ data_analysis/


### Spearman ###
# final hdac x = 100 ksc

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_ksc1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_ksc1fdr0.05/ data_analysis/


# final hdac x = 100 rsc

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rsc1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rsc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_rsc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rsc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_rsc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rsc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_rsc1fdr0.05/ data_analysis/



### Kendall ###


# final hdac x = 100 kkc

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_kkc1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_kkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_kkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_kkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_kkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_kkc1fdr0.05/ data_analysis/



# final hdac x = 100 rkc

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rkc1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_rkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_rkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_rkc1fdr0.05/ data_analysis/


### MIC ###
# final hdac x = 100 mine

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_mine1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_mine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_mine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_mine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_mine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_mine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_mine1fdr0.05/ data_analysis/

# final hdac x = 100 rmine

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rmine1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rmine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_hdac_rmine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rmine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_hdac_rmine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_hdac_rmine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_hdac_rmine1fdr0.05/ data_analysis/




###
# WHO
###

### Pearson ### 

mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_kpc1fdr0.05/
emacs -nw /sc/orga/work/buk02/data_analysis/cutie_WHO_kpc1fdr0.05/commands.txt

# paste command
export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python2.7/site-packages/ && python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/work/buk02/data_analysis/cutie_WHO_kpc1fdr0.05/config.ini

# generate lsf file
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_kpc1fdr0.05/
module load python/2.7.14 && module load py_packages/2.7 && python /sc/orga/projects/clemej05a/labtools/scripts/generate_lsf.py -c /sc/orga/work/buk02/data_analysis/cutie_WHO_kpc1fdr0.05/commands.txt -m qiime/1.9.1 -N cutie -o /sc/orga/work/buk02/data_analysis/cutie_WHO_kpc1fdr0.05/ -n 2 -w 4:00 -s True

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_kpc1fdr0.05 data_analysis/


# final jkp 
mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_jkp1fdr0.05/
emacs -nw /sc/orga/work/buk02/data_analysis/cutie_WHO_jkp1fdr0.05/commands.txt

# paste command
export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python2.7/site-packages/ && python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/work/buk02/data_analysis/cutie_WHO_jkp1fdr0.05/config.ini

# generate lsf file
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_jkp1fdr0.05/
module load python/2.7.14 && module load py_packages/2.7 && python /sc/orga/projects/clemej05a/labtools/scripts/generate_lsf.py -c /sc/orga/work/buk02/data_analysis/cutie_WHO_jkp1fdr0.05/commands.txt -m qiime/1.9.1 -N cutie -o /sc/orga/work/buk02/data_analysis/cutie_WHO_jkp1fdr0.05/ -n 2 -w 2:00 -s True

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_jkp1fdr0.05 data_analysis/



# final bsp 

find . -name '*.ini' -exec sed -i -e 's/\/clemente_lab//g' {} \;


mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_bsp1fdr0.05/
emacs -nw /sc/orga/work/buk02/data_analysis/cutie_WHO_bsp1fdr0.05/commands.txt

# paste command
export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python2.7/site-packages/ && python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/work/buk02/data_analysis/cutie_WHO_bsp1fdr0.05/config.ini

# generate lsf file
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_bsp1fdr0.05/
module load python/2.7.14 && module load py_packages/2.7 && python /sc/orga/projects/clemej05a/labtools/scripts/generate_lsf.py -c /sc/orga/work/buk02/data_analysis/cutie_WHO_bsp1fdr0.05/commands.txt -m qiime/1.9.1 -N cutie -o /sc/orga/work/buk02/data_analysis/cutie_WHO_bsp1fdr0.05/ -n 2 -w 2:00 -s True

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_bsp1fdr0.05 data_analysis/



# final rpc 

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rpc1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rpc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_rpc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rpc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_WHO_rpc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rpc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_rpc1fdr0.05/ data_analysis/


# final rjkp 

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rjkp1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rjkp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_rjkp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rjkp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_WHO_rjkp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rjkp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_rjkp1fdr0.05/ data_analysis/



# final rbsp 

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rbsp1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rbsp1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_rbsp1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rbsp1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_WHO_rbsp1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rbsp1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_rbsp1fdr0.05/ data_analysis/

### Spearman ###
# ksc

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_ksc1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_WHO_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_WHO_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_WHO_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_WHO_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_ksc1fdr0.05/ data_analysis/


# rsc 

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rsc1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rsc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_rsc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rsc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_WHO_rsc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rsc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_rsc1fdr0.05/ data_analysis/


### Kendall ###
# kkc

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_kkc1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_WHO_kkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_kkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_WHO_kkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_WHO_kkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_WHO_kkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_kkc1fdr0.05/ data_analysis/


# rkc
mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rkc1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rkc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_rkc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rkc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_WHO_rkc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rkc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_rkc1fdr0.05/ data_analysis/


### MIC ###
# mine

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_mine1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_WHO_mine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_mine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_WHO_mine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_WHO_mine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_WHO_mine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_mine1fdr0.05/ data_analysis/


# rmine

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rmine1fdr0.05/
emacs -nw /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rmine1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/cutie_WHO_rmine1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rmine1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/cutie_WHO_rmine1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/cutie_WHO_rmine1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/cutie_WHO_rmine1fdr0.05/ data_analysis/


###
# RUN ALL ANALYSIS
###

module load python/2.7.14 && module load py_packages/2.7 

cd /sc/orga/work/buk02/data_analysis/
python /sc/orga/work/buk02/CUTIE/scripts/cutie_analysis.py 





############
# PROJECTS #
############

# Cutie at L2 through L7
# data file

module load qiime/1.9.1

mkdir /sc/orga/scratch/buk02/real_data_analysis/
mkdir /sc/orga/scratch/buk02/real_data_analysis/corr_sweep/

cp /sc/orga/projects/clemej05a/lung.leo_segal/lung_cancer/inputs/otu_table.MSQ34.biom /sc/orga/scratch/buk02/real_data_analysis/corr_sweep/

biom summarize-table -i /sc/orga/scratch/buk02/real_data_analysis/corr_sweep/otu_table.MSQ34.biom -o /sc/orga/scratch/buk02/real_data_analysis/corr_sweep/otu_table_summary.MSQ34.txt 

# all samples over 3k reads, so no filtering necessary
# filter on reads

filter_otus_from_otu_table.py -i /sc/orga/scratch/buk02/real_data_analysis/corr_sweep/otu_table.MSQ34.biom -o /sc/orga/scratch/buk02/real_data_analysis/corr_sweep/otu_table.MSQ34.nosingletons.biom -n 2 

# summarize at levels 2 through 7
for i in 2 3 4 5 6 7;
do 
summarize_taxa.py -i /sc/orga/scratch/buk02/real_data_analysis/corr_sweep/otu_table.MSQ34.nosingletons.biom -L $i -o /sc/orga/scratch/buk02/real_data_analysis/corr_sweep/
done

# CUTIE analysis
mkdir /sc/orga/work/buk02/cutie/data/corr_sweep/
cp /sc/orga/scratch/buk02/real_data_analysis/corr_sweep/* /sc/orga/work/buk02/cutie/data/corr_sweep/

scp buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/real_data_analysis/corr_sweep/*.txt /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/corr_sweep/


# L2
mkdir /sc/orga/scratch/buk02/data_analysis/corr_sweep_L2_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/corr_sweep_L2_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/corr_sweep_L2_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/corr_sweep_L2_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/corr_sweep_L2_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/corr_sweep_L2_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/corr_sweep_L2_ksc1fdr0.05/ data_analysis/

# L3
mkdir /sc/orga/scratch/buk02/data_analysis/corr_sweep_L3_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/corr_sweep_L3_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/corr_sweep_L3_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/corr_sweep_L3_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/corr_sweep_L3_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/corr_sweep_L3_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/corr_sweep_L3_ksc1fdr0.05/ data_analysis/

# L4
mkdir /sc/orga/scratch/buk02/data_analysis/corr_sweep_L4_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/corr_sweep_L4_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/corr_sweep_L4_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/corr_sweep_L4_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/corr_sweep_L4_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/corr_sweep_L4_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/corr_sweep_L4_ksc1fdr0.05/ data_analysis/


# L5
mkdir /sc/orga/scratch/buk02/data_analysis/corr_sweep_L5_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/corr_sweep_L5_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/corr_sweep_L5_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/corr_sweep_L5_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/corr_sweep_L5_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/corr_sweep_L5_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/corr_sweep_L5_ksc1fdr0.05/ data_analysis/


# L6
mkdir /sc/orga/scratch/buk02/data_analysis/corr_sweep_L6_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/corr_sweep_L6_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/corr_sweep_L6_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/corr_sweep_L6_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/corr_sweep_L6_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/corr_sweep_L6_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/corr_sweep_L6_ksc1fdr0.05/ data_analysis/


# L7
mkdir /sc/orga/scratch/buk02/data_analysis/corr_sweep_L7_ksc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/corr_sweep_L7_ksc1fdr0.05/config.ini

mkdir /sc/orga/work/buk02/data_analysis/corr_sweep_L7_ksc1fdr0.05
cp /sc/orga/scratch/buk02/data_analysis/corr_sweep_L7_ksc1fdr0.05/config.ini /sc/orga/work/buk02/data_analysis/corr_sweep_L7_ksc1fdr0.05/

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/corr_sweep_L7_ksc1fdr0.05/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/corr_sweep_L7_ksc1fdr0.05/ data_analysis/




###
# NATURE PAPER
###

/sc/orga/work/buk02/cutie/data/nat_cutie/reference-hit.biom


scp /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data/nat_cutie/* buk02@mothra.hpc.mssm.edu:/sc/orga/work/buk02/cutie/data/nat_cutie/

mkdir /sc/orga/scratch/buk02/data_analysis/nat_cutie

biom summarize-table -i /sc/orga/work/buk02/cutie/data/nat_cutie/reference-hit.biom -o /sc/orga/scratch/buk02/data_analysis/nat_cutie/nat_cutie_summary.txt

# 4 samples with < 4k reads (and less than 300)
# remove samples with <1000 reads to them total

filter_samples_from_otu_table.py -i /sc/orga/work/buk02/cutie/data/nat_cutie/reference-hit.biom -o /sc/orga/work/buk02/cutie/data/nat_cutie/reference-hit_filter1000.biom -n 1000


# filter on reads
filter_otus_from_otu_table.py -i /sc/orga/work/buk02/cutie/data/nat_cutie/reference-hit_filter1000.biom -o /sc/orga/work/buk02/cutie/data/nat_cutie/reference-hit_filter1000_nosingletons.biom -n 2 

# summarize at levels 6 and 7
for i in 6 7;
do 
summarize_taxa.py -i /sc/orga/work/buk02/cutie/data/nat_cutie/reference-hit_filter1000_nosingletons.biom -L $i -o /sc/orga/work/buk02/cutie/data/nat_cutie/
done

# CUTIE on vegetables col 40

mkdir /sc/orga/scratch/buk02/data_analysis/nat_cutie
emacs -nw /sc/orga/scratch/buk02/data_analysis/nat_cutie/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/nat_cutie_vegetables/config.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/nat_cutie_vegetables/ data_analysis/

# complete dataset kkc

mkdir /sc/orga/scratch/buk02/data_analysis/nat_cutie_kkc1fdr0.05
emacs -nw /sc/orga/scratch/buk02/data_analysis/nat_cutie_kkc1fdr0.05/config.ini

python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/scratch/buk02/data_analysis/nat_cutie_kkc1fdr0.05/config.ini

# too much mem needed, 16 never got submitted, 8 broke
# 8 hours didn't finish
# try 24
# worked at 72 hours

python /sc/orga/projects/clemej05a/labtools/scripts/generate_lsf.py -c /sc/orga/scratch/buk02/data_analysis/nat_cutie_kkc1fdr0.05/command.txt -m qiime/1.9.1 -N nat_cutie_kkc1fdr0.05 -o /sc/orga/scratch/buk02/data_analysis/nat_cutie_kkc1fdr0.05/ -n 12 -w 72:00

# add this to script
export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python2.7/site-packages/

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/scratch/buk02/data_analysis/nat_cutie_kkc1fdr0.05/* data_analysis/




###
# Enrica PRISM
###

/sc/orga/projects/clemej05a/enrica/PRIISM_18


biom summarize-table -i /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table.biom -o /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_summary.txt

biom summarize-table -i /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800.biom -o /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800_summary.txt

biom summarize-table -i /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_1000.biom -o /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_1000_summary.txt

# go with 800 as only a few smaples were taken out (n = 142 -> n = 139)
# nothing done here
filter_samples_from_otu_table.py -i /sc/orga/work/buk02/cutie/data/nat_cutie/reference-hit.biom -o /sc/orga/work/buk02/cutie/data/nat_cutie/reference-hit_filter1000.biom -n 1000

# filter on reads
filter_otus_from_otu_table.py -i /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800.biom -o /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800_nosingletons.biom -n 2 

# summarize at L6 (want 300 features)
# 409
summarize_taxa.py -i /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800_nosingletons.biom -L 6 -o /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/

# 160
summarize_taxa.py -i /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800_nosingletons.biom -L 5 -o /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/

# use L6: /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800_nosingletons_L6.txt
# remove first row
sed 1d /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800_nosingletons_L6.txt > /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800_nosingletons_L6_del1.txt

# incompatibilities 
# https://bitbucket.org/yonatanf/sparcc/issues/18/error-tuple-index-out-of-range
SparCC.py /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800_nosingletons_L6_del1.txt -i 5 --cor_file=/sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800_nosingletons_L6_del1_sparcc.out


#filter otus from otu table .1% min % of reads aim for 100-1000 with fast spar
# per sample type based network

# conda
conda create --name SparCCEnv python=2.6.9
source activate SparCCEnv
conda install numpy=1.9.2
conda install pandas=0.16.2

# L6

python /Users/KevinBu/Desktop/Clemente\ Lab/Software/SparCC/SparCC.py /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/filtered_otu_table_800_nosingletons_L6_del1_counts.txt -i 20 --cor_file=/Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/filtered_otu_table_800_nosingletons_L6_del1_counts_sparcc.out

python /Users/KevinBu/Desktop/Clemente\ Lab/Software/SparCC/MakeBootstraps.py /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/filtered_otu_table_800_nosingletons_L6_del1_counts.txt -n 100 -t permutation_#.txt -p /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/pvals/

for i in {0..99};
do 
python /Users/KevinBu/Desktop/Clemente\ Lab/Software/SparCC/SparCC.py /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/pvals/permutation_$i.txt -i 20 --cor_file=/Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/pvals/perm_cor_$i.txt; 
done

python /Users/KevinBu/Desktop/Clemente\ Lab/Software/SparCC/PseudoPvals.py /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/filtered_otu_table_800_nosingletons_L6_del1_counts_sparcc.out /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/pvals/perm_cor_#.txt 100 -o /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/pvals/pvals.two_sided.txt -t two_sided

# L5 

python /Users/KevinBu/Desktop/Clemente\ Lab/Software/SparCC/SparCC.py /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/filtered_otu_table_800_nosingletons_L5_del1_counts.txt -i 20 --cor_file=/Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/filtered_otu_table_800_nosingletons_L5_del1_counts_sparcc.out

python /Users/KevinBu/Desktop/Clemente\ Lab/Software/SparCC/MakeBootstraps.py /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/filtered_otu_table_800_nosingletons_L5_del1_counts.txt -n 500 -t permutation_#.txt -p /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/pvals/

for i in {0..499};
do 
python /Users/KevinBu/Desktop/Clemente\ Lab/Software/SparCC/SparCC.py /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/pvals/permutation_$i.txt -i 20 --cor_file=/Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/pvals/perm_cor_$i.txt; 
done

python /Users/KevinBu/Desktop/Clemente\ Lab/Software/SparCC/PseudoPvals.py /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/filtered_otu_table_800_nosingletons_L5_del1_counts_sparcc.out /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/pvals/perm_cor_#.txt 500 -o /Users/KevinBu/Desktop/Clemente\ Lab/CUtIe/data_analysis/prism_enrica/pvals/pvals.two_sided.txt -t two_sided


source deactivate

python /sc/orga/projects/clemej05a/CBC/scripts/sparcc2network2.0.py -c /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/cov_mat_SparCC.out -p /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/pvals/pvals.two_sided.txt -b /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/filtered_otu_table_800_nosingletons_L6.biom -o /sc/orga/scratch/buk02/real_data_analysis/enrica_prism/cytoscape.txt -t 0.0000001



###
# Sabrina conrol_calibrate
###

run2 mapping file

/sc/orga/projects/clemej05a/mock/inputs/run2/map.run2.txt
'Group' column = 'Mock'

/sc/orga/projects/clemej05a/mock/inputs/run2/lane1_NoIndex_L001_R1_001.fastq.gz

# took like 1.5 hours
split_libraries_fastq.py -i /sc/orga/projects/clemej05a/mock/inputs/run2/lane1_NoIndex_L001_R1_001.fastq.gz -b /sc/orga/projects/clemej05a/mock/inputs/run2/lane1_NoIndex_L001_R2_001.fastq.gz --rev_comp_mapping_barcodes -o /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/ -m /sc/orga/projects/clemej05a/mock/inputs/run2/map.run2.txt -q 5 -p 0.70 -r 1 -n 1

# took 2-3 hours T.T
pick_closed_reference_otus.py -i /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/seqs.fna -r /sc/orga/projects/clemej05a/data/gg_13_8_otus/rep_set/97_otus.fasta -o /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/otus_w_tax_0.97/ -t /sc/orga/projects/clemej05a/data/gg_13_8_otus/taxonomy/97_otu_taxonomy.txt

# /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table.biom
# summarize table
biom summarize-table -i /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table.biom -o /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table_summary.txt

# filter H2O and blank (have < 5k reads)
filter_samples_from_otu_table.py -i /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table.biom -o /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table_filter5k.biom -n 5000

# filter on reads
filter_otus_from_otu_table.py -i /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table_filter5k.biom -o /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table_filter5k_nosingletons.biom -n 2 


# summarize at L6 (want 300 features)
# 409
summarize_taxa.py -i /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table_filter5k_nosingletons.biom -L 6 -o /sc/orga/scratch/buk02/mock_data_analysis/run2_q5_p0.70_r1_n1/otus_w_tax_0.97/




run9 mapping file

/sc/orga/projects/clemej05a/mock/inputs/run2/map.run2.txt
'Type' column = 'Mock'

/sc/orga/projects/clemej05a/mock/inputs/run9/lane1_NoIndex_L001_R1_001.fastq.gz

# correct mapping file
/sc/orga/projects/clemej05a/mock/inputs/run9/map.run9.kb.txt


# took like 1-2 hours
split_libraries_fastq.py -i /sc/orga/projects/clemej05a/mock/inputs/run9/lane1_NoIndex_L001_R1_001.fastq.gz -b /sc/orga/projects/clemej05a/mock/inputs/run9/lane1_NoIndex_L001_R2_001.fastq.gz --rev_comp_mapping_barcodes -o /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/ -m /sc/orga/projects/clemej05a/mock/inputs/run9/map.run9.kb.txt -q 5 -p 0.70 -r 1 -n 1


# took 1-2 hours?
pick_closed_reference_otus.py -i /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/seqs.fna -r /sc/orga/projects/clemej05a/data/gg_13_8_otus/rep_set/97_otus.fasta -o /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/ -t /sc/orga/projects/clemej05a/data/gg_13_8_otus/taxonomy/97_otu_taxonomy.txt


# /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table.biom
# summarize table
biom summarize-table -i /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table.biom -o /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table_summary.txt

# filter < 1k
filter_samples_from_otu_table.py -i /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table.biom -o /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table_filter1k.biom -n 1000

# filter on reads
filter_otus_from_otu_table.py -i /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table_filter1k.biom -o /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table_filter1k_nosingletons.biom -n 2 


# summarize at L6 (want 300 features)
# 409
summarize_taxa.py -i /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table_filter1k_nosingletons.biom -L 6 -o /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/


summarize_taxa.py -i /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/otu_table_filter1k_nosingletons.biom -L 1 -o /sc/orga/scratch/buk02/mock_data_analysis/run9_q5_p0.70_r1_n1/otus_w_tax_0.97/





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
# ICI
###

# kpc
mkdir data_analysis/cutie_igal_ici_bm_kpc1fdr0.05
emacs -nw data_analysis/cutie_igal_ici_bm_kpc1fdr0.05/config.ini

python -W ignore scripts/calculate_cutie.py -df scripts/config_defaults.ini -cf data_analysis/cutie_igal_ici_bm_kpc1fdr0.05/config.ini

# ksc
mkdir data_analysis/cutie_igal_ici_bm_ksc1fdr0.05
emacs -nw data_analysis/cutie_igal_ici_bm_ksc1fdr0.05/config.ini

python -W ignore scripts/calculate_cutie.py -df scripts/config_defaults.ini -cf data_analysis/cutie_igal_ici_bm_ksc1fdr0.05/config.ini

# kkc
mkdir data_analysis/cutie_igal_ici_bm_kkc1fdr0.05
emacs -nw data_analysis/cutie_igal_ici_bm_kkc1fdr0.05/config.ini

python -W ignore scripts/calculate_cutie.py -df scripts/config_defaults.ini -cf data_analysis/cutie_igal_ici_bm_kkc1fdr0.05/config.ini


###
# Imageproc
###


source activate yourenv
export PYTHONPATH=$PYTHONPATH:/Users/KevinBu/tools/sandbox/lib/python3.5/site-packages/
cd /Users/KevinBu/Desktop/clemente_lab/Software/imagecluster
Python3 setup.py install  --prefix=/Users/KevinBu/tools/sandbox/
cd /Users/KevinBu/Desktop/clemente_lab/iclust/data\
python3
from imagecluster import main
main.main('hdac_kpc_plots/small/plots/', 'hdac_kpc_plots/small/', sim=2)

###
# Filtering test
###


filter_otus_from_otu_table.py -i -o -n 0.01 --min_count_fraction 

for path in /sc/orga/work/buk02/data_analysis/*enrica*; do
    bsub < ${path}/cutie.0
done

filter_otus_from_otu_table.py -i /sc/orga/work/buk02/enrica_data/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def.biom -o /sc/orga/work/buk02/enrica_data/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def_filt0.01.biom --min_count_fraction=0.01



summarize_taxa.py -i /sc/orga/work/buk02/enrica_data/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def_filt0.01.biom -L 6 -o /sc/orga/work/buk02/enrica_data/

# use local ipynb to convert to correct otu tables
# iclust/senrica_split_cutie_filt.ipynb

mkdir /sc/orga/scratch/buk02/data_analysis/cutie_enrica_kkc1fdr0.05/
python -W ignore /sc/orga/work/buk02/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/cutie/scripts/config_defaults.ini -cf /sc/orga/work/buk02/data_analysis/cutie_enrica_kkc1fdr0.05/config.ini



filter_otus_from_otu_table.py -i /sc/orga/work/buk02/enrica_data/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def.biom -o /sc/orga/work/buk02/enrica_data/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def_nosingletons.biom -n 2

summarize_taxa.py -i /sc/orga/work/buk02/enrica_data/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def_nosingletons.biom -L 6 -o /sc/orga/work/buk02/enrica_data/



###############
# DEVELOPMENT #
###############














