###
# CUtIe Analysis: Set pwd, load libraries
###
library(readr)
library(ggplot2)
library('reshape2')
setwd("/Users/KevinBu/Desktop/Clemente Lab/CUtIe/data_analysis")
library("optparse")

###
# Argument handling
###

option_list = list(
  make_option(c("--sx"), type="character", default=NULL, 
              help="Input samp var 1 file path", metavar="character"),
  make_option(c("--sy"), type="character", default=NULL,
              help="Input samp var 2 file path", metavar="character"),
  make_option(c("--typex"), type="character", default=NULL,
              help="Type of file 1", metavar="character"),
  make_option(c("--typey"), type="character", default=NULL,
              help="Type of file 2", metavar="character"),
  make_option(c("--namex"), type="character", default=NULL,
              help="name of file 1 var", metavar="character"),
  make_option(c("--namey"), type="character", default=NULL,
              help="name of file 2 var", metavar="character"),
  make_option(c("--offsetx"), default=NULL,type="integer",
              help="offset of data in file 1"),
  make_option(c("--offsety"), default=NULL,type="integer",
              help="offset of data in file 2"),
  make_option(c("--lowerx"), default=NULL,type="integer",
              help="lower bound colum number of data in file 1"),
  make_option(c("--lowery"), default=NULL,type="integer",
              help="lower bound colum number of data in file 2"),
  make_option(c("--upperx"), default=NULL,type="integer",
              help="upper bound colum number of data in file 1"),
  make_option(c("--uppery"), default=NULL,type="integer",
              help="upper bound colum number of data in file 2"),
  make_option(c("--path"), type="character", default=NULL,
              help="path of working dir", metavar="character"),
  make_option(c("--jsonpath"), type="character", default=NULL,
              help="path of json dir", metavar="character"),
  make_option(c("--corrpath"), type="character", default=NULL,
              help="path of truth corr if exists", metavar="character"),
  make_option(c("--skip"), default=NULL,type="integer",
              help="numbers of lines to skip in otu table", metavar="character"),
  make_option(c("--paired"), default=NULL, type='logical',
              help="boolean for paired variables"),
  make_option(c("--known"), default=NULL, type='logical',
              help="boolean if true correlations are known"),
  make_option(c("--sim"), default=NULL, type='logical',
              help="boolean if data is from simulations"),
  make_option(c("--kb"), default=FALSE,
              help="true if kb created data"),
  make_option(c("--reverse"), default=NULL, type='logical',
              help="boolean if reverse is true"),
  make_option(c("--pointwise"), default=FALSE, type='logical',
              help="true if pointwise is computed"),
  make_option(c("--logtx"), default=FALSE, type='logical',
              help="true if log transform data 1"),
  make_option(c("--logty"), default=FALSE, type='logical',
              help="true if log transform data 2"),
  make_option(c("--cutie"), type="character", default=NULL,
              help="type of statistic", metavar="character")
); 

opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser)

print(opt)

attach(opt)

###############
# SELECT DATA #
###############

###
# Lognormal, copula independent n = 50
###
datafx <- read_delim(sx, "\t", escape_double = FALSE, skip = skip)
rownames(datafx) <- datafx[,1]
datafx[,1] <- NULL

datafy <- read_delim(sy,"\t", escape_double = FALSE, skip = skip)
rownames(datafy) <- datafy[,1]
datafy[,1] <- NULL

###
# Analysis chunk POINTWISE
###

if (typex == 'otu') {
  xnames = datafx[,1]
} else if (typex == 'map') {
  xnames = colnames(datafx)[lowerx:upperx]
}

if (typey == 'otu') {
  ynames = datafy[,1]
} else if (typey == 'map') {
  ynames = colnames(datafy)[lowery:uppery]
}

dfsamp <- read_delim(paste(file.path(path,'data_processing','counter_samp_resample1.txt')),
                     "\t",escape_double=FALSE)
dfvar1 <- read_delim(paste(file.path(path,'data_processing','counter_var1_resample1.txt')),
                     "\t",escape_double=FALSE)
dfvar2 <- read_delim(paste(file.path(path,'data_processing','counter_var2_resample1.txt')),
                     "\t",escape_double=FALSE)

if (logtx == TRUE){
  xlog <- read_delim(paste(file.path(path,'data_processing','samp_var1_mr.txt')),
                     "\t",escape_double=FALSE,col_names = TRUE,skip=0)
  xlog <- xlog[-ncol(xlog)]
  
}
if (logty == TRUE){
  ylog <- read_delim(paste(file.path(path,'data_processing','samp_var2_mr.txt')),
                     "\t",escape_double=FALSE,col_names = TRUE,skip=0)
  ylog <- ylog[-ncol(ylog)]
}


if (paired == FALSE){
  colnames(datafy)[1] <- c("SampleID")
  target <- names(datafx)[-1]
  datafy = datafy[match(target, datafy$SampleID),]
}

#all_points_R_matrix_ <- read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path, "data_processing/all_points_R_matrix_.txt"),
#                                   "\t", escape_double = FALSE)



if (reverse == TRUE) {
  R_matrix_L6_resample_1 <- read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path, "data_processing/R_matrix_L6rev_resample_1.txt"),
                                       "\t", escape_double = FALSE)
} else {
  R_matrix_L6_resample_1 <- read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path, "data_processing/R_matrix_L6_resample_1.txt"),
                                       "\t", escape_double = FALSE)
}

if (cutie == 'cutie_1sc') {
  R_matrix_L6_resample_1$r2vals <- R_matrix_L6_resample_1$correlations ** 2
}

R_matrix_L6_resample_1 <- R_matrix_L6_resample_1[-ncol(R_matrix_L6_resample_1)]


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



###
# UpSetR
###


library("UpSetR")
#FP_json_matrix <- read_delim(paste(file.path(path,'data_processing','FP_json_matrix.txt')),
#                             ";", escape_double = FALSE)
FP_json_matrix <- read_delim(paste(file.path(jsonpath,'data_processing','FP_json_matrix_False.txt')),
                             ";", escape_double = FALSE)
FP_json_matrix <- FP_json_matrix[,-ncol(FP_json_matrix)]
FP_json_matrix$corr_row <- factor(FP_json_matrix$corr_row)
upset(FP_json_matrix, nsets = 4, empty.intersections = NULL)

# for graphing
json_matrix_graph <- read_delim(paste(file.path(jsonpath,'data_processing','FP_json_matrix_True.txt')),
                                ";", escape_double = FALSE)
json_matrix_graph <- json_matrix_graph[,-ncol(json_matrix_graph)]
set_names = names(json_matrix_graph)[-c(1,2)]


kpc_only <- subset(json_matrix_graph, kpc1 == 1 & jkpnone1 == 0 & bspnone1 == 0)
jkp_only <- subset(json_matrix_graph, kpc1 == 0 & jkpnone1 == 1 & bspnone1 == 0)
bsp_only <- subset(json_matrix_graph, kpc1 == 0 & jkpnone1 == 0 & bspnone1 == 1)

comment(kpc_only) <- 'kpc_only'
comment(jkp_only) <- 'jkp_only'
comment(bsp_only) <- 'bsp_only'

kpc_jkp <- subset(json_matrix_graph, kpc1 == 1 & jkpnone1 == 1 & bspnone1 == 0)
bsp_jkp <- subset(json_matrix_graph, kpc1 == 0 & jkpnone1 == 1 & bspnone1 == 1)
kpc_bsp <- subset(json_matrix_graph, kpc1 == 1 & jkpnone1 == 0 & bspnone1 == 1)

comment(kpc_jkp) <- 'kpc_jkp'
comment(bsp_jkp) <- 'bsp_jkp'
comment(kpc_bsp) <- 'kpc_bsp'

kpc_jkp_bsp <- subset(json_matrix_graph, kpc1 == 1 & jkpnone1 == 1 & bspnone1 == 1)
comment(kpc_jkp_bsp) <- 'kpc_jkp_bsp'

dfList <- list(kpc_only, jkp_only, bsp_only, kpc_jkp, bsp_jkp, kpc_bsp, kpc_jkp_bsp)


graphbound = 30
dir.create(file.path(jsonpath, 'graphs'),showWarnings = FALSE)


dfList <- lapply(dfList, function(dataf) {
  if (nrow(dataf) != 0) {
    dir.create(file.path(jsonpath, 'graphs',paste(comment(dataf),'only',nrow(dataf))),showWarnings = FALSE)
    
    truths = c()
    for (i in 1:nrow(dataf)) {
      point1 = dataf$var1[i]
      point2 = dataf$var2[i]
      R_matrix <- R_matrix_L6_resample_1
      current_row <- subset(R_matrix, R_matrix$var1 == point1 & R_matrix$var2 == point2)
      truths <- c(truths, current_row$truth)
    }
    if (known == TRUE){
      pdf(file.path(jsonpath, 'graphs',paste(comment(dataf),'only',nrow(dataf)),'distribution.pdf'), width=3, height=4)
      hist(truths, xlab = "correlation", 
           main = "True correlation coefficients", 
           xlim = c(-1,1), breaks = seq(-1,1, by=0.1), ylim = c(0, nrow(R_matrix_L6_resample_1)/10))
      dev.off()
    }
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
      if (logtx == TRUE){
        x = log(xlog[,point1 + offsetx])
      }
      if (logty == TRUE){
        y = log(ylog[,point2 + 1])
      }
      R_matrix <- R_matrix_L6_resample_1
      pdf(paste(file.path(jsonpath, 'graphs',paste(comment(dataf),'only',nrow(dataf)),paste(comment(dataf),'only')),point1,'_',point2,'.pdf'), width=3, height=4)
      current_row <- subset(R_matrix, R_matrix$var1 == point1 & R_matrix$var2 == point2)
      if (namex == 'otu') {
        xlab = paste('OTU ', point1)
      } else {
        xlab = xnames[point1 + 1]
      }
      if (namey == 'otu') {
        ylab = paste('OTU ', point2)
      } else {
        ylab = ynames[point2 + 1]
      }

      if (reverse == FALSE){
        plot(x,y,  main=paste('p = ', formatC(current_row$pvalues, format = "e", digits = 2),  '\n',
                              'worst p = ', formatC(current_row$worst_p, format = "e", digits = 2), '\n',
                              'Rsq = ',formatC(current_row$r2vals, format = "e", digits = 2), '\n',
                              'worst Rsq = ', formatC((current_row$worst_r)**2, format = "e", digits = 2)),
             xlab = xlab,
             ylab = ylab,
             cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
      } else
      {
        plot(x,y,  main=paste('p = ', formatC(current_row$pvalues, format = "e", digits = 2),  '\n',
                              'best p = ', formatC(current_row$best_p, format = "e", digits = 2), '\n',
                              'Rsq = ',formatC(current_row$r2vals, format = "e", digits = 2), '\n',
                              'best Rsq = ', formatC((current_row$best_r)**2, format = "e", digits = 2)),
             xlab = xlab,
             ylab = ylab,
             cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
      }

      dev.off()
    }
  }
})
# 
# 
# if (logtx == TRUE & logty == TRUE){
# 
#   # log section
#   kpc1_only <- subset(json_matrix_graph, kpc1 == 1 & kpclog1 == 0)
#   kpclog1_only <- subset(json_matrix_graph, kpc1 == 0 & kpclog1 == 1)
#   kpc1kpclog1_only <- subset(json_matrix_graph, kpc1 == 1 & kpclog1 == 1)
# 
# 
#   comment(kpc1_only) <- 'kpc1_only'
#   comment(kpclog1_only) <- 'kpclog1_only'
#   comment(kpc1kpclog1_only) <- 'kpc1kpclog1_only'
# 
# 
#   dfList <- list(kpc1_only, kpclog1_only, kpc1kpclog1_only)
# 
#   dir.create(file.path(path, 'loggraphs'), showWarnings = FALSE)
#   dfList <- lapply(dfList, function(dataf) {
#     if (nrow(dataf) != 0) {
#       dir.create(file.path(path, 'loggraphs',paste(comment(dataf),'only',nrow(dataf))), showWarnings = FALSE)
#       for (i in 1:min(graphbound,nrow(dataf)))
#       {
#         point1 = dataf$var1[i]
#         point2 = dataf$var2[i]
#         if (typex == 'otu') {
#           x = as.numeric(datafx[point1 + offsetx,][-1])
#         } else {
#           x = datafx[,point1 + offsetx]
#         }
#         if (typey == 'otu') {
#           y = as.numeric(datafy[point2 + offsety,][-1])
#         } else {
#           y = datafy[,point2 + offsety]
#         }
# 
#         R_matrix <- R_matrix_L6_resample_1
#         current_row <- subset(R_matrix, R_matrix$var1 == point1 & R_matrix$var2 == point2)
#         if (namex == 'otu') {
#           xlab = paste('OTU ', point1)
#         } else {
#           xlab = xnames[point1 + 1]
#         }
#         if (namey == 'otu') {
#           ylab = paste('OTU ', point2)
#         } else {
#           ylab = ynames[point2 + 1]
#         }
# 
#         pdf(paste(file.path(path, 'loggraphs',paste(comment(dataf),'only',nrow(dataf)),paste(comment(dataf),'only')),point1,'_',point2,'.pdf'), width=3, height=4)
# 
#         if (reverse == FALSE){
#           plot(x,y,  main=paste('p = ', formatC(current_row$pvalues, format = "e", digits = 2),  '\n',
#                                 'worst p = ', formatC(current_row$worst_p, format = "e", digits = 2), '\n',
#                                 'Rsq = ',formatC(current_row$r2vals, format = "e", digits = 2), '\n',
#                                 'worst Rsq = ', formatC((current_row$worst_r)**2, format = "e", digits = 2)),
#                xlab = xlab,
#                ylab = ylab,
#                cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
#         } else
#         {
#           plot(x,y,  main=paste('p = ', formatC(current_row$pvalues, format = "e", digits = 2),  '\n',
#                                 'best p = ', formatC(current_row$best_p, format = "e", digits = 2), '\n',
#                                 'Rsq = ',formatC(current_row$r2vals, format = "e", digits = 2), '\n',
#                                 'best Rsq = ', formatC((current_row$best_r)**2, format = "e", digits = 2)),
#                xlab = xlab,
#                ylab = ylab,
#                cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
#         }
#         dev.off()
# 
#         pdf(paste(file.path(path, 'loggraphs',paste(comment(dataf),'only',nrow(dataf)),paste(comment(dataf),'only')),point1,'_',point2,'log.pdf'), width=3, height=4)
# 
#         # do it again
#         x = log(xlog[,point1 + offsetx])
#         y = log(ylog[,point2 + 1])
# 
#         if (reverse == FALSE){
#           plot(x,y,  main=paste('p = ', formatC(current_row$pvalues, format = "e", digits = 2),  '\n',
#                                 'worst p = ', formatC(current_row$worst_p, format = "e", digits = 2), '\n',
#                                 'Rsq = ',formatC(current_row$r2vals, format = "e", digits = 2), '\n',
#                                 'worst Rsq = ', formatC((current_row$worst_r)**2, format = "e", digits = 2)),
#                xlab = xlab,
#                ylab = ylab,
#                cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
#         } else
#         {
#           plot(x,y,  main=paste('p = ', formatC(current_row$pvalues, format = "e", digits = 2),  '\n',
#                                 'best p = ', formatC(current_row$best_p, format = "e", digits = 2), '\n',
#                                 'Rsq = ',formatC(current_row$r2vals, format = "e", digits = 2), '\n',
#                                 'best Rsq = ', formatC((current_row$best_r)**2, format = "e", digits = 2)),
#                xlab = xlab,
#                ylab = ylab,
#                cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
#         }
#         dev.off()
#       }
#     }
#   })
# }
# 
# 

graphics.off()


  
  
