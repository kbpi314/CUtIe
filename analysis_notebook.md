###############
# CUtIe Paper #
###############

###
# Simulations
###

# generating simulated datasets

python3 /Users/KevinBu/Desktop/clemente_lab/CUTIE/scripts/gen_cutie_copula.py -o /Users/KevinBu/Desktop/clemente_lab/CUTIE/simulations/ -s 0 -x 100 -n 20

# technically the correlation matrices are all the same
# norm
* DO NOT USE copula_table3_n50_norm_0_1.txt

# has skip = 0

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


##########
# iclust #
##########

module load python/3.7.3 && export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.7/site-packages/
python setup.py install --prefix=/hpc/users/buk02/tools/sandbox


###############
# Simulations #
###############

###
# Anscombe's Quartet
###


# locally (source activate cutie3)
mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data/aq1000xsim
mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/aq1000xsim

for i in {0..99}
do
    python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/plot_correlations.py -i /Users/KevinBu/Desktop/clemente_lab/iclust/data/anscombes.txt -o /Users/KevinBu/Desktop/clemente_lab/iclust/data/aq1000xsim/ --labeled -l group -s ${i} -n 10 -sv 0.1,0.25,0.5,0.75,1.0 -dl aq --points --fixaxis --axis_off

    for j in 0.1 0.25 0.5 0.75 1.0
    do
        mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/aq1000xsim/aq_${i}_10x_${j}_cclust
        python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/image_cluster.py -i /Users/KevinBu/Desktop/clemente_lab/iclust/data/aq1000xsim/aq_${i}_10x_${j}/ -o /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/aq1000xsim/aq_${i}_10x_${j}_cclust/ -l True -m 20 --nonimageclustering

        mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/aq1000xsim/aq_${i}_10x_${j}_iclust
        python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/image_cluster.py -i /Users/KevinBu/Desktop/clemente_lab/iclust/data/aq1000xsim/aq_${i}_10x_${j}/ -o /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/aq1000xsim/aq_${i}_10x_${j}_iclust/ -l True -m 20 --imageclustering
    done
done



###
# Datasaurus Dozen
###

# locally (source activate cutie3)
mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data/dd1000xsim
mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/dd1000xsim

for i in {0..99}
do
    python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/plot_correlations.py -i /Users/KevinBu/Desktop/clemente_lab/iclust/data/DatasaurusDozen.tsv -o /Users/KevinBu/Desktop/clemente_lab/iclust/data/dd1000xsim/ --labeled -l dataset -s ${i} -n 4 -sv 0.1,0.5,1,2,3 -dl dd --points --fixaxis --axis_off

    for j in 0.1 0.5 1.0 2.0 3.0
    do
        mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/dd1000xsim/dd_${i}_4x_${j}_cclust
        python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/image_cluster.py -i /Users/KevinBu/Desktop/clemente_lab/iclust/data/dd1000xsim/dd_${i}_4x_${j}/ -o /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/dd1000xsim/dd_${i}_4x_${j}_cclust/ -l True -m 20 --nonimageclustering

        mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/dd1000xsim/dd_${i}_4x_${j}_iclust
        python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/image_cluster.py -i /Users/KevinBu/Desktop/clemente_lab/iclust/data/dd1000xsim/dd_${i}_4x_${j}/ -o /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/dd1000xsim/dd_${i}_4x_${j}_iclust/ -l True -m 20 --imageclustering
    done
done


###
# WHO
###

# generate data
mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data/WHO/
python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/plot_correlations.py -i /Users/KevinBu/Desktop/clemente_lab/CUtIe/data/MINE/WHOfinal.txt -o /Users/KevinBu/Desktop/clemente_lab/iclust/data/WHO/large_corr/ --unlabeled -s 0 -lb 0.8975 -ub 0.9025 -dl WHO

# analyze with cclust and iclust
for val in 'large_corr' 'large_corr_drop1'
do
    mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/WHO_${val}_cclust
    python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/image_cluster.py -i /Users/KevinBu/Desktop/clemente_lab/iclust/data/WHO/${val}/ -o /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/WHO_${val}_cclust/ -l False -m 20 --nonimageclustering
    mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/WHO_${val}_iclust
    python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/image_cluster.py -i /Users/KevinBu/Desktop/clemente_lab/iclust/data/WHO/${val}/ -o /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/WHO_${val}_iclust/ -l False -m 20 --imageclustering
done

python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/image_cluster.py -i /Users/KevinBu/Desktop/clemente_lab/iclust/data/WHO/large_corr_drop1/ -o /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/WHO_large_corr_drop1_iclust/ -l False -m 20 --imageclustering



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


# convert to biom
biom convert -i /sc/hydra/work/buk02/transferlearning/HMP/HMP_otu_table_psn_v35.txt -o /sc/hydra/work/buk02/transferlearning/HMP/HMP_otu_table_psn_v35.biom --to-hdf5 --table-type="OTU table" --process-obs-metadata taxonomy

# remove singletons
filter_otus_from_otu_table.py -i /sc/hydra/work/buk02/transferlearning/HMP/HMP_otu_table_psn_v35.biom -o /sc/hydra/work/buk02/transferlearning/HMP/HMP_otu_table_psn_v35_no_singletons.biom -n 2


# MOMSPI
# family genus and species summaries
module load anaconda2
source activate qiime1.9.1
export PYTHONPATH=/hpc/packages/minerva-centos7/anaconda2/2019.03/pkgs

combined=""
for file in *.biom; do
  token="$file"
  combined="${combined}${combined:+,}$token"
done
echo $combined

merge_otu_tables.py -i $combined -o merged_otu_table.biom

biom summarize-table -i /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/inputs/merged_otu_table.biom -o /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/inputs/merged_summary.txt

# filter on 1000
# then remove blanks
filter_samples_from_otu_table.py -i /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/inputs/merged_otu_table.biom  -o /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/outputs/merged_otu_table_filt1000.biom -n 1000

# no singletons
filter_otus_from_otu_table.py -i /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/outputs/merged_otu_table_filt1000.biom -o /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/outputs/merged_otu_table_filt1000_nosingletons.biom -n 2

# summarize
summarize_taxa.py -i /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/outputs/merged_otu_table_filt1000_nosingletons.biom -o /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/outputs/ -L 5,6,7

# alpha diversity
alpha_diversity.py -i /sc/hydra/work/buk02/transferlearning/otu_table_no_singletons_filt1000_filt0.0001.biom -m PD_whole_tree -o /sc/hydra/work/buk02/transferlearning/adiv_pd.txt -t /sc/orga/projects/clemej05a/data/gg_13_8_otus/trees/97_otus.tree

# beta div
# do in non qiime environment
python /sc/hydra/work/buk02/CUTIE/scripts/generate_lsf_chimera.py -c /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/outputs/bdiv_commands.txt -o /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/outputs/ -n 4 -w 96:00 -s True

module load anaconda2 && source activate qiime1.9.1 && export PYTHONPATH=/hpc/packages/minerva-centos7/anaconda2/2019.03/pkgs && beta_diversity_through_plots.py -i /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/outputs/merged_otu_table_filt1000_nosingletons.biom -o /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/bdiv/ -m /sc/hydra/work/buk02/transferlearning/HMP/MOMSPI/outputs/HMP_dummy_map.txt -e 1000 -a -O 20 -t /sc/orga/projects/clemej05a/data/gg_13_8_otus/trees/97_otus.tree




###
# IGAL ROUND 4
###

module load anaconda2
source activate qiime1.9.1
export PYTHONPATH=/hpc/packages/minerva-centos7/anaconda2/2019.03/pkgs

biom summarize-table -i /sc/hydra/work/buk02/igal_data/igal_round4/otu_table.gender.biom -o /sc/hydra/work/buk02/igal_data/igal_round4/otu_table.gender_summary.txt

summarize_taxa.py -i /sc/hydra/work/buk02/igal_data/igal_round4/otu_table.gender.biom -o /sc/hydra/work/buk02/igal_data/igal_round4/ -L 6


###
# LODI
###

for dir in /Users/KevinBu/Desktop/clemente_lab/iclust/data/lodi_trajs/*;
do
for f in $dir/*.txt;
do
fn=${f##*/}
python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/plot_correlations.py -i ${f} -o $dir/ --labeled -l ID -s 0 -n 1 -sv 0 -dl lodi_noninterp_${fn%.txt} --lines --fixaxis --axis_off
mkdir /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/lodi_trajs/lodi_noninterp_${fn%.txt}_0_1x_0.0_iclust/
python3 /Users/KevinBu/Desktop/clemente_lab/iclust/scripts/image_cluster.py -i $dir/lodi_noninterp_${fn%.txt}_0_1x_0.0 -o /Users/KevinBu/Desktop/clemente_lab/iclust/data_analysis/lodi_trajs/lodi_noninterp_${fn%.txt}_0_1x_0.0_iclust/ -l True -m 20 --imageclustering
done;
done

echo ${f##*/} # gets basename with extension
echo ${f%/*} # gets path (dirname)



###
# Ensemble
###

module load anaconda
source activate qiime1.9.1

# to get counts
biom summarize-table -i .biom -o blah.txt

# manually had to put 'taxa' in front
# convert to biom
biom convert -i /sc/hydra/work/buk02/ensemble/otu_final_counts.txt -o /sc/hydra/work/buk02/ensemble/otu_final_counts.from_txt_hdf5.biom --table-type="OTU table" --to-hdf5

biom convert -i /sc/hydra/work/buk02/ensemble/otu_final_counts_drop0.txt -o /sc/hydra/work/buk02/ensemble/otu_final_counts_drop0.from_txt_hdf5.biom --table-type="OTU table" --to-hdf5

# multiply by large number

# non rarefy
beta_diversity_through_plots.py -i /sc/hydra/work/buk02/ensemble/otu_final_counts.from_txt_hdf5.biom -o /sc/hydra/work/buk02/ensemble/bdiv_final_counts_nonrarefied/ -m /sc/hydra/work/buk02/ensemble/mapping_file.txt -p /sc/hydra/work/buk02/ensemble/parameters.txt -a -O 20

python /sc/hydra/work/buk02/CUTIE/scripts/generate_lsf_chimera.py -c /sc/hydra/work/buk02/ensemble/bdiv_final_counts_nonrarefied.txt -N bdiv_final_counts_nonrarefied -o /sc/hydra/work/buk02/ensemble/ -n 2 -w 2:00 -s False

-e 1000
-t /sc/orga/projects/clemej05a/data/gg_13_8_otus/trees/97_otus.tree



# rarefy and non rarefy

# replace 0s with 1s and not

# min number
6,195,065.000


biom convert -i /sc/hydra/work/buk02/ensemble/otu_final.txt -o /sc/hydra/work/buk02/ensemble/otu_final.from_txt_hdf5.biom --table-type="OTU table" --to-hdf5



beta_diversity_through_plots.py -i /sc/hydra/work/buk02/ensemble/otu_final.from_txt_hdf5.biom -o /sc/hydra/work/buk02/ensemble/bdiv -m /sc/hydra/work/buk02/ensemble/mapping_file.txt -e 1000 -a -O 20 -t /sc/orga/projects/clemej05a/data/gg_13_8_otus/trees/97_otus.tree



###
# Transfer learning
###

/sc/hydra/work/buk02/transferlearning/
97_otus.tree  otu_table.biom  qiime_mapping_file.tsv

module purge
module load anaconda2
# conda activate qiime1.9.1
source activate qiime1.9.1
export PYTHONPATH=/hpc/packages/minerva-centos7/anaconda2/2019.03/pkgs


# remove singletons
filter_otus_from_otu_table.py -i /sc/hydra/work/buk02/transferlearning/AG/otu_table.biom -o /sc/hydra/work/buk02/transferlearning/AG/otu_table_no_singletons.biom -n 2

# filter on 1000
# then remove blanks
filter_samples_from_otu_table.py -i /sc/hydra/work/buk02/transferlearning/AG/otu_table_no_singletons.biom -o /sc/hydra/work/buk02/transferlearning/AG/otu_table_no_singletons_filt1000.biom -n 1000

# filter to 0.0001
filter_otus_from_otu_table.py -i /sc/hydra/work/buk02/transferlearning/AG/otu_table_no_singletons_filt1000.biom -o /sc/hydra/work/buk02/transferlearning/AG/otu_table_no_singletons_filt1000_filt0.0001.biom --min_count_fraction=0.0001

# convert to txt unsummarized
biom convert -i /sc/hydra/work/buk02/transferlearning/AG/otu_table_no_singletons_filt1000_filt0.0001.biom -o /sc/hydra/work/buk02/transferlearning/AG/otu_table_no_singletons_filt1000_filt0.0001.txt --to-tsv

biom convert -i /sc/hydra/work/buk02/transferlearning/AG/otu_table_no_singletons_filt1000.biom -o /sc/hydra/work/buk02/transferlearning/AG/otu_table_no_singletons_filt1000.txt --to-tsv

# summarize L5-7
summarize_taxa.py -i /sc/hydra/work/buk02/transferlearning/AG/otu_table_no_singletons_filt1000_filt0.0001.biom -o /sc/hydra/work/buk02/transferlearning/AG/ -L 5,6,7
summarize_taxa.py -i /sc/hydra/work/buk02/transferlearning/AG/otu_table_no_singletons_filt1000.biom -o /sc/hydra/work/buk02/transferlearning/AG/ -L 5,6,7




### TBD ADIV / BDIV Z SCORES

# alpha diversity
alpha_diversity.py -i /sc/hydra/work/buk02/transferlearning/otu_table_no_singletons_filt1000_filt0.0001.biom -m PD_whole_tree -o /sc/hydra/work/buk02/transferlearning/adiv_pd.txt -t /sc/orga/projects/clemej05a/data/gg_13_8_otus/trees/97_otus.tree

alpha_diversity.py -i /sc/hydra/work/buk02/transferlearning/otu_table_no_singletons_filt1000_filt0.0001.biom -m PD_whole_tree -o /sc/hydra/work/buk02/transferlearning/adiv_pd.txt -t /sc/orga/projects/clemej05a/data/gg_13_8_otus/trees/97_otus.tree



# beta div
# do in non qiime environment
python /sc/hydra/work/buk02/CUTIE/scripts/generate_lsf_chimera.py -c /sc/hydra/work/buk02/transferlearning/bdiv_commands.txt -o /sc/hydra/work/buk02/transferlearning/ -n 4 -w 96:00 -s True

module load anaconda2 && source activate qiime1.9.1 && export PYTHONPATH=/hpc/packages/minerva-centos7/anaconda2/2019.03/pkgs && beta_diversity_through_plots.py -i /sc/hydra/work/buk02/transferlearning/otu_table_no_singletons_filt1000_filt0.0001.biom -o /sc/hydra/work/buk02/transferlearning/bdiv/ -m /sc/hydra/work/buk02/transferlearning/qiime_mapping_file.tsv -e 1000 -a -O 20 -t /sc/orga/projects/clemej05a/data/gg_13_8_otus/trees/97_otus.tree


# sparcc on L5
# convert to absolute

summarize_taxa.py -i /sc/hydra/work/buk02/transferlearning/otu_table_no_singletons_filt1000_filt0.0001.biom -o /sc/hydra/work/buk02/transferlearning/absolute/ -L 5,6,7 -a


module purge
module load anaconda2
source activate qiime1.9.1
export PYTHONPATH=/hpc/packages/minerva-centos7/anaconda2/2019.03/pkgs
ml -python


# obtain corrs
SparCC.py /sc/hydra/work/buk02/transferlearning/absolute/otu_table_no_singletons_filt1000_filt0.0001_L5.txt -i 20 --cor_file=/sc/hydra/work/buk02/transferlearning/absolute/otu_table_no_singletons_filt1000_filt0.0001_L5.sparcc.out

python /Users/KevinBu/Desktop/clemente_lab/Software/SparCC/MakeBootstraps.py /Users/KevinBu/Desktop/clemente_lab/IgAl/igal_round3/igal_combined/otu_table.no_siblings.nondupids.nosingletons.filt0.0001_del1.txt -n 100 -t permutation_#.txt -p /Users/KevinBu/Desktop/clemente_lab/IgAl/igal_round3/igal_combined/pvals/

for i in {0..99};
do
python /Users/KevinBu/Desktop/clemente_lab/Software/SparCC/SparCC.py /Users/KevinBu/Desktop/clemente_lab/IgAl/igal_round3/igal_combined/pvals/permutation_$i.txt -i 20 --cor_file=/Users/KevinBu/Desktop/clemente_lab/IgAl/igal_round3/igal_combined/pvals/perm_cor_$i.txt;
done

python /Users/KevinBu/Desktop/clemente_lab/Software/SparCC/PseudoPvals.py /Users/KevinBu/Desktop/clemente_lab/IgAl/igal_round3/igal_combined/otu_table.no_siblings.nondupids.nosingletons.filt0.0001_del1.sparcc.out /Users/KevinBu/Desktop/clemente_lab/IgAl/igal_round3/igal_combined/pvals/perm_cor_#.txt 100 -o /Users/KevinBu/Desktop/clemente_lab/IgAl/igal_round3/igal_combined/pvals/pvals.two_sided.txt -t two_sided



# should examine which taxa are in the blanks
# refer to Sabrina for commonly used list of decontaminants
filter_otus_from_otu_table.py -i otu_table.biom -o otu_table_non_chimeric.biom -e chimeric_otus.txt


###############
# Strainphlan #
###############

FOCUS samples: MET164, MET22, MET211
ml metaphlan/097a52362c79
ml samtools/0.1.19
ml muscle
ml raxml
ml blast


# data
/sc/orga/projects/clemej05a/FOCUS/inputs/australian_data.full.cat

for file in /sc/orga/projects/clemej05a/FOCUS/inputs/australian_data.full.cat/*.fastq; do f=basename "$file" f="$(basename -- ${file%.fastq})" echo $f; done


for file in /sc/orga/projects/clemej05a/FOCUS/inputs/australian_data.full.cat/*;
do
f=${file##*/}
echo "module purge && module load metaphlan/097a52362c79 && module load samtools/0.1.19 && module load muscle && module load raxml && module load blast && metaphlan2.py $file /sc/hydra/work/buk02/strainphlan_analysis/${f}_profile.txt --bowtie2out /sc/hydra/work/buk02/strainphlan_analysis/${f}_bowtie2.txt --samout /sc/hydra/work/buk02/strainphlan_analysis/${f}.sam.bz2 --input_type multifastq --bowtie2db /sc/hydra/work/buk02/strainphlan_analysis/METAPHLAN_BOWTIE2_DB && sample2markers.py --ifn_samples /sc/hydra/work/buk02/strainphlan_analysis/${f}.sam.bz2 --input_type sam --output_dir /sc/hydra/work/buk02/strainphlan_analysis/" > /sc/hydra/work/buk02/strainphlan_analysis/${f}_commands.txt;
done

# modules for generate_lsf_chimera
ml python/3.7.3
ml py_packages/3.7
export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.7/site-packages/

for file in /sc/orga/projects/clemej05a/FOCUS/inputs/australian_data.full.cat/*;
do
f=${file##*/}
python /sc/hydra/work/buk02/CUTIE/scripts/generate_lsf_chimera.py -c /sc/hydra/work/buk02/strainphlan_analysis/${f}_commands.txt -N ${f} -o /sc/hydra/work/buk02/strainphlan_analysis/ -n 4 -w 96:00 -s True
done

# reload new modules
ml metaphlan/097a52362c79
ml samtools/0.1.19
ml muscle
ml raxml
ml blast

strainphlan.py --ifn_samples /sc/hydra/work/buk02/strainphlan_analysis/*.markers --output_dir /sc/hydra/work/buk02/strainphlan_analysis/ --print_clades_only > /sc/hydra/work/buk02/strainphlan_analysis/clades.txt

mkdir /sc/hydra/work/buk02/strainphlan_analysis/db_markers/
bowtie2-inspect /sc/hydra/work/buk02/strainphlan_analysis/METAPHLAN_BOWTIE2_DB/mpa_v20_m200 > /sc/hydra/work/buk02/strainphlan_analysis/db_markers/all_markers.fasta
extract_markers.py --mpa_pkl /sc/hydra/work/buk02/strainphlan_analysis/METAPHLAN_BOWTIE2_DB/mpa_v20_m200.pkl --ifn_markers /sc/hydra/work/buk02/strainphlan_analysis/db_markers/all_markers.fasta --clade s__Sutterella_wadsworthensis --ofn_markers /sc/hydra/work/buk02/strainphlan_analysis/db_markers/s__Sutterella_wadsworthensis.markers.fasta

# no ref
strainphlan.py --ifn_samples /sc/hydra/work/buk02/strainphlan_analysis/*.markers --ifn_markers /sc/hydra/work/buk02/strainphlan_analysis/db_markers/s__Sutterella_wadsworthensis.markers.fasta --output_dir /sc/hydra/work/buk02/strainphlan_analysis/s__Sutterella_wadsworthensis/ --clades s__Sutterella_wadsworthensis --marker_in_clade 0.8
# default 0.8, 0.2 in tutorial


# with 'fake' ref
strainphlan.py --ifn_samples /sc/hydra/work/buk02/strainphlan_analysis/*.markers --ifn_markers /sc/hydra/work/buk02/strainphlan_analysis/db_markers/s__Sutterella_wadsworthensis.markers.fasta --ifn_ref_genomes s__Sutterella_wadsworthensis.fna --output_dir /sc/hydra/work/buk02/strainphlan_analysis/s__Sutterella_wadsworthensis/ --clades s__Sutterella_wadsworthensis --marker_in_clade 0.2


while read p; do
    mkdir /sc/hydra/work/buk02/strainphlan_analysis/$p
    extract_markers.py --mpa_pkl /sc/hydra/work/buk02/strainphlan_analysis/METAPHLAN_BOWTIE2_DB/mpa_v20_m200.pkl --ifn_markers /sc/hydra/work/buk02/strainphlan_analysis/db_markers/all_markers.fasta --clade $p --ofn_markers /sc/hydra/work/buk02/strainphlan_analysis/db_markers/${p}.markers.fasta
    strainphlan.py --ifn_samples /sc/hydra/work/buk02/strainphlan_analysis/*.markers --ifn_markers /sc/hydra/work/buk02/strainphlan_analysis/db_markers/${p}.markers.fasta --output_dir /sc/hydra/work/buk02/strainphlan_analysis/${p}/ --clades $p --marker_in_clade 0.8
done </sc/hydra/work/buk02/strainphlan_analysis/clades.txt

###
# FOCUS R1
###

ml metaphlan/097a52362c79
ml samtools/0.1.19
ml muscle
ml raxml
ml blast



for file in /sc/orga/projects/clemej05a/FOCUS/inputs/australian_data.full.cat/*R1*;
do
f=${file##*/}
echo "module purge && module load metaphlan/097a52362c79 && module load samtools/0.1.19 && module load muscle && module load raxml && module load blast && metaphlan2.py $file /sc/hydra/work/buk02/FOCUS/R1/${f}_profile.txt --bowtie2out /sc/hydra/work/buk02/FOCUS/R1/${f}_bowtie2.txt --samout /sc/hydra/work/buk02/FOCUS/R1/${f}.sam.bz2 --input_type multifastq --bowtie2db /sc/hydra/work/buk02/strainphlan_analysis/METAPHLAN_BOWTIE2_DB && sample2markers.py --ifn_samples /sc/hydra/work/buk02/FOCUS/R1/${f}.sam.bz2 --input_type sam --output_dir /sc/hydra/work/buk02/FOCUS/R1/" > /sc/hydra/work/buk02/FOCUS/R1/${f}_commands.txt;
done

# modules for generate_lsf_chimera
ml python/3.7.3
ml py_packages/3.7
export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.7/site-packages/

for file in /sc/orga/projects/clemej05a/FOCUS/inputs/australian_data.full.cat/*R1*;
do
f=${file##*/}
python /sc/hydra/work/buk02/CUTIE/scripts/generate_lsf_chimera.py -c /sc/hydra/work/buk02/FOCUS/R1/${f}_commands.txt -N ${f} -o /sc/hydra/work/buk02/FOCUS/R1/ -n 4 -w 96:00 -s True
done

# reload new modules
ml metaphlan/097a52362c79
ml samtools/0.1.19
ml muscle
ml raxml
ml blast

strainphlan.py --ifn_samples /sc/hydra/work/buk02/FOCUS/R1/*.markers --output_dir /sc/hydra/work/buk02/FOCUS/R1/ --print_clades_only > /sc/hydra/work/buk02/FOCUS/R1/clades.txt

mkdir /sc/hydra/work/buk02/FOCUS/R1/db_markers/
while read p; do
    mkdir /sc/hydra/work/buk02/FOCUS/R1/$p
    extract_markers.py --mpa_pkl /sc/hydra/work/buk02/strainphlan_analysis/METAPHLAN_BOWTIE2_DB/mpa_v20_m200.pkl --ifn_markers /sc/hydra/work/buk02/FOCUS/R1/all_markers.fasta --clade $p --ofn_markers /sc/hydra/work/buk02/FOCUS/R1/db_markers/${p}.markers.fasta
    strainphlan.py --ifn_samples /sc/hydra/work/buk02/FOCUS/R1/*.markers --ifn_markers /sc/hydra/work/buk02/FOCUS/R1/db_markers/${p}.markers.fasta --output_dir /sc/hydra/work/buk02/FOCUS/R1/${p}/ --clades $p --marker_in_clade 0.8
done </sc/hydra/work/buk02/FOCUS/R1/clades.txt



###
# FOCUS R2
###

for file in /sc/orga/projects/clemej05a/FOCUS/inputs/australian_data.full.cat/*R2*;
do
f=${file##*/}
echo "module purge && module load metaphlan/097a52362c79 && module load samtools/0.1.19 && module load muscle && module load raxml && module load blast && metaphlan2.py $file /sc/hydra/work/buk02/FOCUS/R2/${f}_profile.txt --bowtie2out /sc/hydra/work/buk02/FOCUS/R2/${f}_bowtie2.txt --samout /sc/hydra/work/buk02/FOCUS/R2/${f}.sam.bz2 --input_type multifastq --bowtie2db /sc/hydra/work/buk02/strainphlan_analysis/METAPHLAN_BOWTIE2_DB && sample2markers.py --ifn_samples /sc/hydra/work/buk02/FOCUS/R2/${f}.sam.bz2 --input_type sam --output_dir /sc/hydra/work/buk02/FOCUS/R2/" > /sc/hydra/work/buk02/FOCUS/R2/${f}_commands.txt;
done

# modules for generate_lsf_chimera
ml python/3.7.3
ml py_packages/3.7
export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.7/site-packages/

for file in /sc/orga/projects/clemej05a/FOCUS/inputs/australian_data.full.cat/*R2*;
do
f=${file##*/}
python /sc/hydra/work/buk02/CUTIE/scripts/generate_lsf_chimera.py -c /sc/hydra/work/buk02/FOCUS/R2/${f}_commands.txt -N ${f} -o /sc/hydra/work/buk02/FOCUS/R2/ -n 4 -w 96:00 -s True
done




# reload new modules
ml metaphlan/097a52362c79
ml samtools/0.1.19
ml muscle
ml raxml
ml blast

strainphlan.py --ifn_samples /sc/hydra/work/buk02/FOCUS/R2/*.markers --output_dir /sc/hydra/work/buk02/FOCUS/R2/ --print_clades_only > /sc/hydra/work/buk02/FOCUS/R2/clades.txt

mkdir /sc/hydra/work/buk02/FOCUS/R2/db_markers/
while read p; do
    mkdir /sc/hydra/work/buk02/FOCUS/R2/$p
    extract_markers.py --mpa_pkl /sc/hydra/work/buk02/strainphlan_analysis/METAPHLAN_BOWTIE2_DB/mpa_v20_m200.pkl --ifn_markers /sc/hydra/work/buk02/FOCUS/R2/all_markers.fasta --clade $p --ofn_markers /sc/hydra/work/buk02/FOCUS/R2/db_markers/${p}.markers.fasta
    strainphlan.py --ifn_samples /sc/hydra/work/buk02/FOCUS/R2/*.markers --ifn_markers /sc/hydra/work/buk02/FOCUS/R2/db_markers/${p}.markers.fasta --output_dir /sc/hydra/work/buk02/FOCUS/R2/${p}/ --clades $p --marker_in_clade 0.8
done </sc/hydra/work/buk02/FOCUS/R2/clades.txt




###
# CUTIE NEW SIMULATIONS
###

# for generating correlations; echo commands need to be run only once
echo "module load R && Rscript /sc/hydra/work/buk02/CUTIE/scripts/new_simulations.R --n_samp 50 --max_seed 19 --start 0 --stop 0.95 --step 0.05 --output '/sc/hydra/work/buk02/new_simulations/'" > /sc/hydra/work/buk02/new_commands/gen_sims.txt

python /sc/hydra/work/buk02/CUTIE/scripts/generate_lsf_chimera.py -c /sc/hydra/work/buk02/new_commands/sim_commands.txt -N gen_sims -o /sc/hydra/work/buk02/new_commands/ -n 2 -w 1:00 -s True

20 corrs * 3 classes * 20 seeds = 1200 plots


# job for generating configs
echo "module load python/3.7.3 && export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.7/site-packages/ && for s in kpc ksc kkc mine rpc rsc rkc rmine; do for v in 1 10; do for n in 50; do python /sc/hydra/work/buk02/CUTIE/scripts/gen_commands_configs.py -m nomc -mpfp /sc/hydra/work/buk02/MIC_MSQ/mine_pvals/n=\$n,alpha=0.6.csv -fv \$v -s \$s -c False -w /sc/hydra/scratch/buk02/new_simulations/ -i /sc/hydra/work/buk02/new_simulations/ -o /sc/hydra/work/buk02/new_configs/; done; done; done;" > /sc/hydra/work/buk02/new_commands/gen_configs.txt

python /sc/hydra/work/buk02/CUTIE/scripts/generate_lsf_chimera.py -c /sc/hydra/work/buk02/new_commands/gen_configs.txt -N gen_configs -o /sc/hydra/work/buk02/new_commands/ -n 2 -w 4:00 -s True


# job for running configs
echo "module load python/3.7.3 && export PYTHONPATH=\$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.7/site-packages/ && for file in /sc/hydra/work/buk02/new_configs/*/commands*; do python /sc/hydra/work/buk02/CUTIE/scripts/generate_lsf_chimera.py -c \$file -N \${file##*/} -o \${file%/*} -n 2 -w 2:00 -s True; done" > /sc/hydra/work/buk02/new_commands/run_cutie.txt

python /sc/hydra/work/buk02/CUTIE/scripts/generate_lsf_chimera.py -c /sc/hydra/work/buk02/new_commands/run_cutie.txt -N run_cutie -o /sc/hydra/work/buk02/new_commands/ -n 4 -w 24:00 -s True

1200 plots * 8 statistics * 2 fold values = 19200 jobs




# jobs for analyzing simulations; echo command only needs to be run once
echo "module load python/3.7.3 && export PYTHONPATH=$PYTHONPATH:/hpc/users/buk02/tools/sandbox/lib/python3.7/site-packages/ && python /sc/hydra/work/buk02/CUTIE/scripts/analyze_simulations.py -fv 1,10 -s kpc,rpc -m nomc -c False -cl FN,NP,FP -nse 20 -nsa 50 -rn 0,0.9,0.05 -i /sc/hydra/scratch/buk02/new_simulations/ -o /sc/hydra/work/buk02/plots/" > /sc/hydra/work/buk02/plots/commands.txt

python /sc/hydra/work/buk02/CUTIE/scripts/generate_lsf_chimera.py -c /sc/hydra/work/buk02/plots/commands.txt -N analyze_sims -o /sc/hydra/work/buk02/plots/ -n 2 -w 4:00 -s True








# in qiime env

module load anaconda2
source activate qiime1.9.1
export PYTHONPATH=/hpc/packages/minerva-centos7/anaconda2/2019.03/pkgs


filter_otus_from_otu_table.py -i /sc/hydra/work/buk02/enrica_data/CRC_adv_L5/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def_nosingletons__New_Grouping_Advance_Cancer__.biom -o /sc/hydra/work/buk02/enrica_data/CRC_adv_L5/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def_nosingletons__New_Grouping_Advance_Cancer__filt0.0001.biom --min_count_fraction=0.0001

summarize_taxa.py -i /sc/hydra/work/buk02/enrica_data/CRC_adv_L5/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def_nosingletons__New_Grouping_Advance_Cancer__filt0.0001.biom -o /sc/hydra/work/buk02/transferlearning/AG/ -L 5,6,7


filter_otus_from_otu_table.py -i /sc/hydra/work/buk02/enrica_data/CRC_nonadv_L5/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def_nosingletons__New_Grouping_Healthy_Non_Advance__.biom -o /sc/hydra/work/buk02/enrica_data/CRC_nonadv_L5/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def_nosingletons__New_Grouping_Healthy_Non_Advance__filt0.0001.biom --min_count_fraction=0.0001

summarize_taxa.py -i /sc/hydra/work/buk02/enrica_data/CRC_adv_L5/filtered_otu_table_800_no_contaminants_CANCER_diagnosis_def_nosingletons__New_Grouping_Healthy_Non_Advance__filt0.0001.biom -o /sc/hydra/work/buk02/transferlearning/AG/ -L 5,6,7



