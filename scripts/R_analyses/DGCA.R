# Step 1. Load the DGCA R package.
# library(DGCA)
# Step 2. Read in the gene expression matrix.
# data(darmanis)
# Step 3. Read in the design matrix.
# data(design_mat)
# Step 4. Perform the basic differential correlation analysis for the gene RTN4 between oligodendrocytes and neurons. 
# dgca_res = ddcorAll(inputMat = darmanis, design = desmat, corrType = 'spearman', compare = c('oligodendrocyte', 'neuron'), adjust = 'perm', nPerm = 10, splitSet = 'RTN4')
# Step 5. View the top 20 genes differentially correlated with RTN4 as well as their differential correlation statistics. 
# head(dgca_res, 20)
# Step 6. Visualize the correlation in each condition between RTN4 and its top differentially correlated gene pair in this data set. 
# plotCors(inputMat = darmanis, design = design_mat, compare = c('oligodendrocyte', 'neuron'), geneA = 'RTN4', geneB = 'COX6A1')

library(DGCA)
library(readr)
# load in OTU tables corresponding to different groups
df_otu_A = read_delim('/Users/KevinBu/Desktop/clemente_lab/IgAl/data_analysis/igal_round3/df_otu_A.txt', delim = '\t')
df_otu_B = read_delim('/Users/KevinBu/Desktop/clemente_lab/IgAl/data_analysis/igal_round3/df_otu_B.txt', delim = '\t')
df_meta_A = read_delim('/Users/KevinBu/Desktop/clemente_lab/IgAl/data_analysis/igal_round3/df_meta_A.txt', delim = '\t')
df_meta_B = read_delim('/Users/KevinBu/Desktop/clemente_lab/IgAl/data_analysis/igal_round3/df_meta_B.txt', delim = '\t')

# obtain sample names
s_names = append(df_otu_A$index, df_otu_B$index)
s_names = append(df_meta_A$index, df_meta_B$index)

# create design matrix
group_A = append(rep(1, length(df_otu_A$index)), rep(0, length(df_otu_B$index)))
group_B = append(rep(0, length(df_otu_A$index)), rep(1, length(df_otu_B$index)))

# edit otu data and merge and transpose
df_otu_A = df_otu_A[,-1]
df_otu_B = df_otu_B[,-1]
df_meta_A = df_meta_A[,-1]
df_meta_B = df_meta_B[,-1]

df_otu_AB = rbind(df_otu_A, df_otu_B)
df_meta_AB = rbind(df_meta_A, df_meta_B)
df_complete = cbind(df_otu_AB, df_meta_AB)
df_complete = t(df_complete)
colnames(df_complete) = s_names
v_names = rownames(df_complete)
df_complete = data.frame(df_complete)
df_complete <- data.frame(lapply(df_complete, as.numeric))
v_ids = rownames(df_complete)
# rownames(df_complete) = v_names
# df_complete = as.data.frame(as.numeric(unlist(df_complete)))

# create design matrix 
desmat = data.frame(group_A = as.numeric(group_A), group_B = as.numeric(group_B))
desmat = data.matrix(desmat)

# create dgca result
# obtain all correlations to a specific bacteria
x = data.frame()
for (v in v_ids){
  dgca = ddcorAll(inputMat = df_complete, design = desmat, corrType = 'spearman', compare = c('group_A', 'group_B'), 
                  adjust = 'perm', nPerm = 10, splitSet = v)
  x = rbind(x, dgca)
}

completeFun <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}

y = completeFun(x, c('Gene1','Gene2'))
# y <- y[1:1000,]
y = data.frame(lapply(y, as.numeric))
for (i in 1:nrow(y))
{
  y[i,1:2] = sort(y[i,1:2])
}
y = y[!duplicated(y[,1:2]),]

y$'fdr' = p.adjust(y$pValDiff, method = 'fdr')
z = y
z = z[order(z$fdr),]
sig_z = subset(z, fdr <= 0.05)

library(ggplot2)
for (i in 1:nrow(sig_z)){
  plotCors(inputMat = df_complete, design = desmat, compare = c('group_A', 'group_B'),
           geneA = sig_z[i,]$Gene1, 
           geneB = sig_z[i,]$Gene2)
  # ggsave(paste('/Users/KevinBu/Desktop/clemente_lab/IgAl/data_analysis/DGCA_igal/',sig_z[i,]$Gene1,'_',sig_z[i,]$Gene2,'.pdf', sep = ''))
  ggsave(paste('/Users/KevinBu/Desktop/clemente_lab/IgAl/data_analysis/DGCA_igal/',v_names[sig_z[i,]$Gene1],'_',v_names[sig_z[i,]$Gene2],'.pdf', sep = ''))
}


sig_z2 = subset(z, pValDiff <= 0.05)

library(ggplot2)
for (i in 1:nrow(sig_z2)){
  plotCors(inputMat = df_complete, design = desmat, compare = c('group_A', 'group_B'),
           geneA = sig_z2[i,]$Gene1, 
           geneB = sig_z2[i,]$Gene2)
  # ggsave(paste('/Users/KevinBu/Desktop/clemente_lab/IgAl/data_analysis/DGCA_igal/',sig_z[i,]$Gene1,'_',sig_z[i,]$Gene2,'.pdf', sep = ''))
  ggsave(paste('/Users/KevinBu/Desktop/clemente_lab/IgAl/data_analysis/DGCA_igal/plots_nofdr/',v_names[sig_z2[i,]$Gene1],'_',v_names[sig_z2[i,]$Gene2],'.pdf', sep = ''))
}


  