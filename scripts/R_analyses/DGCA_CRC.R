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
df_complete = read_delim('Desktop/clemente_lab/CUTIE/data_analysis/CRC_DGCA/df_complete.txt', delim = '\t')
# path = 'dgca_plots_nofilt'
path = 'dgca_plots_forpaper'


# obtain sample names
s_names = df_complete$`#SampleID`

# create design matrix
group_A = ifelse(df_complete$New_Grouping == 'Advance_Cancer',1,0)
group_B = ifelse(df_complete$New_Grouping == 'Healthy_Non_Advance',1,0)

df_complete = subset(df_complete, select = -c(New_Grouping))
df_complete = t(df_complete)
colnames(df_complete) = df_complete[1,]
df_complete = df_complete[-1,]
df_complete = data.frame(df_complete)
v_names = rownames(df_complete)
as.numeric.factor <- function(x) {as.numeric(levels(x))[x]}
df_complete <- data.frame(lapply(df_complete, as.numeric.factor))

# create design matrix 
desmat = data.frame(group_A = as.numeric(group_A), group_B = as.numeric(group_B))
desmat = data.matrix(desmat)

v_ids = rownames(df_complete)

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
dir.create(paste('/Users/KevinBu/Desktop/clemente_lab/CUTIE/data_analysis/CRC_DGCA/',path,sep=''))
for (i in 1:nrow(sig_z)){
  plotCors(inputMat = df_complete, design = desmat, compare = c('group_A', 'group_B'),
           geneA = sig_z[i,]$Gene1, 
           geneB = sig_z[i,]$Gene2)
  ggsave(paste('/Users/KevinBu/Desktop/clemente_lab/CUTIE/data_analysis/CRC_DGCA/',path,'/',
               v_names[sig_z[i,]$Gene1],'xxx',v_names[sig_z[i,]$Gene2],'yyy',
               sig_z[i,]$pValDiff,'zzz',sig_z[i,]$fdr,'.pdf', sep = ''))
}

sig_z2 = subset(z, pValDiff <= 0.05)

v = c(5, 6, 8, 13, 15,21, 25, 27, 28, 98)
dir.create(paste('/Users/KevinBu/Desktop/clemente_lab/CUTIE/data_analysis/CRC_DGCA/',path,'_nofdr',sep=''))
for (i in 1:nrow(sig_z2)){
  plotCors(inputMat = df_complete, design = desmat, compare = c('group_A', 'group_B'),
           geneA = sig_z2[i,]$Gene1, 
           geneB = sig_z2[i,]$Gene2,
           xlab = v_names[sig_z2[i,]$Gene1],
           ylab = v_names[sig_z2[i,]$Gene2])
  if ((sig_z2[i,]$Gene1 %in% v) && (sig_z2[i,]$Gene2 %in% v)){
    ggsave(paste('/Users/KevinBu/Desktop/clemente_lab/CUTIE/data_analysis/CRC_DGCA/',path,'_nofdr/'
                 ,v_names[sig_z2[i,]$Gene1],'xxx',v_names[sig_z2[i,]$Gene2],'yyy',
                 sig_z2[i,]$pValDiff,'zzz',sig_z2[i,]$fdr,'.pdf', sep = ''))
  }
}

# 98 is entero
# 5, 6, 8, 13, 15 21 25 27 28
# HCA? Legionellaceae?

  