#un filled, linear scale
setwd('~/Desktop/Clemente Lab/imageproc/data_analysis/test3_graphs')
for (i in 1:50){
  n     <- 20                    # length of vector
  rho   <- (0.9 + i/1000)        # desired correlation = cos(angle)
  theta <- acos(rho)             # corresponding angle
  x1    <- rnorm(n, 1, 1)        # fixed given data
  x2    <- rnorm(n, 2, 0.5)      # new random data
  X     <- cbind(x1, x2)         # matrix
  Xctr  <- scale(X, center=TRUE, scale=FALSE)   # centered columns (mean 0)
  
  Id   <- diag(n)                               # identity matrix
  Q    <- qr.Q(qr(Xctr[ , 1, drop=FALSE]))      # QR-decomposition, just matrix Q
  P    <- tcrossprod(Q)          # = Q Q'       # projection onto space defined by x1
  x2o  <- (Id-P) %*% Xctr[ , 2]                 # x2ctr made orthogonal to x1ctr
  Xc2  <- cbind(Xctr[ , 1], x2o)                # bind to matrix
  Y    <- Xc2 %*% diag(1/sqrt(colSums(Xc2^2)))  # scale columns to length 1
  
  x <- Y[ , 2] + (1 / tan(theta)) * Y[ , 1]     # final new vector
  cor(x1, x)                                    # check correlation = rho
  jpeg(paste(rho,'.jpeg', sep = ''), 
       res = 300, units = 'in', width=3, height=4)
  plot(x1,x, xaxt = 'n', yaxt = 'n', xlim = c(-1.5,3), ylim=c(-2,2), xlab = '', ylab='')
  dev.off()
}

# linear scale, filled points
dir.create('~/Desktop/Clemente Lab/imageproc/data_analysis/test4_graphs')
setwd('~/Desktop/Clemente Lab/imageproc/data_analysis/test4_graphs')
for (i in 1:100){
  n     <- 20                    # length of vector
  rho   <- ((i-1)/100)                   # desired correlation = cos(angle)
  theta <- acos(rho)             # corresponding angle
  x1    <- rnorm(n, 1, 1)        # fixed given data
  x2    <- rnorm(n, 2, 0.5)      # new random data
  X     <- cbind(x1, x2)         # matrix
  Xctr  <- scale(X, center=TRUE, scale=FALSE)   # centered columns (mean 0)
  
  Id   <- diag(n)                               # identity matrix
  Q    <- qr.Q(qr(Xctr[ , 1, drop=FALSE]))      # QR-decomposition, just matrix Q
  P    <- tcrossprod(Q)          # = Q Q'       # projection onto space defined by x1
  x2o  <- (Id-P) %*% Xctr[ , 2]                 # x2ctr made orthogonal to x1ctr
  Xc2  <- cbind(Xctr[ , 1], x2o)                # bind to matrix
  Y    <- Xc2 %*% diag(1/sqrt(colSums(Xc2^2)))  # scale columns to length 1
  
  x <- Y[ , 2] + (1 / tan(theta)) * Y[ , 1]     # final new vector
  cor(x1, x)                                    # check correlation = rho
  jpeg(paste(rho,'.jpeg', sep = ''), 
       res = 300, units = 'in', width=3, height=4)
  plot(x1,x, xaxt = 'n', yaxt = 'n', pch = 16, xlim = c(-1.5,3), ylim=c(-2,2), xlab = '', ylab='')
  dev.off()
}




samples = 200
r = 0.83

library('MASS')
data = mvrnorm(n=samples, mu=c(0, 0), Sigma=matrix(c(1, r, r, 1), nrow=2), empirical=TRUE)
X = data[, 1]  # standard normal (mu=0, sd=1)
Y = data[, 2]  # standard normal (mu=0, sd=1)

cor(X, Y)  # yay!
cor(X*0.01 + 42, Y*3 - 1)  



mu <- rep(0,4)
Sigma <- matrix(.7, nrow=4, ncol=4) + diag(4)*.3

rawvars <- mvrnorm(n=50, mu=mu, Sigma=Sigma)

cov(rawvars); cor(rawvars)
# We can see our normal sample produces results very similar to our 
#specified covariance levels.

# No lets transform some variables
pvars <- pnorm(rawvars)
poisvars <- qpois(pvars, 5)
binomvars <- qpois(1-pvars, 3, .25) 
expvars <- qexp(pvars)
combvar <- data.frame(rawvars[,1], poisvars[,2], binomvars[,3], expvars[,4])

stdcombvar <- t(t(combvar)-apply(combvar,2,min))
stdcombvar <- t(t(stdcombvar)/apply(stdcombvar,2,max))
summary(stdcombvar)

plotter <- data.frame(
  values = c(stdcombvar),
  rawnorm = rep(rawvars[,1], 4),
  type = rep(c("rawvars", 
               "poisson", 
               "binomial", 
               "exponential"), 
             each=50))

library(ggplot2)  

ggplot(plotter, aes(y=rawnorm ,x=values, color=type)) +
  geom_point(shape=1) +     # Use hollow circles
  geom_smooth(method=lm,    # Add linear regression line
              se=FALSE)  


c(cor(rawvars[,1], poisvars[,2]), cor(rawvars[,1], binomvars[,3]), cor(rawvars[,1], expvars[,4]))

  
# linear scale, filled points
dir.create('~/Desktop/Clemente Lab/imageproc/data_analysis/test7_graphs')
setwd('~/Desktop/Clemente Lab/imageproc/data_analysis/test7_graphs')
method_ = 'spearman'

for (i in 1:100){
  # normal and logn
  n     <- 50                    # length of vector
  rho   <- (i-1)/100                   # desired correlation = cos(angle)
  theta <- acos(rho)             # corresponding angle
  x1    <- rnorm(n, 1, 1)        # fixed given data
  x2    <- rnorm(n, 2, 0.5)      # new random data
  X     <- cbind(x1, x2)         # matrix
  Xctr  <- scale(X, center=TRUE, scale=FALSE)   # centered columns (mean 0)
  
  Id   <- diag(n)                               # identity matrix
  Q    <- qr.Q(qr(Xctr[ , 1, drop=FALSE]))      # QR-decomposition, just matrix Q
  P    <- tcrossprod(Q)          # = Q Q'       # projection onto space defined by x1
  x2o  <- (Id-P) %*% Xctr[ , 2]                 # x2ctr made orthogonal to x1ctr
  Xc2  <- cbind(Xctr[ , 1], x2o)                # bind to matrix
  Y    <- Xc2 %*% diag(1/sqrt(colSums(Xc2^2)))  # scale columns to length 1
  
  x <- Y[ , 2] + (1 / tan(theta)) * Y[ , 1]     # final new vector
  # scor = cor(x1, x)                             # check correlation = rho
  
  pvars <- pnorm(x)
  # norm model
  y1 = x
  
  # logn model
  lognvars <- qlnorm(pvars, 0, 3)
  y3 = lognvars
  
  jpeg(paste('ln_',rho,'_',round(cor(x1,y3, method = method_),3),'.jpeg', sep = ''), 
       res = 300, units = 'in', width=3, height=4)
  plot(x1,y3, xaxt = 'n', yaxt = 'n', pch = 16, xlim = c(-2,2), ylim=c(0,2), xlab = '', ylab='')
  dev.off()
  
  
  jpeg(paste('norm_',rho,'_',round(cor(x1,y1, method = method_),3),'.jpeg', sep = ''), 
       res = 300, units = 'in', width=3, height=4)
  plot(x1,y1, xaxt = 'n', yaxt = 'n', pch = 16, xlim = c(-2,2), ylim=c(-1,1), xlab = '', ylab='')
  dev.off()
  
  # ZI
  n     <- 50                    # length of vector
  rho   <- (0.95 + i/2000)                   # desired correlation = cos(angle)
  theta <- acos(rho)             # corresponding angle
  x1    <- rnorm(n, 1, 1)        # fixed given data
  x2    <- rnorm(n, 2, 0.5)      # new random data
  X     <- cbind(x1, x2)         # matrix
  Xctr  <- scale(X, center=TRUE, scale=FALSE)   # centered columns (mean 0)
  
  Id   <- diag(n)                               # identity matrix
  Q    <- qr.Q(qr(Xctr[ , 1, drop=FALSE]))      # QR-decomposition, just matrix Q
  P    <- tcrossprod(Q)          # = Q Q'       # projection onto space defined by x1
  x2o  <- (Id-P) %*% Xctr[ , 2]                 # x2ctr made orthogonal to x1ctr
  Xc2  <- cbind(Xctr[ , 1], x2o)                # bind to matrix
  Y    <- Xc2 %*% diag(1/sqrt(colSums(Xc2^2)))  # scale columns to length 1
  
  x <- Y[ , 2] + (1 / tan(theta)) * Y[ , 1]     # final new vector
  
  pvars <- pnorm(x)
  
  # hurdle model
  p = rbinom(n,1,0.75)
  y2 = p * pvars
  
  jpeg(paste('zi_',rho,'_',round(cor(x1,y2, method = method_),3),'.jpeg', sep = ''), 
       res = 300, units = 'in', width=3, height=4)
  plot(y2,x1, xaxt = 'n', yaxt = 'n', pch = 16, xlim = c(0,.8), ylim=c(-2,2), xlab = '', ylab='')
  dev.off()
  
}




# linear scale, filled points
dir.create('~/Desktop/Clemente Lab/imageproc/data_analysis/norm_bins_graphs')
setwd('~/Desktop/Clemente Lab/imageproc/data_analysis/norm_bins_graphs')
method_ = 'spearman'

for (i in 1:3){
  # normal and logn
  n     <- 50                    # length of vector
  rho   <- (i-1)/1000                   # desired correlation = cos(angle)
  theta <- acos(rho)             # corresponding angle
  x1    <- rnorm(n, 1, 1)        # fixed given data
  x2    <- rnorm(n, 2, 0.5)      # new random data
  X     <- cbind(x1, x2)         # matrix
  Xctr  <- scale(X, center=TRUE, scale=FALSE)   # centered columns (mean 0)
  
  Id   <- diag(n)                               # identity matrix
  Q    <- qr.Q(qr(Xctr[ , 1, drop=FALSE]))      # QR-decomposition, just matrix Q
  P    <- tcrossprod(Q)          # = Q Q'       # projection onto space defined by x1
  x2o  <- (Id-P) %*% Xctr[ , 2]                 # x2ctr made orthogonal to x1ctr
  Xc2  <- cbind(Xctr[ , 1], x2o)                # bind to matrix
  Y    <- Xc2 %*% diag(1/sqrt(colSums(Xc2^2)))  # scale columns to length 1
  
  x <- Y[ , 2] + (1 / tan(theta)) * Y[ , 1]     # final new vector
  # scor = cor(x1, x)                             # check correlation = rho
  
  pvars <- pnorm(x)
  # norm model
  y1 = x
  
  jpeg(paste('small_norm_',rho,'_',round(cor(x1,y1, method = method_),3),'.jpeg', sep = ''), 
       res = 300, units = 'in', width=3, height=4)
  plot(x1,y1, xaxt = 'n', yaxt = 'n', pch = 16, xlim = c(-2,2), ylim=c(-1,1), xlab = '', ylab='')
  dev.off()
  
  n     <- 50                    # length of vector
  rho   <- (i-1)/1000 + 0.5                  # desired correlation = cos(angle)
  theta <- acos(rho)             # corresponding angle
  x1    <- rnorm(n, 1, 1)        # fixed given data
  x2    <- rnorm(n, 2, 0.5)      # new random data
  X     <- cbind(x1, x2)         # matrix
  Xctr  <- scale(X, center=TRUE, scale=FALSE)   # centered columns (mean 0)
  
  Id   <- diag(n)                               # identity matrix
  Q    <- qr.Q(qr(Xctr[ , 1, drop=FALSE]))      # QR-decomposition, just matrix Q
  P    <- tcrossprod(Q)          # = Q Q'       # projection onto space defined by x1
  x2o  <- (Id-P) %*% Xctr[ , 2]                 # x2ctr made orthogonal to x1ctr
  Xc2  <- cbind(Xctr[ , 1], x2o)                # bind to matrix
  Y    <- Xc2 %*% diag(1/sqrt(colSums(Xc2^2)))  # scale columns to length 1
  
  x <- Y[ , 2] + (1 / tan(theta)) * Y[ , 1]     # final new vector
  # scor = cor(x1, x)                             # check correlation = rho
  
  pvars <- pnorm(x)
  # norm model
  y1 = x
  
  jpeg(paste('med_norm_',rho,'_',round(cor(x1,y1, method = method_),3),'.jpeg', sep = ''), 
       res = 300, units = 'in', width=3, height=4)
  plot(x1,y1, xaxt = 'n', yaxt = 'n', pch = 16, xlim = c(-2,2), ylim=c(-1,1), xlab = '', ylab='')
  dev.off()
  
  n     <- 50                    # length of vector
  rho   <- (i-1)/1000 + 0.85                  # desired correlation = cos(angle)
  theta <- acos(rho)             # corresponding angle
  x1    <- rnorm(n, 1, 1)        # fixed given data
  x2    <- rnorm(n, 2, 0.5)      # new random data
  X     <- cbind(x1, x2)         # matrix
  Xctr  <- scale(X, center=TRUE, scale=FALSE)   # centered columns (mean 0)
  
  Id   <- diag(n)                               # identity matrix
  Q    <- qr.Q(qr(Xctr[ , 1, drop=FALSE]))      # QR-decomposition, just matrix Q
  P    <- tcrossprod(Q)          # = Q Q'       # projection onto space defined by x1
  x2o  <- (Id-P) %*% Xctr[ , 2]                 # x2ctr made orthogonal to x1ctr
  Xc2  <- cbind(Xctr[ , 1], x2o)                # bind to matrix
  Y    <- Xc2 %*% diag(1/sqrt(colSums(Xc2^2)))  # scale columns to length 1
  
  x <- Y[ , 2] + (1 / tan(theta)) * Y[ , 1]     # final new vector
  # scor = cor(x1, x)                             # check correlation = rho
  
  pvars <- pnorm(x)
  # norm model
  y1 = x
  
  jpeg(paste('large_norm_',rho,'_',round(cor(x1,y1, method = method_),3),'.jpeg', sep = ''), 
       res = 300, units = 'in', width=3, height=4)
  plot(x1,y1, xaxt = 'n', yaxt = 'n', pch = 16, xlim = c(-2,2), ylim=c(-1,1), xlab = '', ylab='')
  dev.off()
  
}

  