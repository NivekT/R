# Kevin Tse
# ECON 209H
# Econometrics Honors
# 4-5-2016

# Ordinary Least Square
# Contrast between simulation and theortical calculation

set.seed(29)

# 10.a
u = 0.2
sim <- runif(10, min = u - 0.5, max = u + 0.5)
mean <- sum(sim)/10 # 0.04950683

# 10.b
means = 1:500
u = 0
for (i in 1:500) {
  sim <- runif(10, min = u - 0.5, max = u + 0.5)
  mean <- sum(sim)/10
  means[i] = mean
}
hist(means)

ninefive <- quantile(means, .95) # 0.1460874
# u = 0.2 is below the 95th percentile

 
zeropercentile <- ecdf(means)(mean(means)) # 0.492
# This means we can reject the null hypothesis at alpha = 0.492
# significance level.

# 10.c
u2 = 0.2
mean2 = 0
means2 = 1:500
for (i in 1:500) {
  sim2 <- runif(10, min = u2 - 0.5, max = u2 + 0.5)
  mean2 <- sum(sim2)/10
  means2[i] = mean2
}
hist(means2)

# Calculate the proportion above the 95th percentile of the first simulation
prop = 1 - ecdf(means2)(ninefive) # 0.722

# That is called the rejection region

# 10.d
# 1/12*(b-a)
a = -0.5
b = 0.5
var = (a^2 + a*b + b^2)/3
std = sqrt(var)
se = std/sqrt(10) # 0.09128709

# To calculate the critical value at alpha = 0.05
# With the alternate hypothesis that u > 0
cv = qnorm(0.975,0,se) # 0.1789194

# 10.e
# The power = 1 - Beta
# Beta is given by the portion of the u = 0.2 distribution
# which is below the critical value of u = 0, alpha = 0.05

a = -0.3
b = 0.7
var2 = (a^2 + a*b + b^2)/3
std2 = sqrt(var2)
#se2 = std2/sqrt(10) # 0.1110555
#cv2 = qnorm(0.975,0.2,se2)
power = 1 - pnorm(cv,0.2,std2) #0.5239327

# 10.f
power # 0.5239327 is the power we obtain from the simulated results
prop # 0.722 is calculated from the uniform distribution.

# On the first glance, these two values look very different, but if you increase
# sample size, n, of the simulation, the power will approach 0.7, the second
# value.

ninefive # 0.1460874 the 95th percentile 10.b
cv # 0.1789194 is from 10.d

# The signficance values are very close, as the sample size increases for the 
# simulation, the significance of simulation (ninefive) will approach 0.


#### Ignore ####
# power2 = 1 - punif(cv, -0.3, 0.7) # cv came from the u = 0 distribution
# # 0.5210806 is the power we obtained from the theoretical calculation
# 
# cv # 0.1789194 is 95% significance value from simulation
# var_t = (b - a)^2/12 # a = -0.3, b = 0.7
# se_t = sqrt((var_t)/10)
# cv2 = 1.96 * se_t; # 0.1789227 95% from theoritical calculation
# 
# # The power from the simulation results is very close to the theoretical value, 
# # as the number of simulation increases, it will be even closer.
# # The simulated power is higher than the theoretical by 0.01452039.
# 
# # Let 
# z_s = (mean(means2)-0.2)/(sqrt(var(means2))/sqrt(10))
# p_s = 1- pnorm(z_s) # 0.5184201
# # The simulated significance (p-value), pnorm(z_s) is 0.5184201
# z_t = (0.2-0.2)/se
# p_t = pnorm(z_t) # 0.5
# # The theoretical significance is 0.5, lower than 0.5184201 the simulated valye
# # so that we are will reject null hypothesis at a lower sigificance level
# # with the theoretical result.
# 


