###
# AlCoB Analysis: Set pwd, load libraries
###
library(readr)
library(ggplot2)
library('reshape2')
setwd("/Users/kbpi31415/Desktop/Clemente Lab/CUtIe/data_analysis")

###
# Functions
###

# scaling
range01 <- function(x){(x-min(x))/(max(x)-min(x))}
range01m <- function(x, ...){(x - min(x, ...)) / (max(x, ...) - min(x, ...))}

# transparency
makeTransparent<-function(someColor, alpha=100)
{
  newColor<-col2rgb(someColor)
  apply(newColor, 2, function(curcoldata){rgb(red=curcoldata[1], green=curcoldata[2],
                                              blue=curcoldata[3],alpha=alpha, maxColorValue=255)})
}

###
# Lung Pneumotyping (Pearson, FDR)
###

path = 'alcob_lung_pointwise_kpc1fdr0.05'

datafx <- read_delim("~/Desktop/Clemente Lab/CUtIe/data/lung_pt/otu_table_MultiO_merged___L6.txt",
                     "\t",escape_double=FALSE,skip=1)
typex = 'otu'
offsetx = 1
datafy <- read_delim("~/Desktop/Clemente Lab/CUtIe/data/lung_pt/Mapping.Pneumotype.Multiomics.RL.NYU.w_metabolites.w_inflamm.txt",
                     "\t",escape_double=FALSE)
typey = 'map'
offsety = 18

paired = FALSE
cutie = 'cutie_1pc'

###
# Lung Pneumotyping (Spearman, No-MC)
###

path = 'alcob_lung_pointwise_ksc1nomc0.05'

datafx <- read_delim("~/Desktop/Clemente Lab/CUtIe/data/lung_pt/otu_table_MultiO_merged___L6.txt",
                     "\t",escape_double=FALSE,skip=1)
typex = 'otu'
offsetx = 1
datafy <- read_delim("~/Desktop/Clemente Lab/CUtIe/data/lung_pt/Mapping.Pneumotype.Multiomics.RL.NYU.w_metabolites.w_inflamm.txt",
                     "\t",escape_double=FALSE)
typey = 'map'
offsety = 18

paired = FALSE
cutie = 'cutie_1sc'


###
# Lung MSQ (Pearson, FDR)
###

path = 'alcob_MSQ_pointwise_kpc1fdr0.05'

datafx <- read_delim("/Users/kbpi31415/Desktop/Clemente Lab/CUtIe/data/pre_sparcc_MSQ/otu_table.MSQ34_L6.txt",
                     "\t",escape_double=FALSE,skip=1)
typex = 'otu'
offsetx = 1
datafy <- read_delim("/Users/kbpi31415/Desktop/Clemente Lab/CUtIe/data/pre_sparcc_MSQ/otu_table.MSQ34_L6.txt",
                     "\t",escape_double=FALSE,skip=1)
typey = 'otu'
offsety = 1

paired = TRUE
cutie = 'cutie_1pc'

###
# Lung MSQ (Spearman, FDR)
###

path = 'alcob_MSQ_pointwise_ksc1fdr0.05'

datafx <- read_delim("/Users/kbpi31415/Desktop/Clemente Lab/CUtIe/data/pre_sparcc_MSQ/otu_table.MSQ34_L6.txt",
                     "\t",escape_double=FALSE,skip=1)
typex = 'otu'
offsetx = 1
xlower = NA
xupper = NA

datafy <- read_delim("~/Desktop/Clemente Lab/CUtIe/data/lung_pt/Mapping.Pneumotype.Multiomics.RL.NYU.w_metabolites.w_inflamm.txt",
                     "\t",escape_double=FALSE)
typey = 'map'
offsety = 18
ylower = 18
yupper = 100




###
# Analysis chunk POINTWISE
###

if (typex == 'otu') {
  xnames = datafx[,1]
} else if (typex == 'map') {
  xnames = colnames(datafx)[xlower:xupper]
}

if (typey == 'otu') {
  ynames = datafy[,1]
} else if (typey == 'map') {
  ynames = colnames(datafy)[ylower:yupper]
}

if (paired == FALSE){
  colnames(datafy)[1] <- c("SampleID")
  target <- names(datafx)[-1]
  datafy = datafy[match(target, datafy$SampleID),]
}

all_points_R_matrix_ <- read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path, "data_processing/all_points_R_matrix_.txt"),
                                   "\t", escape_double = FALSE)



all_pairs <- read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path, "data_processing/all_pairs.txt"),
                        "\t", escape_double = FALSE)

if (paired == TRUE)
{
  all_pairs <- subset(all_pairs, all_pairs$var1 > all_pairs$var2)
}
R_matrix_L6_resample_1 <- read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path, "data_processing/R_matrix_L6_resample_1.txt"),
                                     "\t", escape_double = FALSE)

if (cutie == 'cutie_1sc')
{
  R_matrix_L6_resample_1$r2vals <- R_matrix_L6_resample_1$correlations ** 2
}

# each correlation is counted twice (x,y) and (y,x)
FP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators == -1,]
TP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators == 1,]
P = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators != 0,]

# each correlation counted once
PP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators != 0 & R_matrix_L6_resample_1$var1_index > R_matrix_L6_resample_1$var2_index,]
PFP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators == -1 & R_matrix_L6_resample_1$var1_index > R_matrix_L6_resample_1$var2_index,]
PTP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators == 1 & R_matrix_L6_resample_1$var1_index > R_matrix_L6_resample_1$var2_index,]

if (paired == TRUE)
{
  R_matrix_L6_resample_1P <- subset(R_matrix_L6_resample_1, R_matrix_L6_resample_1$var1_index > R_matrix_L6_resample_1$var2_index)
  attach(R_matrix_L6_resample_1P)
} else
{
  R_matrix_L6_resample_1P <- R_matrix_L6_resample_1
  attach(R_matrix_L6_resample_1)
}

colnames(all_pairs)[1] = 'var1_index'
colnames(all_pairs)[2] = 'var2_index'

complete <- merge(all_pairs, R_matrix_L6_resample_1P,by=c('var1_index', 'var2_index'))

P <- subset(complete, !(complete$cookd == 0 & complete$dffits == 0 & complete$dsr ==0))
P$indicators = ifelse(!(P$cookd == -1 & P$dffits == -1 & P$dsr ==-1),1,-1)
TP <- subset(P, !(P$cookd == -1 & P$dffits == -1 & P$dsr ==-1))
FP <- subset(P, (P$cookd == -1 & P$dffits == -1 & P$dsr ==-1))
c(nrow(P), nrow(TP), nrow(FP))


###
# UpSetR
###

library("UpSetR")
FP_json_matrix <- read_delim(paste(file.path(path,'data_processing','FP_json_matrix.txt')),
                             ";", escape_double = FALSE)
FP_json_matrix <- FP_json_matrix[,-ncol(FP_json_matrix)]
FP_json_matrix$corr_row <- factor(FP_json_matrix$corr_row)
upset(FP_json_matrix,empty.intersections = "on")

###
# Non UpSetR venn diagrams
###

# all these subsets are FP found in EXACTLY sets x, y, z
FP_cookd1_dsr1_dffits1 <- all_pairs[all_pairs$'dsr' == -1 & all_pairs$'cookd' == -1 & all_pairs$'dffits' == -1,]

FP_cookd1_dffits1 <- all_pairs[all_pairs$'dsr' != -1 & all_pairs$'cookd' == -1 & all_pairs$'dffits' == -1,]
FP_dsr1_dffits1 <- all_pairs[all_pairs$'dsr' == -1 & all_pairs$'cookd' != -1 & all_pairs$'dffits' == -1,]
FP_cookd1_dsr1 <- all_pairs[all_pairs$'dsr' == -1 & all_pairs$'cookd' == -1 & all_pairs$'dffits' != -1,]

FP_cookd1 <- all_pairs[all_pairs$'dsr' != -1 & all_pairs$'cookd' == -1 & all_pairs$'dffits' != -1,]
FP_dsr1 <- all_pairs[all_pairs$'dsr' == -1 & all_pairs$'cookd' != -1 & all_pairs$'dffits' != -1,]
FP_dffits1 <- all_pairs[all_pairs$'dsr' != -1 & all_pairs$'cookd' != -1 & all_pairs$'dffits' == -1,]


###
# All plots pointwise
###
graphbound = 15
dir.create(file.path(path, 'graphs'))

comment(FP_cookd1_dsr1_dffits1) <- "FP_cookd1_dsr1_dffits1"
comment(FP_cookd1_dffits1) <- "FP_cookd1_dffits1"
comment(FP_dsr1_dffits1) <- "FP_dsr1_dffits1"
comment(FP_cookd1_dsr1) <- "FP_cookd1_dsr1"
comment(FP_cookd1) <- "FP_cookd1"
comment(FP_dsr1) <- "FP_dsr1"
comment(FP_dffits1) <- "FP_dffits1"

dfList <- list(FP_cookd1_dsr1_dffits1,
               FP_cookd1_dffits1,
               FP_dsr1_dffits1,
               FP_cookd1_dsr1,
               FP_cookd1,
               FP_dsr1,
               FP_dffits1)

dfList <- lapply(dfList, function(dataf) {
  if (nrow(dataf) != 0) {
    dir.create(file.path(path, 'graphs',paste(comment(dataf),'only',nrow(dataf))))
    for (i in 1:min(graphbound,nrow(dataf)))
    {
      point1 = dataf$var1[i]  
      point2 = dataf$var2[i]  
      if (typex == 'otu') {
        x = as.numeric(datafx[point1 + offsetx,][-1])
      } else {
        x = datafx[,point1 + offsetx]
      }
      if (typey == 'otu') {
        y = as.numeric(datafy[point2 + offsety,][-1])
      } else {
        y = datafy[,point2 + offsety]
      }
      R_matrix <- R_matrix_L6_resample_1
      #if (paired == FALSE) {
      #  R_matrix <- R_matrix_L6_resample_1
      #} else {
      #  R_matrix <- R_matrix_L6_resample_1P
      #}
      pdf(paste(file.path(path, 'graphs',paste(comment(dataf),'only',nrow(dataf)),paste(comment(dataf),'only')),point1,'_',point2,'.pdf'), width=3, height=4)
      current_row <- subset(R_matrix, R_matrix$var1 == point1 & R_matrix$var2 == point2)
      plot(x,y,  main=paste('p = ', formatC(row$pvalues, format = "e", digits = 2),  '\n',
                            'worst p = ', formatC(row$worst_p, format = "e", digits = 2), '\n',
                            'Rsq = ',formatC(row$r2vals, format = "e", digits = 2), '\n',
                            'worst Rsq = ', formatC((row$worst_r)**2, format = "e", digits = 2)),
           xlab = paste('OTU ', point1 + offsetx),
           ylab = ynames[point2 + offsety],
           cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
      dev.off()
    }
  }
})





# CUtIe Severity
if (paired == FALSE) {
  R_matrix <- R_matrix_L6_resample_1
} else {
  R_matrix <- R_matrix_L6_resample_1P
}
pdf(paste(file.path(path,'graphs','P_Ratio_Severity.pdf')), width = 10, height = 8)
par(mfrow=c(2,1))
hist(log(TP$p_ratio), main=paste('Log(p`/p) of variables within \n each correlation (non-CUtIes) \n',#, nzero = ',sum(TP_norm_avg_var2 == 0),' \n ',
                                 'Mean = ', mean(log(TP$p_ratio)),  '\n',
                                 'Var = ', var(log(TP$p_ratio))))
hist(log(FP$p_ratio), main=paste('Log(p`/p) of variables within \n each correlation (CUtIes) \n',#, nzero = ',sum(FP_norm_var_var2 == 0),' \n ',
                                 'Mean = ', mean(log(FP$p_ratio)), '\n',
                                 'Var = ', var(log(FP$p_ratio))))

dev.off()

# GGPLOT severity
ggplot(FP, aes(log(FP$p_ratio))) +
  geom_histogram(binwidth=1) + 
  labs(title="Distribution of p-value ratios \n (within correlations containing outliers)", 
       x="log(p-value ratio)", 
       y="# of correlations")
ggsave(file.path(path,"graphs","FP_severity.pdf"), dpi=225, width=4, height=6)


ggplot(TP, aes(log(TP$p_ratio))) +
  geom_histogram(binwidth=1) + 
  labs(title="Distribution of p-value ratios \n (within correlations not containing outliers)", 
       x="log(p-value ratio)", 
       y="# of correlations")
ggsave(file.path(path,"graphs","TP_severity.pdf"), dpi=225, width=4, height=6)


# Vars Distribution with size circles
if (paired == TRUE){
  pdf(file.path(path,'graphs','Var1_Var2_Distribution.pdf'), width=10, height=4)
  par(mfrow=c(1,3))
  # just FP
  x=FP$r2vals
  oldy=FP$logpvals
  x = x[!is.infinite(oldy)]
  y = oldy[!is.infinite(oldy)]
  symbols(x, y, xlab = "R-sq", ylab = "log(p)",
          circles=sqrt(FP$avg_var1[!is.infinite(oldy)]/pi), fg = makeTransparent('red',30),inches=0.5)
  text(max(x),max(y),
       labels=paste("CUtIe's (red) \n # infinity = ", sum(is.infinite(oldy))),#, '\n', "non-CUtIe's (blue)"),
       offset = -5, pos=4, cex= 0.8)
  text(min(x),min(y),
       labels=paste("Var1 range = ", '\n',
                    '[', formatC(min(FP$avg_var1[!is.infinite(oldy)]), format = "e", digits = 2),', ',
                    formatC(max(FP$avg_var1[!is.infinite(oldy)]), format = "e", digits = 2), ']'),
       offset = -0.25, pos=4,cex = .8)
  
  # just TP
  x=TP$r2vals
  oldy=TP$logpvals
  x = x[!is.infinite(oldy)]
  y = oldy[!is.infinite(oldy)]
  symbols(x, y, xlab = "R-sq", ylab = "log(p)",
          circles=sqrt(TP$avg_var1[!is.infinite(oldy)]/pi), fg = makeTransparent('blue',30),inches=0.5)
  text(max(x),max(y),
       labels=paste("non-CUtIe's (blue)"),#, '\n', "non-CUtIe's (blue)"),
       offset = -5, pos=4, cex= 0.8)
  text(min(x),min(y),
       labels=paste("Var1 range = ", '\n',
                    '[', formatC(min(TP$avg_var1[!is.infinite(oldy)]), format = "e", digits = 2),', ',
                    formatC(max(TP$avg_var1[!is.infinite(oldy)]), format = "e", digits = 2), ']'),
       offset = -0.25, pos=4,cex = .8)
  
  # both TP FP overlayed
  x=P$r2vals
  oldy=P$logpvals
  x = x[!is.infinite(oldy)]
  y = oldy[!is.infinite(oldy)]
  symbols(x, y, xlab = "R-sq", ylab = "log(p)",
          circles=sqrt(P$avg_var1[!is.infinite(oldy)]/pi), fg = ifelse(P$indicators[!is.infinite(oldy)] == 1,makeTransparent('blue',30),makeTransparent('red',30)),inches=0.5)
  text(max(x),max(y),
       labels=paste("CUtIe's (red),", '\n', "non-CUtIe's (blue)"),
       offset = -5, pos=4, cex= 0.8)
  text(min(x),min(y),
       labels=paste("Var1 range = ", '\n',
                    '[', formatC(min(P$avg_var1[!is.infinite(oldy)]), format = "e", digits = 2),', ',
                    formatC(max(P$avg_var1[!is.infinite(oldy)]), format = "e", digits = 2), ']'),
       offset = -0.25, pos=4,cex = .8)
  dev.off()
} else
{
  # LUNG KSC
  #xlim = c(0,0.5)
  #ylim = c(-12,-2)
  # LUNG KPC
  xlim = c(0, 1)
  ylim = c(-50, -4)
  pdf(file.path(path,'graphs','Var1_Var2_Distribution.pdf'), width=10, height=8)
  par(mfrow=c(2,3))
  # Var1
  x=FP$r2vals
  y=FP$logpvals
  symbols(x, y, xlab = "R-sq", ylab = "log(p)", xlim = xlim, ylim = ylim,
          circles=sqrt(FP$avg_var1/pi), fg = makeTransparent('red',30),inches=0.5)
  text(max(xlim),max(ylim),
       labels=paste("CUtIe's (red)"),#, '\n', "non-CUtIe's (blue)"),
       offset = -5, pos=4, cex= 0.8)
  text(min(xlim),min(ylim),
       labels=paste("Var2 range = ", '\n',
                    '[', formatC(min(FP$avg_var1), format = "e", digits = 2),', ',
                    formatC(max(FP$avg_var1), format = "e", digits = 2), ']'),
       offset = -0.25, pos=4,cex = .8)
  
  # just TP
  x=TP$r2vals
  y=TP$logpvals
  symbols(x, y, xlab = "R-sq", ylab = "log(p)",xlim = xlim, ylim = ylim,
          circles=sqrt(TP$avg_var1/pi), fg = makeTransparent('blue',30),inches=0.5)
  text(max(xlim),max(ylim),
       labels=paste("non-CUtIe's (blue)"),#, '\n', "non-CUtIe's (blue)"),
       offset = -5, pos=4, cex= 0.8)
  text(min(xlim),min(ylim),
       labels=paste("Var2 range = ", '\n',
                    '[', formatC(min(TP$avg_var1), format = "e", digits = 2),', ',
                    formatC(max(TP$avg_var1), format = "e", digits = 2), ']'),
       offset = -0.25, pos=4,cex = .8)
  
  # both TP FP overlayed
  x=P$r2vals
  y=P$logpvals
  symbols(x, y, xlab = "R-sq", ylab = "log(p)",xlim = xlim, ylim = ylim,
          circles=sqrt(P$avg_var1/pi), fg = ifelse(P$indicators == 1,makeTransparent('blue',30),makeTransparent('red',30)),inches=0.5)
  text(max(xlim),max(ylim),
       labels=paste("CUtIe's (red),", '\n', "non-CUtIe's (blue)"),
       offset = -5, pos=4, cex= 0.8)
  text(min(xlim),min(ylim),
       labels=paste("Var2 range = ", '\n',
                    '[', formatC(min(P$avg_var1), format = "e", digits = 2),', ',
                    formatC(max(P$avg_var1), format = "e", digits = 2), ']'),
       offset = -0.25, pos=4,cex = .8)
  
  # Var2
  x=FP$r2vals
  y=FP$logpvals
  symbols(x, y, xlab = "R-sq", ylab = "log(p)",xlim = xlim, ylim = ylim,
          circles=sqrt(FP$avg_var2/pi), fg = makeTransparent('red',30),inches=0.5)
  text(max(xlim),max(ylim),
       labels=paste("CUtIe's (red)"),#, '\n', "non-CUtIe's (blue)"),
       offset = -5, pos=4, cex= 0.8)
  text(min(xlim),min(ylim),
       labels=paste("Var2 range = ", '\n',
                    '[', formatC(min(FP$avg_var2), format = "e", digits = 2),', ',
                    formatC(max(FP$avg_var2), format = "e", digits = 2), ']'),
       offset = -0.25, pos=4,cex = .8)
  
  # just TP
  x=TP$r2vals
  y=TP$logpvals
  symbols(x, y, xlab = "R-sq", ylab = "log(p)",xlim = xlim, ylim = ylim,
          circles=sqrt(TP$avg_var2/pi), fg = makeTransparent('blue'),inches=0.5)
  text(max(xlim),max(ylim),
       labels=paste("non-CUtIe's (blue)"),#, '\n', "non-CUtIe's (blue)"),
       offset = -5, pos=4, cex= 0.8)
  text(min(xlim),min(ylim),
       labels=paste("Var2 range = ", '\n',
                    '[', formatC(min(TP$avg_var2), format = "e", digits = 2),', ',
                    formatC(max(TP$avg_var2), format = "e", digits = 2), ']'),
       offset = -0.25, pos=4,cex = .8)
  
  # both TP FP overlayed
  x=P$r2vals
  y=P$logpvals
  symbols(x, y, xlab = "R-sq", ylab = "log(p)",xlim = xlim, ylim = ylim,
          circles=sqrt(P$avg_var2/pi), fg = ifelse(P$indicators == 1,makeTransparent('blue'),makeTransparent('red',30)),inches=0.5)
  text(max(xlim),max(ylim),
       labels=paste("CUtIe's (red),", '\n', "non-CUtIe's (blue)"),
       offset = -5, pos=4, cex= 0.8)
  text(min(xlim),min(ylim),
       labels=paste("Var2 range = ", '\n',
                    '[', formatC(min(P$avg_var2), format = "e", digits = 2),', ',
                    formatC(max(P$avg_var2), format = "e", digits = 2), ']'),
       offset = -0.25, pos=4,cex = .8)
  dev.off()
  
}






# ggplot
pdf(file.path(path,'graphs','MeanVarSkew_pratio.pdf'), width=4, height=3)
par(mfrow=c(3,2))
# LUNG PT KPC: xlim(0, 0.04) + ylim(0, 4.5e07) +
# LUNG PT KSC: xlim(0, 0.08) + ylim(0, 4.5e07) +
# LUNG MSQ KPC/KSC: xlim(0, 0.25) + ylim(0, 0.25) +
ggplot(TP, aes(x=avg_var1, y=avg_var2)) +
  geom_point(shape=1) + xlim(0, 0.04) + ylim(0, 4.5e07) +
  labs(title = 'E(var1), E(var2) for each correlation
      (not containing outliers)', xlab = 'E(var1)', ylab = 'E(var2)')
ggplot(FP, aes(x=avg_var1, y=avg_var2)) +
  geom_point(shape=1) + xlim(0, 0.04) + ylim(0, 4.5e07) +
  labs(title = 'E(var1), E(var2) for each correlation
       (containing outliers)', xlab = 'E(var1)', ylab = 'E(var2)')

# LUNG PT KPC: xlim(0, 0.005) + ylim(0, 8e14) +
# LUNG PT KSC: xlim(0,0.009) + ylim(0, 8e14) +
# LUNG MSQ KPC: xlim(0,0.04) + ylim(0,0.04) +
ggplot(TP, aes(x=var_var1, y=var_var2)) +
  geom_point(shape=1) + xlim(0, 0.005) + ylim(0, 8e14) +
  labs(title = 'Var(var1), Var(var2) for each correlation
       (not containing outliers)', xlab = 'Var(var1)', ylab = 'Var(var2)')
ggplot(FP, aes(x=var_var1, y=var_var2)) +
  geom_point(shape=1) + xlim(0, 0.005) + ylim(0, 8e14) +
  labs(title = 'Var(var1), Var(var2) for each correlation
       (containing outliers)', xlab = 'Var(var1)', ylab = 'Var(var2)')

# LUNG PT KPC/KSC: xlim(0, 5.5) + ylim(0, 5) +
# LUNG MSQ KPC: xlim(0, 13) + ylim(0, 13) +
ggplot(TP, aes(x=skew_var1, y=skew_var2)) +
  geom_point(shape=1) + xlim(0, 5.5) + ylim(0, 5) +
  labs(title = 'Skew(var1), Skew(var2) for each correlation
       (not containing outliers)', xlab = 'Skew(var1)', ylab = 'Skew(var2)')
ggplot(FP, aes(x=skew_var1, y=skew_var2)) +
  geom_point(shape=1) + xlim(0, 5.5) + ylim(0, 5) +
  labs(title = 'Skew(var1), Skew(var2) for each correlation
       (containing outliers)', xlab = 'Skew(var1)', ylab = 'Skew(var2)')


dev.off()

#ggsave(file.path(path,"graphs","MeanVarSkew3"), dpi=225, width=4, height=6)



SpearmanPFP <- FP
SpearmanPP <- P
SpearmanPTP <- TP
PearsonPFP <- FP
PearsonPP <- P
PearsonPTP <- TP
df.cat <- rbind(PearsonPP[,1:2], SpearmanPP[,1:2])
df.union <- unique(df.cat)
nrow(df.union)
df.cat <- rbind(PearsonPTP[,1:2], SpearmanPTP[,1:2])
df.union <- unique(df.cat)
nrow(df.union)
df.cat <- rbind(PearsonPFP[,1:2], SpearmanPFP[,1:2])
df.union <- unique(df.cat)
nrow(df.union)

c(nrow(SpearmanPFP), nrow(SpearmanPP), nrow(SpearmanPTP))
c(nrow(PearsonPFP), nrow(PearsonPP), nrow(PearsonPTP))








# TP + FP
pdf(file.path(path,'graphs','MeanVarSkew_pratio2.pdf'), width=9, height=4)
par(mfrow=c(1,3))
x=PP$avg_var1
y=PP$avg_var2
symbols(x, y, xlab = "Mean (var1)", ylab = "Mean (var2)", main = 'Size corresponds to P_ratio (after/before)',
        circles=1,#sqrt(PP$p_ratio/pi), 
        fg = ifelse(PP$indicators == 1,makeTransparent('blue',30),makeTransparent('red',30)),inches=0.5)
text(max(x),max(y),
     labels=paste("CUtIe's (red),", '\n', "non-CUtIe's (blue)"),
     offset = -5, pos=4, cex= 0.8)
text(min(x),min(y),
     labels=paste("Variance range = ", '\n',
                  '[', formatC(min(c(x,y)), format = "e", digits = 2),', ',
                  formatC(max(c(x,y)), format = "e", digits = 2), ']'),
     offset = -0.25, pos=4,cex = .8)
#abline(1,1)

# TP + FP: Var
x=log(PP$var_var1)
y=log(PP$var_var2)
symbols(x, y, xlab = "log Var (var1)", ylab = "log Var (var2)", main = 'Size corresponds to P_ratio (after/before)',
        circles=1,#sqrt(PP$p_ratio/pi), 
        fg = ifelse(PP$indicators == 1,makeTransparent('blue',30),makeTransparent('red',30)),inches=0.5)
text(max(x),max(y),
     labels=paste("CUtIe's (red),", '\n', "non-CUtIe's (blue)"),
     offset = -5, pos=4, cex= 0.8)
text(min(x),min(y),
     labels=paste("Variance range = ", '\n',
                  '[', formatC(min(c(x,y)), format = "e", digits = 2),', ',
                  formatC(max(c(x,y)), format = "e", digits = 2), ']'),
     offset = -0.25, pos=4,cex = .8)
#abline(1,1)

# TP + FP: Skew
x=PP$skew_var1
y=PP$skew_var2
symbols(x, y, xlab = "Skew (var1)", ylab = "Skew (var2)",main = 'Size corresponds to P_ratio (after/before)',
        circles=1,#sqrt(PP$p_ratio/pi), 
        fg = ifelse(PP$indicators == 1,makeTransparent('blue',30),makeTransparent('red',30)),inches=0.5)
text(max(x),max(y),
     labels=paste("CUtIe's (red),", '\n', "non-CUtIe's (blue)"),
     offset = -5, pos=4, cex= 0.8)
text(min(x),min(y),
     labels=paste("Skewness range = ", '\n',
                  '[', formatC(min(c(x,y)), format = "e", digits = 2),', ',
                  formatC(max(c(x,y)), format = "e", digits = 2), ']'),
     offset = -0.25, pos=4,cex = .8)
#abline(1,1)
dev.off()




# % NonCUtIe, % CutIe, mean, var, skewness
# 65/74451, 2681/74451, 
# Multiple plot function
#
# ggplot objects can be passed in ..., or to plotlist (as a list of ggplot objects)
# - cols:   Number of columns in layout
# - layout: A matrix specifying the layout. If present, 'cols' is ignored.
#
# If the layout is something like matrix(c(1,2,3,3), nrow=2, byrow=TRUE),
# then plot 1 will go in the upper left, 2 will go in the upper right, and
# 3 will go all the way across the bottom.
#
multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
  library(grid)
  
  # Make a list from the ... arguments and plotlist
  plots <- c(list(...), plotlist)
  
  numPlots = length(plots)
  
  # If layout is NULL, then use 'cols' to determine layout
  if (is.null(layout)) {
    # Make the panel
    # ncol: Number of columns of plots
    # nrow: Number of rows needed, calculated from # of cols
    layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                     ncol = cols, nrow = ceiling(numPlots/cols))
  }
  
  if (numPlots==1) {
    print(plots[[1]])
    
  } else {
    # Set up the page
    grid.newpage()
    pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
    
    # Make each plot, in the correct location
    for (i in 1:numPlots) {
      # Get the i,j matrix positions of the regions that contain this subplot
      matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
      
      print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                      layout.pos.col = matchidx$col))
    }
  }
}

###
# Graphing
###

# single pair plot
point1 = 19
point2 = 43
if (typex == 'otu') {
  x = as.numeric(datafx[point1 + offsetx,][-1])
} else {
  x = datafx[,point1 + offsetx]
}
if (typey == 'otu') {
  y = as.numeric(datafy[point2 + offsety,][-1])
} else {
  y = datafy[,point2 + offsety]
}
if (paired == FALSE) {
  R_matrix <- R_matrix_L6_resample_1
} else {
  R_matrix <- R_matrix_L6_resample_1P
}
row <- subset(R_matrix, R_matrix$var1 == point1 & R_matrix$var2 == point2)
plot(x,y, main=paste('p = ', formatC(row$pvalues, format = "e", digits = 2),  '\n',
                     'worst p = ', formatC(row$worst_p, format = "e", digits = 2), '\n',
                     'Rsq = ',formatC(row$r2vals, format = "e", digits = 2), '\n',
                     'worst Rsq = ', formatC((row$worst_r)**2, format = "e", digits = 2)))

