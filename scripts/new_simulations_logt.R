###
# Libraries
###

library(readr)
library(ggplot2)
library('reshape2')
library("optparse")
#library(e1071)
library('MASS')

option_list = list(
  make_option(c("--n_sampvec"), default=NULL,type="character",
              help="vector of n_samps to use"),
  make_option(c("--max_seed"), default=NULL,type="integer",
              help="max seed value (inclusive)"),
  make_option(c("--start"), default=NULL,type="double",
              help="start value for corrs"),
  make_option(c("--stop"), default=NULL,type="double",
              help="stop value for corrs (inclusive)"),
  make_option(c("--step"), default=NULL,type="double",
              help="step value for corrs"),
  make_option(c("--output"), type="character", default=NULL,
              help="outputdir", metavar="character")
  
); 
opt_parser = OptionParser(option_list=option_list);
opt = parse_args(opt_parser)

print(opt)

attach(opt)
for (n_samp in strsplit(n_sampvec,split=',')[[1]]){
  n_samp = as.integer(n_samp)
  for (nseed in seq(from=0, to=max_seed, by=1)){
    # FP/FN/P
    # 'nseed_class_corr_nsamp'
    
    for (cv in seq(from = start, to = stop, by = step)) { 
      set.seed(nseed)
      data = mvrnorm(n=(n_samp), mu=c(0, 0), Sigma=matrix(c(1, cv, cv, 1), nrow=2), empirical=TRUE)
      X = data[, 1]  # standard normal (mu=0, sd=1)
      Y = data[, 2]  # standard normal (mu=0, sd=1)
      S = seq(1:n_samp)
      X = X + 10
      Y = Y + 10
      X = log(X)
      Y = log(Y)
      mat = cbind(S,X,Y)
      #png(filename=paste("Desktop/clemente_lab/CUTIE/plots/P_", cv,'_', cor(X,Y),"_plot.png", sep=''))
      #pairs(cbind(X,Y))
      write.table(mat, file=paste(output, nseed,'_LNP_',n_samp,'_',cv,'.txt',sep=''), row.names=sprintf("s%s",seq(1:n_samp)), col.names=TRUE, sep='\t')
      #dev.off()
      #mat = cbind(S,log(X),log(Y))
      #png(filename=paste("Desktop/clemente_lab/CUTIE/plots/P_", cv,'_', cor(X,Y),"_plot.png", sep=''))
      #pairs(cbind(X,Y))
      #write.table(mat, file=paste(output, nseed,'_NP_',n_samp,'_',cv,'.txt',sep=''), row.names=sprintf("s%s",seq(1:n_samp)), col.names=TRUE, sep='\t')
      
    }
  
    
    # AQ FN case
    for (cv in seq(from = start, to = stop, by = step)) { 
      set.seed(nseed)
      data = mvrnorm(n=n_samp-1, mu=c(0, 0), Sigma=matrix(c(1, cv, cv, 1), nrow=2), empirical=TRUE)
      X = data[, 1]  # standard normal (mu=0, sd=1)
      Y = data[, 2]  # standard normal (mu=0, sd=1)
      X <- c(X, 3)
      Y <- c(Y, -3)
      X = X + 10
      Y = Y + 10
      X = log(X)
      Y = log(Y)
      S = seq(1:n_samp)
      mat = cbind(S,X,Y)
      write.table(mat, file=paste(output, nseed,'_LFN_',n_samp,'_',cv,'.txt',sep=''), row.names=sprintf("s%s",seq(1:n_samp)), col.names=TRUE, sep='\t')
      #png(filename=paste("Desktop/clemente_lab/CUTIE/plots/FN_", cv,'_', cor(X,Y),"_plot.png", sep=''))
      #pairs(cbind(X,Y))
      #dev.off()
    }
    
    
    # try with anscombe's q
    # https://stat.ethz.ch/pipermail/r-help/2007-April/128925.html
    for (cv in seq(from = start, to = stop, by = step)) { 
      set.seed(nseed)
      data = mvrnorm(n=n_samp-1, mu=c(0, 0), Sigma=matrix(c(1, 0, 0, 1), nrow=2), empirical=TRUE)
      X = data[, 1]  # standard normal (mu=0, sd=1)
      Y = data[, 2]  # standard normal (mu=0, sd=1)
      # empirically determine correlation within error
      eps = 0.01
      for (i in exp(seq(from=-4,to=10,by=0.01))){
        x1 <- c(X, i)
        x2 <- c(Y, 20)
        corr <- cor(x1,x2)
        if (abs(corr-cv) < eps) {
          break
        }
      }
      S = seq(1:n_samp)
      x1 = x1 + 10
      x2 = x2 + 10
      x1 = log(x1)
      x2 = log(x2)
      mat = cbind(S,x1,x2)
      write.table(mat, file=paste(output, nseed,'_LFP_',n_samp,'_',cv,'.txt',sep=''), row.names=sprintf("s%s",seq(1:n_samp)), col.names=TRUE, sep='\t')
    }
    
    # CD examples
    for (cv in seq(from = start, to = stop, by = step)) { 
      set.seed(nseed)
      data = mvrnorm(n=(n_samp-1), mu=c(0, 0), Sigma=matrix(c(1, cv, cv, 1), nrow=2), empirical=TRUE)
      X = data[, 1]  # standard normal (mu=0, sd=1)
      Y = data[, 2]  # standard normal (mu=0, sd=1)
      theta = atan(cv) + atan(1/2)
      X <- c(X,7*sin(theta))
      Y <- c(Y,7*cos(theta))
      S = seq(1:n_samp)
      X = X + 10
      Y = Y + 10
      X = log(X)
      Y = log(Y)
      mat = cbind(S,X,Y)
      # pairs(cbind(X,Y))
      write.table(mat, file=paste(output, nseed,'_LCD_',n_samp,'_',cv,'.txt',sep=''), row.names=sprintf("s%s",seq(1:n_samp)), col.names=TRUE, sep='\t')
      # dev.off()
      #model = lm(Y~X)
      #print(paste(cv, cooks.distance(model)[n_samp], unname(cor.test(X,Y, method='pearson')$estimate), cor.test(X,Y, method='pearson')$p.value))
    }
    
    
  }
}
