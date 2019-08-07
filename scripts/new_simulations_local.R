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
  make_option(c("--n_samp"), default=NULL,type="integer",
              help="number of samples"),
  make_option(c("--max_seed"), default=NULL,type="integer",
              help="max seed value (inclusive)"),
  make_option(c("--start"), default=NULL,type="float",
              help="start value for corrs"),
  make_option(c("--stop"), default=NULL,type="float",
              help="stop value for corrs (inclusive)"),
  make_option(c("--step"), default=NULL,type="float",
              help="step value for corrs"),
  make_option(c("--output"), type="character", default=NULL,
              help="outputdir", metavar="character")
  
); 
#n_samp = 50
#max_seed = 19

for (nseed in seq(from=0, to=max_seed, by=1)){
  # FP/FN/P
  # 'nseed_class_corr_nsamp'
  
  for (cv in seq(from = start, to = stop, by = step)) { 
    set.seed(nseed)
    data = mvrnorm(n=(n_samp), mu=c(0, 0), Sigma=matrix(c(1, cv, cv, 1), nrow=2), empirical=TRUE)
    X = data[, 1]  # standard normal (mu=0, sd=1)
    Y = data[, 2]  # standard normal (mu=0, sd=1)
    S = seq(1:n_samp)
    mat = cbind(S,X,Y)
    #png(filename=paste("Desktop/clemente_lab/CUTIE/plots/P_", cv,'_', cor(X,Y),"_plot.png", sep=''))
    #pairs(cbind(X,Y))
    write.table(mat, file=paste(output, nseed,'_NP_',n_samp,'_',cv,'.txt',sep=''), row.names=sprintf("s%s",seq(1:n_samp)), col.names=TRUE, sep='\t')
    #dev.off()
  }
  
  
  
  # AQ FN case
  for (cv in seq(from = start, to = stop, by = step)) { 
    set.seed(nseed)
    data = mvrnorm(n=n_samp-1, mu=c(0, 0), Sigma=matrix(c(1, cv, cv, 1), nrow=2), empirical=TRUE)
    X = data[, 1]  # standard normal (mu=0, sd=1)
    Y = data[, 2]  # standard normal (mu=0, sd=1)
    X <- c(X, 3)
    Y <- c(Y, -3)
    S = seq(1:n_samp)
    mat = cbind(S,X,Y)
    write.table(mat, file=paste(output, nseed,'_FN_',n_samp,'_',cv,'.txt',sep=''), row.names=sprintf("s%s",seq(1:n_samp)), col.names=TRUE, sep='\t')
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
    x1 <- c(X, 20)
    x2 <- c(Y, 20)
    
    # put all into 1 matrix for simplicity
    x12 <- cbind(scale(x1),x2)
    
    # find the current correlation matrix
    c1 <- var(x12)
    
    # cholesky decomposition to get independence
    chol1 <- solve(chol(c1))
    
    newx <-  x12 %*% chol1 
    
    # check that we have independence and x1 unchanged
    zapsmall(cor(newx))
    all.equal( x12[,1], newx[,1] )
    
    # create new correlation structure (zeros can be replaced with other rvals)
    newc <- matrix( 
      c(1  , cv,
        cv, 1  ), ncol=2 )
    
    # check that it is positive definite
    eigen(newc)
    
    chol2 <- chol(newc)
    
    finalx <- newx %*% chol2 * sd(x1) + mean(x1)
    
    # verify success
    apply(finalx, 2, sd)
    
    zapsmall(cor(finalx))
    
    #png(filename=paste("Desktop/clemente_lab/CUTIE/plots/FP_", cv,"_plot.png", sep=''))
    #pairs(finalx)
    #dev.off()
    # 'nseed_class_corr_nsamp_nvar'
    S = seq(1:n_samp)
    finalx = cbind(S,finalx)
    write.table(finalx, file=paste(output, nseed,'_FP_',n_samp,'_',cv,'.txt',sep=''), row.names=sprintf("s%s",seq(1:n_samp)), col.names=c('S','X','Y'), sep='\t')

  }
}
