# Kevin Tse
# ECON 209H
# Econometrics Honors
# 4-12-2016

# Maximum Likelihood Estimation Using R

# Create a function nllh that takes as input par, 
# a vector of parameters (B_0,B_1,sigma), a matrix x and a y. 
# The function should return the value of the log likelihood 
# for regression with standard error terms:

nllh <- function(param, x, y) {
  B_0 = param[1]
  B_1 = param[2]
  sigma = param[3]
  n = length(y)
  sum = (-1/(2*sigma^2))*(sum((y - B_1*x - B_0)^2))
  return(-log(((1/(2*pi*sigma^2))^(n/2)*(exp(sum)))))
}

# Set Random Seed
set.seed(209)

# Draw 100 samples from N(3,1) to be X_i
X_i <- rnorm(100, 3, 1)

# Draw 100 samples from N(0,1) to U , sigma_u = 1
U <- rnorm(100, 0, 1)

# Generate X with a column of ones 
X <- cbind(rep(1,100), X_i)

# Compute Y
Y <- 2 + 3*X + U # Note that X instead of X_i is used here for optim to work

# par are initial values for parameters
# Store the result into o

o <- optim(par=c(2,3,1), fn = nllh, x = X, y= Y, method="BFGS",hessian=TRUE)
computed_params = o$par
h <- (o$hessian)^(-1)

se_b0 = h[1,1]
se_b1 = h[2,2]
se_sigma = h[3,3]
SE = c(sqrt(se_b0),sqrt(se_b1),sqrt(se_sigma))


table = data.frame(computed_params,SE)
rownames(table) <- c("B_0", "B_1", "Sigma")
  

# Part D

data = data.frame(X_i,Y[,2])
l = lm(formula = Y[,2] ~ X_i, data) 

# This return coefficients of B_1 = 3.055 and B_0 = 1.89, compared to
# B_0 = 2.0227 and B_1 = 3.01784 from the optimization. 
# The differences between the two sets of values are very small (0.04 and 0.13)
# it is fair to say that they are esstentially the same. But it is notable that 
# the differences is slightly larger than the standard error.

require(ggplot2)
qplot(X_i,Y[,2]) +
  geom_smooth(method='lm')  # Linear regression


