# Playing with Diamond Data for Oeconomica
# Sylvia Klosin
# Dec 13, 2015

# In this file I run basic regressions on the diamond data from my regression class. Most of the 
# models are used to create "diamond" pricer models (predict price of diamond based on the 
# the properties of the diamond)

#================================
# Section 0: Downloading packages  
#================================
library("xtable", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
library("ggplot2", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
library("car", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
library("foreign", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
library("AER", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
library("mFilter", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
library("plm", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
library("systemfit", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")
library("stargazer", lib.loc="/Library/Frameworks/R.framework/Versions/3.2/Resources/library")

#================================
# Section 1: Setting up data 
#================================
setwd('~/Desktop')
diamonds <-  read.csv("diamond_data.csv")
# varriable description: 
# color: This variable is on an ordinal scale by letter, beginning with D.
# clarity: I, SI1 and SI2 categories (low clarity), VS categories together (medium clarity), and
# VVS categories together (high clarity)

#================================
# Section 2: Variable transformation 
#================================

diamonds$color_num <- as.numeric(as.factor(diamonds$color)) #making color a numerical varriable 

diamonds$clarity_fac <- rep(1, nrow(diamonds)) # making clarity a factor of three levels 
diamonds$clarity_fac[diamonds$clarity %in% c("VS2", "VS1")] <- 2
diamonds$clarity_fac[diamonds$clarity %in% c("VVS1","VVS2" )] <- 3
types = factor(diamonds$clarity, levels = c('1','2','3'))

diamonds$cut_num <- rep(0, nrow(diamonds))
diamonds$cut_num[diamonds$cut != "Fair"] <- 1 #therefore equal to 0 when fair and 1 when not fair

#================================
# Section 3: Graphs 
#================================

plot(diamonds$price, diamonds$carat )  # how to do simple scater plot in base R

# making a plot in ggplot #sweg
myggplot <- ggplot(diamonds, aes(x = price, y = carat)) + # puting in the data you want to use
  geom_point() + # tells ggplot the type of chart you want 
  geom_point(shape=1) + # you can change the shape of the points  
  xlab("Price") + # x label 
  ylab("Carat") + # y label
  theme_bw() + # changes the colors of the plot to make is 100x more attractive 
  geom_smooth(method=lm) + #this adds a best fit line and a region of 95% confidence 
  ggtitle("Ggplot is the best plot") 

myggplot #in ggplot the graph will not show up automaticly - you have to call it by putting in its name
#PS: If you want to remove a part of the graph (ex: rm the best fit line) just remove the line


pairs(~color_num+carat+price, data= diamonds) # correlation matrix betwen varriables 

#================================
# Section 4: Running models and viewing models 
#================================

mod1 <- lm(price ~ carat + color_num, data = diamonds) # this is a simple linear regression
# to see results to summary(mod1)

xtable(mod1) # producing standard latex tables 
stargazer(mod1) # producing sexy latex tables 

# side note: cool stargazer thing (making tables like they do in journals when they compare models)
# just put all models togther in one compand to make large table
mod2 <- lm(price ~ carat + clarity_fac, data = diamonds)
stargazer(mod1, mod2) # damn 





