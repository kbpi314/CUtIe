###
# Installation, setup, and preprocessing
###

python setup.py install <install-directory>

# minerva files
/sc/orga/work/buk02/clemente_lab/lungpt_data/otu_table_MultiO_merged___L6.txt
/sc/orga/work/buk02/clemente_lab/lungpt_data/Mapping.Pneumotype.Multiomics.RL.NYU.w_metabolites.w_inflamm.txt
/sc/orga/work/buk02/clemente_lab/cutie/data/pre_sparcc_MSQ/otu_table.MSQ34_L6.txt

################
# Unit Testing #
################

# quick unit test (local)
python -W ignore scripts/calculate_cutie.py -df scripts/config_defaults.ini -cf scripts/test_config.ini

# quick unit test (hpc)
mkdir /sc/orga/work/buk02/clemente_lab/data_analysis/lungpt_1pc_point_unit_test0.05/

python -W ignore /sc/orga/work/buk02/clemente_lab/cutie/scripts/calculate_cutie.py -df /sc/orga/work/buk02/clemente_lab/cutie/scripts/config_defaults.ini -cf /sc/orga/work/buk02/clemente_lab/cutie/scripts/test_config_hpc.ini

scp -r buk02@mothra.hpc.mssm.edu:/sc/orga/work/buk02/clemente_lab/data_analysis/lungpt_1pc_point_unit_test0.05/* data_analysis/







