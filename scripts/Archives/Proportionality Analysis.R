###
# Proportionality Analysis: Set pwd, load libraries
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
# Lung MSQ
###

path = 'cutie_lungcancer_kprop1nomc0.05'

datafx <- read_delim("~/Desktop/Clemente Lab/CUtIe/data/pre_sparcc_MSQ/otu_table.MSQ34_L6.txt", 
                                        "\t", escape_double = FALSE, skip = 1)
typex = 'otu'
offsetx = 1
xlower = NA
xupper = NA

datafy <- read_delim("~/Desktop/Clemente Lab/CUtIe/data/pre_sparcc_MSQ/otu_table.MSQ34_L6.txt", 
                     "\t", escape_double = FALSE, skip = 1)
typey = 'otu'
offsety = 1
ylower = NA
yupper = NA

paired = TRUE



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

R_matrix_L6_resample_1 <- read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path,"data_processing/R_matrix_L6_resample_1.txt"), 
                                     "\t", escape_double = FALSE)

prop <- (read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path,"data_processing/prop.txt"), 
                    "\t", escape_double = FALSE))

samp_bact_mr <- (read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path,"data_processing/samp_bact_mr.txt"), 
                            "\t", escape_double = FALSE))

samp_bact_clr <- (read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path,"data_processing/samp_bact_clr.txt"), 
                             "\t", escape_double = FALSE))

samp_bact_lclr <- (read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path,"data_processing/samp_bact_lclr.txt"), 
                              "\t", escape_double = FALSE))

samp_bact_varlog <- (read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path,"data_processing/samp_bact_varlog.txt"), 
                                "\t", escape_double = FALSE))


bact_names = datafx[,1]

# each correlation is counted twice (x,y) and (y,x)
FP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators == -1,]
TP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators == 1,]
P = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators != 0,]

# each correlation counted once
PP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators != 0 & R_matrix_L6_resample_1$var1_index > R_matrix_L6_resample_1$var2_index,]
PFP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators == -1 & R_matrix_L6_resample_1$var1_index > R_matrix_L6_resample_1$var2_index,]
PTP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators == 1 & R_matrix_L6_resample_1$var1_index > R_matrix_L6_resample_1$var2_index,]

PPP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators != 0 & R_matrix_L6_resample_1$var1_index < R_matrix_L6_resample_1$var2_index,]
PFPP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators == -1 & R_matrix_L6_resample_1$var1_index < R_matrix_L6_resample_1$var2_index,]
PTPP = R_matrix_L6_resample_1[R_matrix_L6_resample_1$indicators == 1 & R_matrix_L6_resample_1$var1_index < R_matrix_L6_resample_1$var2_index,]

# ensure only replicates

FP_final <- PFPP[which( PFPP$var1_index %in% PFP$var2_index & PFPP$var2_index %in% PFP$var1_index ),]
# PTP[which( PTP$var1_index %in% PTPP$var2_index & PTP$var2_index %in% PTPP$var1_index ),]
TP_final <- PTPP[which( PTPP$var1_index %in% PTP$var2_index & PTPP$var2_index %in% PTP$var1_index ),]

if (paired == TRUE)
{
  R_matrix_L6_resample_1P <- subset(R_matrix_L6_resample_1, R_matrix_L6_resample_1$var1_index > R_matrix_L6_resample_1$var2_index)
  attach(R_matrix_L6_resample_1P)
} else
{
  R_matrix_L6_resample_1P <- R_matrix_L6_resample_1
  attach(R_matrix_L6_resample_1)
}

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

comment(FP) <- 'FP'
comment(TP) <- 'TP'
comment(FP_final) <- 'FP_final'
comment(TP_final) <- 'TP_final'

dfList <- list(FP,TP, FP_final, TP_final)

###
# All plots pointwise
###
graphbound = 100
dir.create(file.path(path, 'graphs'))

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
        y = as.numeric(datafy[point2 + offsetx,][-1])
      } else {
        y = datafy[,point2 + offsety]
      }
      R_matrix <- R_matrix_L6_resample_1
      #if (paired == FALSE) {
      #  R_matrix <- R_matrix_L6_resample_1
      #} else {
      #  R_matrix <- R_matrix_L6_resample_1P
      #}
  
      pdf(paste(file.path(path, 'graphs',paste(comment(dataf),'only',nrow(dataf)),paste(comment(dataf),'only')),point1,'_',point2,'.pdf'), width=12, height=6)
      x1 = samp_bact_mr[,point1+offsetx]
      y1 = samp_bact_mr[,point2+offsety]
      x2 = samp_bact_clr[,point1+offsetx]
      y2 = samp_bact_clr[,point2+offsety]
      x3 = samp_bact_lclr[,point1+offsetx]
      y3 = samp_bact_lclr[,point2+offsety]
      p = prop[point1+offsetx,point2+offsety]
      x.y = x2/y2
      
      current_row <- subset(R_matrix, R_matrix$var1 == point1 & R_matrix$var2 == point2)
      wp = current_row$worst_prop
      
      par(mfrow=c(1,3))
      
      plot(x1,y1,main=paste('Original data \n (with multiplicative replacement)'),
           xlab = paste('OTU ', point1 + offsetx),
           ylab = paste('OTU ', point2 + offsety),
           cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
      #abline(lm(y1~x1))
      
      fit = lm(y3 ~ x3)
      r2 = summary(fit)$r.squared
      p = summary(fit)$coefficients[,4][2]
      plot(x3,y3,main=paste('CLR log(MR / gm) \n adjustment for compositionality', '\n',
                            'p = ', formatC(p, format = 'e', digits = 2),  '\n',
                            'R-sq = ',formatC(r2, format = 'e', digits = 2), '\n'),
           xlab = paste('CLR log(MR/gm) OTU ', point1 + offsetx),
           ylab = paste('CLR log(MR/gm) OTU ', point2 + offsety),
           cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
      abline(lm(y3~x3))
      
      plot(x2,x.y,main=paste(paste('var(log(x/y)) = ', formatC(var(log(x.y)), format = "e", digits = 2)), '\n',
                             paste('var(log(x)) = ', formatC(var(log(x2)), format = "e", digits = 2)), '\n',
                             paste('prop = ', formatC(prop[point1 + offsetx, point2 + offsety], format = "e", digits = 2),'\n')),
           xlab = paste('MR/gm OTU ', point1 + offsetx),
           ylab = paste('ratio of MR/gm OTU ', point2 + offsety, ' and ' , point1 + offsetx),
           cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
      
      
     dev.off() 
    }
  }
})


# Example graphing

point1 = 472
point2 = 477
x1 = samp_bact_mr[,point1+offsetx]
y1 = samp_bact_mr[,point2+offsety]
x2 = samp_bact_clr[,point1+offsetx]
y2 = samp_bact_clr[,point2+offsety]
x3 = samp_bact_lclr[,point1+offsetx]
y3 = samp_bact_lclr[,point2+offsety]
p = prop[point1+offsetx,point2+offsety]
x.y = x2/y2

current_row <- subset(R_matrix, R_matrix$var1 == point1 & R_matrix$var2 == point2)
wp = current_row$worst_prop

par(mfrow=c(1,3))

plot(x1,y1,main=paste('Original data \n ( with multiplicative replacement)'),
     xlab = paste('OTU ', point1 + offsetx),
     ylab = paste('OTU ', point2 + offsety),
     cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
#abline(lm(y1~x1))

fit = lm(y3 ~ x3)
r2 = summary(fit)$r.squared
p = summary(fit)$coefficients[,4][2]
plot(x3,y3,main=paste('CLR log(MR / gm) \n adjustment for compositionality', '\n',
     'p = ', formatC(p, format = 'e', digits = 2),  '\n',
     'R-sq = ',formatC(r2, format = 'e', digits = 2), '\n'),
     xlab = paste('CLR log(MR/gm) OTU ', point1 + offsetx),
     ylab = paste('CLR log(MR/gm) OTU ', point2 + offsety),
     cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
#abline(lm(y3~x3))

plot(x2,x.y,main=paste(paste('var(log(x/y)) = ', formatC(var(log(x.y)), format = "e", digits = 2)), '\n',
                       paste('var(log(x)) = ', formatC(var(log(x2)), format = "e", digits = 2)), '\n',
                       paste('prop = ', formatC(p, format = "e", digits = 2),'\n')),
                       xlab = paste('MR/gm OTU ', point1 + offsetx),
                       ylab = paste('ratio of MR/gm OTU ', point2 + offsety, ' and ' , point1 + offsetx),
                       cex.main=0.85, cex.lab=1.5, cex.axis=1.25)






all_points_prop_resample_1 <- read_delim("~/Desktop/Clemente Lab/CUtIe/data_analysis/presparcc_MSQ34_cutiekprop0.50/data_processing/all_points_prop_resample_1.txt", 
                                        "\t", escape_double = FALSE)
all_points_prop_resample_1 <- all_points_prop_resample_1[,-ncol(all_points_prop_resample_1)]



