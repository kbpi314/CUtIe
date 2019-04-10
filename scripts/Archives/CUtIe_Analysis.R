###
# CUtIe Analysis: Set pwd, load libraries
###
library(readr)
library(ggplot2)
library('reshape2')
setwd("/Users/KevinBu/Desktop/Clemente Lab/CUtIe/data_analysis")
library("optparse")
library(e1071)

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
  make_option(c("--corrpath"), type="character", default=NULL,
              help="path of truth corr if exists", metavar="character"),
  make_option(c("--outlier"), type="character", default=NULL,
              help="path of outlier LOF if exists", metavar="character"),
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

datafx <- read_delim(sx, "\t", escape_double = FALSE, skip = skip)
rownames(datafx) <- datafx[,1]
datafx[,1] <- NULL

if (paired == TRUE){
  datafy <- read_delim(sy,"\t", escape_double = FALSE, skip = skip)
  rownames(datafy) <- datafy[,1]
  datafy[,1] <- NULL
  
} else{
  datafy <- read_delim(sy,"\t", escape_double = FALSE, skip = skip)
  rownames(datafy) <- datafy[,1]
  datafy[,1] <- NULL
}


###
# Analysis chunk POINTWISE
###

if (typex == 'otu') {
  #xnames = datafx[,1]
  xnames = rownames(datafx)
} else if (typex == 'map') {
  xnames = colnames(datafx)[lowerx:(upperx-1)]
  #datafx <- datafx[(lowerx+offsetx):((upperx-lowerx+1)+offsetx)]
  #datafx <- datafx[(lowerx+offsetx):((upperx-lowerx)+offsetx)]
  datafx <- datafx[(lowerx):(upperx-1)]
} # (357 - 3 + 1) + 1

if (typey == 'otu') {
  #ynames = datafy[,1]
  ynames = rownames(datafy)
} else if (typey == 'map') {
  ynames = colnames(datafy)[lowery:(uppery-1)]
  #datafy <- datafy[(lowery+offsety):((uppery-lowery+1)+offsety)]
#  datafy <- datafy[(lowery+offsety):((uppery-lowery)+offsety)]
  datafy <- datafy[(lowery):(uppery-1)]
  # 357 - (3 - 1 - 1) = 356
  # 357 - 3 - 1 = 
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
  if (typex == 'otu' && typey == 'map'){
    colnames(datafy)[1] <- c("SampleID")
    target <- names(datafx)[-1]
    datafy = datafy[match(target, datafy$SampleID),]
  }
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

# reverse corrs
if (reverse == FALSE) {
  FP_rev = R_matrix_L6_resample_1[R_matrix_L6_resample_1$FP_rev_indicators == 1,]
  TP_rev = R_matrix_L6_resample_1[R_matrix_L6_resample_1$TP_rev_indicators == 1,]
}
if (reverse == TRUE) {
  FP_rev = R_matrix_L6_resample_1[R_matrix_L6_resample_1$FN_rev_indicators == 1,]
  TP_rev = R_matrix_L6_resample_1[R_matrix_L6_resample_1$TN_rev_indicators == 1,]
}

###
# Non UpSetR venn diagrams
###

if (pointwise == FALSE) {
  if (reverse == FALSE)
  {
    comment(FP) <- 'FP'
    comment(TP) <- 'TP'
    comment(FP_rev) <- 'FP_rev'
    comment(TP_rev) <- 'TP_rev'
  } else
  {
    comment(FP) <- 'TN'
    comment(TP) <- 'FN'
    comment(FP_rev) <- 'FN_rev'
    comment(TP_rev) <- 'TN_rev'
  }
  dfList <- list(FP,TP, FP_rev, TP_rev)

}

###
# UpsetR
###

if (pointwise == TRUE){
  library("UpSetR")
  #FP_json_matrix <- read_delim(paste(file.path(path,'data_processing','FP_json_matrix.txt')),
  #                             ";", escape_double = FALSE)
  FP_json_matrix <- read_delim(paste(file.path(path,'data_processing','FP_json_matrix_False.txt')),
                               ";", escape_double = FALSE)
  FP_json_matrix <- FP_json_matrix[,-ncol(FP_json_matrix)]
  FP_json_matrix$corr_row <- factor(FP_json_matrix$corr_row)
  
  dir.create(file.path(path, 'graphs'),showWarnings = FALSE)
  
  pdf(file.path(path, 'graphs',paste('Upset.pdf')), width=3, height=4)
  upset(FP_json_matrix, nsets = 3, empty.intersections = NULL)
  dev.off()
  print("upset done")
  
  # for graphing
  json_matrix_graph <- read_delim(paste(file.path(path,'data_processing','FP_json_matrix_True.txt')),
                                  ";", escape_double = FALSE)
  json_matrix_graph <- json_matrix_graph[,-ncol(json_matrix_graph)]
  set_names = names(json_matrix_graph)[-c(1,2)]
  #cookd;dffits;cutie_1pc;
  
  kpc_only <- subset(json_matrix_graph, cutie_1pc == 1 & dffits == 0 & cookd == 0)
  dffits_only <- subset(json_matrix_graph, cutie_1pc == 0 & dffits == 1 & cookd == 0)
  cookd_only <- subset(json_matrix_graph, cutie_1pc == 0 & dffits == 0 & cookd == 1)
  
  comment(kpc_only) <- 'kpc_only'
  comment(dffits_only) <- 'dffits_only'
  comment(cookd_only) <- 'cookd_only'
  
  kpc_dff <- subset(json_matrix_graph, cutie_1pc == 1 & dffits == 1 & cookd == 0)
  dff_cd <- subset(json_matrix_graph, cutie_1pc == 0 & dffits == 1 & cookd == 1)
  kpc_cd <- subset(json_matrix_graph, cutie_1pc == 1 & dffits == 0 & cookd == 1)
  
  comment(kpc_dff) <- 'kpc_dff'
  comment(dff_cd) <- 'dff_cd'
  comment(kpc_cd) <- 'kpc_cd'
  
  kpc_dff_cd <- subset(json_matrix_graph, cutie_1pc == 1 & dffits == 1 & cookd == 1)
  comment(kpc_dff_cd) <- 'kpc_dff_cd'
  
  dfList <- list(kpc_only, dffits_only, cookd_only, kpc_dff, dff_cd, kpc_cd, kpc_dff_cd)
  
  
  graphbound = 30
  #dir.create(file.path(path, 'graphs'),showWarnings = FALSE)
  
  print('created graphs folder')
  dfList <- lapply(dfList, function(dataf) {
    if (nrow(dataf) != 0) {
      dir.create(file.path(path, 'graphs',paste(comment(dataf),'only',nrow(dataf))),showWarnings = FALSE)
      print('loading in R matrix')
      truths = c()
      for (i in 1:nrow(dataf)) {
        point1 = dataf$var1[i]
        point2 = dataf$var2[i]
        R_matrix <- R_matrix_L6_resample_1
        current_row <- subset(R_matrix, R_matrix$var1 == point1 & R_matrix$var2 == point2)
        truths <- c(truths, current_row$truth)
      }
      print('creating correlation coeff dist')
      if (known == TRUE){
        pdf(file.path(path, 'graphs',paste(comment(dataf),'only',nrow(dataf)),'distribution.pdf'), width=3, height=4)
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
        pdf(paste(file.path(path, 'graphs',paste(comment(dataf),'only',nrow(dataf)),paste(comment(dataf),'only')),point1,'_',point2,'.pdf'), width=3, height=4)
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
        non_na = complete.cases(x,y)
        x = x[complete.cases(x,y)]
        y = y[complete.cases(x,y)] 
        
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
}

###
# TRUTHS
###



if (known == TRUE & pointwise == FALSE){
  if (nrow(FP) > 0){
    pdf(paste(file.path(path, 'graphs'),'FP_truths.pdf'), width=3, height=4)
    hist(FP$truth, xlab = "correlation", 
         main = "True correlation coefficients \n among FP correlations", 
         #xlim = c(-.2,.2), breaks = seq(-.2,.2, by=0.02), ylim = c(0, nrow(R_matrix_L6_resample_1)/10))
         xlim = c(-1,1), breaks = seq(-1,1, by=0.1), ylim = c(0, nrow(R_matrix_L6_resample_1)/10))
    dev.off()
  }
  if (nrow(TP) > 0) {
    pdf(paste(file.path(path, 'graphs'),'TP_truths.pdf'), width=3, height=4)
    hist(TP$truth, xlab = "correlation", 
         main = "True correlation coefficients \n among TP correlations", 
         #xlim = c(-.2,.2), breaks = seq(-.2,.2, by=0.02), ylim = c(0, nrow(R_matrix_L6_resample_1)/10))
         xlim = c(-1,1), breaks = seq(-1,1, by=0.1), ylim = c(0, nrow(R_matrix_L6_resample_1)/10))
    dev.off()
  }
  if (nrow(P) > 0) {
    pdf(paste(file.path(path, 'graphs'),'P_truths.pdf'), width=3, height=4)
    hist(P$truth, xlab = "correlation", 
         main = "True correlation coefficients \n among P correlations", 
       #  xlim = c(-.2,.2), breaks = seq(-.2,.2, by=0.02), ylim = c(0, nrow(R_matrix_L6_resample_1)/10))
         xlim = c(-1,1), breaks = seq(-1,1, by=0.1), ylim = c(0, nrow(R_matrix_L6_resample_1)/10))
    dev.off()
  }
  pdf(paste(file.path(path, 'graphs'),'truths.pdf'), width=3, height=4)
  hist(R_matrix_L6_resample_1$truth, xlab = "correlation", 
       main = "True correlation coefficients \n among all correlations", 
      # xlim = c(-.2,.2), breaks = seq(-.2,.2, by=0.02), ylim = c(0, nrow(R_matrix_L6_resample_1)/10))
      xlim = c(-1,1), breaks = seq(-1,1, by=0.1), ylim = c(0, nrow(R_matrix_L6_resample_1)/10))
  dev.off()
}


###
# All plots pointwise
###
if (pointwise == FALSE) {
  graphbound = 30
  dir.create(file.path(path, 'graphs'),showWarnings = FALSE)
  
  if (paired == TRUE){
    set.seed(1)
    
    outlier_df <- read_delim(file.path("~/Desktop/Clemente Lab/CUtIe/data_analysis",path, "data_processing/LOF_outliers.txt"),
                             "\t", escape_double = FALSE)
    
    outliers = as.numeric(outlier_df$outlier)
    
    pdf(file.path(path,'graphs','diagnostic_plots.pdf'), width=10, height=4)
    par(mfrow=c(1,3))
    dfsamp$outliers = outliers
    plot(dfsamp$index, dfsamp$count, col = ifelse(outliers < 0,'red','black'))
    plot(dfvar1$index, dfvar1$count)
    plot(dfvar2$index, dfvar2$count)
    dev.off()
  } else
  {
    pdf(file.path(path,'graphs','diagnostic_plots.pdf'), width=10, height=4)
    par(mfrow=c(1,3))
    plot(dfsamp$index, dfsamp$count)
    plot(dfvar1$index, dfvar1$count)
    plot(dfvar2$index, dfvar2$count)
    dev.off()
  }
  
  pdf(file.path(path,'graphs','skew_plot.pdf'), width = 3, height = 4)

  skew <- vector("numeric", nrow(datafx))  # first pre allocate to hold the result
  for (i in 1:nrow(datafx)){
    if (typex == 'otu') {
      x = as.numeric(datafx[i + offsetx,][-1])
    } else {
      x = datafx[,i + offsetx]
    }
    skew[i] <- skewness(as.numeric(x), na.rm=TRUE) 
  }
  hist(skew)
  dev.off()
  
  #if (logtx == FALSE & logty == FALSE) {
  
  dfList <- lapply(dfList, function(dataf) {
    if (nrow(dataf) != 0) {
      dir.create(file.path(path, 'graphs',paste(comment(dataf),'only',nrow(dataf))),showWarnings = FALSE)
      for (i in sample(nrow(dataf),min(graphbound,nrow(dataf))))
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
        pdf(paste(file.path(path, 'graphs',paste(comment(dataf),'only',nrow(dataf)),paste(comment(dataf),'only')),point1,'_',point2,'.pdf'), width=3, height=4)
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
        # print TESTING        
        #non_na = complete.cases(x,y)
        #x = x[non_na]
        #y = y[non_na]
        print('testing')
        print(point1)
        print(point2)

        if (sim == FALSE){
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
        } else {
          if (reverse == FALSE){
            plot(x,y,  main=paste('p = ', formatC(current_row$pvalues, format = "e", digits = 2),  '\n',
                                  'worst p = ', formatC(current_row$worst_p, format = "e", digits = 2), '\n',
                                  'Rsq = ',formatC(current_row$r2vals, format = "e", digits = 2), '\n',
                                  'worst Rsq = ', formatC((current_row$worst_r)**2, format = "e", digits = 2), '\n',
                                  'true corr = ', formatC((current_row$truth), format = "e", digits = 2)),
                 xlab = xlab,
                 ylab = ylab,
                 cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
          } else
          {
            plot(x,y,  main=paste('p = ', formatC(current_row$pvalues, format = "e", digits = 2),  '\n',
                                  'best p = ', formatC(current_row$best_p, format = "e", digits = 2), '\n',
                                  'Rsq = ',formatC(current_row$r2vals, format = "e", digits = 2), '\n',
                                  'best Rsq = ', formatC((current_row$best_r)**2, format = "e", digits = 2), '\n',
                                  'true corr = ', formatC((current_row$truth), format = "e", digits = 2)),
                 xlab = xlab,
                 ylab = ylab,
                 cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
          }
          
        }
        dev.off()
      }
      
      # p_value_dist histograms
      pdf(file.path(path,'graphs',paste(comment(dataf),'p_value_dist.pdf')), width=6, height=4)
      par(mfrow=c(1,2))
      all_pvalues = dataf$pvalues
      infinites = all_pvalues[!is.finite(all_pvalues)]
      all_pvalues = all_pvalues[is.finite(all_pvalues)] 
      log_pvalues = log(all_pvalues)
      
      hist(all_pvalues,
           main = paste('mu_p = ', formatC(mean(all_pvalues, na.rm = TRUE), format = "e", digits = 2),  '\n',
                        'max_p = ', formatC(max(all_pvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                        'min_p = ', formatC(min(all_pvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                        'sigma_p = ', formatC(sqrt(var(all_pvalues, na.rm = TRUE)), format = "e", digits = 2), '\n',
                        'number of infinite = ', sum( !is.infinite( infinites ) ) ),
           xlab = 'pvalues',
           ylab = 'frequency',cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
      hist(log_pvalues,
           main = paste('mu_p = ', formatC(mean(log_pvalues, na.rm = TRUE), format = "e", digits = 2),  '\n',
                        'max_p = ', formatC(max(log_pvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                        'min_p = ', formatC(min(log_pvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                        'sigma_p = ', formatC(sqrt(var(log_pvalues, na.rm = TRUE)), format = "e", digits = 2), '\n',
                        'number of infinite = ', sum( !is.infinite( infinites ) ) ),
           xlab = 'log(pvalues)',
           ylab = 'frequency',cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
      dev.off()
      
      
      # put in fold change here
      pdf(file.path(path,'graphs',paste(comment(dataf),'fold_p_value_dist.pdf')), width=6, height=4)
      par(mfrow=c(1,2))
      all_foldpvalues = dataf$p_ratio
      
      infinites = all_foldpvalues[!is.finite(all_foldpvalues)]
      all_foldpvalues = all_foldpvalues[is.finite(all_foldpvalues)] 
      log_foldpvalues = log(all_foldpvalues)
      
      hist(all_foldpvalues,
           main = paste('mu_p = ', formatC(mean(all_foldpvalues, na.rm = TRUE), format = "e", digits = 2),  '\n',
                        'max_p = ', formatC(max(all_foldpvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                        'min_p = ', formatC(min(all_foldpvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                        'sigma_p = ', formatC(sqrt(var(all_foldpvalues, na.rm = TRUE)), format = "e", digits = 2), '\n',
                        'number of inf = ', sum( !is.infinite( infinites ) ) ),
           xlab = 'foldpvalues',
           ylab = 'frequency',cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
      hist(log_foldpvalues,
           main = paste('mu_p = ', formatC(mean(log_foldpvalues, na.rm = TRUE), format = "e", digits = 2),  '\n',
                        'max_p = ', formatC(max(log_foldpvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                        'min_p = ', formatC(min(log_foldpvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                        'sigma_p = ', formatC(sqrt(var(log_foldpvalues, na.rm = TRUE)), format = "e", digits = 2), '\n',
                        'number of infinite = ', sum( !is.infinite( infinites ) ) ),
           xlab = 'log(foldpvalues)',
           ylab = 'frequency',cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
      dev.off()
      
    }
  })
  #}
  
  # p_value_dist histograms
  pdf(file.path(path,'graphs','p_value_dist.pdf'), width=6, height=4)
  par(mfrow=c(1,2))
  all_pvalues = R_matrix_L6_resample_1P$pvalues
  log_pvalues = log(all_pvalues)
  
  hist(all_pvalues,
       main = paste('mu_p = ', formatC(mean(all_pvalues, na.rm = TRUE), format = "e", digits = 2),  '\n',
                    'max_p = ', formatC(max(all_pvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                    'min_p = ', formatC(min(all_pvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                    'sigma_p = ', formatC(sqrt(var(all_pvalues, na.rm = TRUE)), format = "e", digits = 2), '\n'),
       xlab = 'pvalues',
       ylab = 'frequency',cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
  hist(log_pvalues,
       main = paste('mu_p = ', formatC(mean(log_pvalues, na.rm = TRUE), format = "e", digits = 2),  '\n',
                    'max_p = ', formatC(max(log_pvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                    'min_p = ', formatC(min(log_pvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                    'sigma_p = ', formatC(sqrt(var(log_pvalues, na.rm = TRUE)), format = "e", digits = 2), '\n'),
       xlab = 'log(pvalues)',
       ylab = 'frequency',cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
  dev.off()
  
  
  # put in fold change here
  pdf(file.path(path,'graphs','fold_p_value_dist.pdf'), width=6, height=4)
  par(mfrow=c(1,2))
  all_foldpvalues = R_matrix_L6_resample_1P$p_ratio
  log_foldpvalues = log(all_foldpvalues)
  
  hist(all_foldpvalues,
       main = paste('mu_p = ', formatC(mean(all_foldpvalues, na.rm = TRUE), format = "e", digits = 2),  '\n',
                    'max_p = ', formatC(max(all_foldpvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                    'min_p = ', formatC(min(all_foldpvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                    'sigma_p = ', formatC(sqrt(var(all_foldpvalues, na.rm = TRUE)), format = "e", digits = 2), '\n'),
       xlab = 'foldpvalues',
       ylab = 'frequency',cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
  hist(log_foldpvalues,
       main = paste('mu_p = ', formatC(mean(log_foldpvalues, na.rm = TRUE), format = "e", digits = 2),  '\n',
                    'max_p = ', formatC(max(log_foldpvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                    'min_p = ', formatC(min(log_foldpvalues, na.rm = TRUE), format = "e", digits = 2), '\n',
                    'sigma_p = ', formatC(sqrt(var(log_foldpvalues, na.rm = TRUE)), format = "e", digits = 2), '\n'),
       xlab = 'log(foldpvalues)',
       ylab = 'frequency',cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
  dev.off()
  
  if (cutie != 'cutie_1sc'){
    pdf(file.path(path,'graphs','r2_value_dist.pdf'), width=10, height=4)
    par(mfrow=c(1,2))
    all_r2values = R_matrix_L6_resample_1P$r2vals
    hist(all_r2values,
         main = paste('mu_r2 = ', formatC(mean(all_r2values, na.rm = TRUE), format = "e", digits = 2),  '\n',
                      'max_r2 = ', formatC(max(all_r2values, na.rm = TRUE), format = "e", digits = 2), '\n',
                      'min_r2 = ', formatC(min(all_r2values, na.rm = TRUE), format = "e", digits = 2), '\n',
                      'sigma_r2 = ', formatC(sqrt(var(all_r2values, na.rm = TRUE)), format = "e", digits = 2), '\n'),
         xlab = 'r2values',
         ylab = 'frequency',cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
    
    log_r2values = log(all_r2values)
    hist(log_r2values,
         main = paste('mu_r2 = ', formatC(mean(log_r2values, na.rm = TRUE), format = "e", digits = 2),  '\n',
                      'max_r2 = ', formatC(max(log_r2values, na.rm = TRUE), format = "e", digits = 2), '\n',
                      'min_r2 = ', formatC(min(log_r2values, na.rm = TRUE), format = "e", digits = 2), '\n',
                      'sigma_r2 = ', formatC(sqrt(var(log_r2values, na.rm = TRUE)), format = "e", digits = 2), '\n'),
         xlab = 'log(r2values)',
         ylab = 'frequency',cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
    dev.off()
  }
  
  
  graphics.off()
  
  # ############
  # # Graphing #
  # ############
  # 
  # 
  # # single pair plot
  # point1 = 0 #19#292 #19
  # point2 = 499 #11 #70# 11
  # if (typex == 'otu') {
  #   x = as.numeric(datafx[point1 + offsetx,][-1])
  # } else {
  #   x = datafx[,point1 + offsetx]
  # }
  # if (typey == 'otu') {
  #   y = as.numeric(datafy[point2 + offsetx,][-1])
  # } else {
  #   y = datafy[,point2 + offsety]
  # }
  # 
  # R_matrix <- R_matrix_L6_resample_1
  # current_row <- subset(R_matrix, R_matrix$var1 == point1 & R_matrix$var2 == point2)
  # if (namex == 'otu') {
  #   xlab = paste('OTU ', point1)
  # } else {
  #   xlab = xnames[point1 + 1]
  # }
  # if (namey == 'otu') {
  #   ylab = paste('OTU ', point2)
  # } else {
  #   ylab = ynames[point2 + 1]
  # }
  # if (logtx == TRUE){
  #   x = xlog[,point1 + offsetx]
  # }
  # if (logty == TRUE){
  #   y = ylog[,point2 + offsety]
  # }
  # #pdf('test.pdf',width = 3, height = 4)
  # if (reverse == FALSE){
  #   plot(x,y,  main=paste('p = ', formatC(current_row$pvalues, format = "e", digits = 2),  '\n',
  #                         'worst p = ', formatC(current_row$worst_p, format = "e", digits = 2), '\n',
  #                         'Rsq = ',formatC(current_row$r2vals, format = "e", digits = 2), '\n',
  #                         'worst Rsq = ', formatC((current_row$worst_r)**2, format = "e", digits = 2)),
  #        xlab = xlab,
  #        ylab = ylab,
  #        cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
  # } else {
  #   plot(x,y,  main=paste('p = ', formatC(current_row$pvalues, format = "e", digits = 2),  '\n',
  #                         'best p = ', formatC(current_row$best_p, format = "e", digits = 2), '\n',
  #                         'Rsq = ',formatC(current_row$r2vals, format = "e", digits = 2), '\n',
  #                         'best Rsq = ', formatC((current_row$best_r)**2, format = "e", digits = 2)),
  #        xlab = xlab,
  #        ylab = ylab,
  #        cex.main=0.85, cex.lab=1.5, cex.axis=1.25)
  # }
  # abline(lm(y ~ x))  
}



