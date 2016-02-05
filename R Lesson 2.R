# Created by Kevin Tse
# University of Chicago 

# As always
# if you don't have it, install.packages("mosaic")
require(mosaic)

# Import the dataset from last time

# Plotting:
# Documentation: https://cran.r-project.org/web/packages/ggplot2/ggplot2.pdf

# This ggplot sets up the framework for plotting
# To plot things, we need addition commands
ggplot(data = GDP, aes(x = Year, y = GDPCA))

# aes - aesthetic mapping, inside this function, you can decide how the variables
# will be presented on the plot
# For example, we set what variables go on x- and y-axis, and we can
# put data into groups and plot them on a line

# geom_point() draws idividual data points
# scale_color_manual allows you to put in a column of values

ggplot(data = GDP, aes(x = Year, y = GDPCA)) + 
  geom_point() 

#geom_line draw lines
#geom_line(colour="red", linetype="dashed", size=1.5)

ggplot(data = GDP, aes(x = Year, y = GDPCA)) + 
  #geom_point() +
  geom_line(colour="red", linetype="dashed", size=1.5)
# 0 = blank, 1 = solid, 2 = dashed, 3 = dotted, 4 = dotdash, 5 = longdash, 6 = twodash


# There are other functions, such as ggtitle, label, regression for you
# to use within the ggplot package
# xlab(""), ylab, ylim(0,1)

ggplot(data = GDP, aes(x = Year, y = GDPCA)) + 
  geom_point() +
  geom_line() +
  ggtitle("U.S. Annual Real GDP")

# Now let say we want to plot GDP and Consumption
# We can do the following

ggplot(data = GDP, aes(x = Year, y = GDPCA)) +
  geom_line() + # plot GDP as y by default
  geom_line(aes(y = Consumption)) # We change what is on y-axis in aes

# Let's throw in some colours and change linetypes

ggplot(data = GDP, aes(x = Year, y = GDPCA)) +
  geom_line(aes(color = "GDP", linetype = "GDP")) +
  geom_line(aes(y = Consumption, color = "Consumption", linetype = "Consumption"))

# Automatically assign color and linetype from defaults

ggplot(data = GDP, aes(x = Year, y = GDPCA)) +
  geom_line(aes(color = "GDP")) +
  geom_line(aes(y = Consumption, color = "Consumption")) + 
  scale_color_manual(values = c("green", "red"))
  
# Now I want you to plot three lines on one plot
# for investment, consumption, and GDP
# In addition, I want each GDP points plotted, and a title for the plot
# As an extra challenge, in years where U.S. has a republican president
# Make the data point, red, and blue for Democratic presidents.
# My suggestion is that you should implement these features of the plot
# one by one. The extra challenge may require a bit of googling 
# on using "group = " in aes. 
  






# Sample Solution

ggplot(data = GDP, aes(x = Year, y = GDPCA)) +
  geom_line(aes(y = GDPCA, linetype = "GDPCA")) +
  geom_line(aes(y = Consumption, linetype = "Consumption")) +
  geom_line(aes(y = Investment, linetype = "Investment")) +
  geom_point(aes(group = Party, colour = Party)) +
  #(aes(y =  Consumption, colour = Party)) +
  #geom_point(aes(y = Investment, colour = Party)) +
  #scale_linetype_manual(values = c("solid", "dashed", "doubledashed")) +
  scale_color_manual(values = c("blue", "red")) +
  ggtitle("U.S. Annual Real GDP, Consumption, and Investment")

#Alternative: Need reshape2 package
require(reshape2)
GDP2 <- melt(GDP, id = c("Year", "Party"))
# What happened here?

head(GDP2)
# Can you explain what happened? What is in GDP2?




# melt puts all non-specified columns (GDPCA, C, I) into
# two new "variable" and "value" columns
# This addresses the issue with labels on the right
ggplot(data = GDP2, aes(x = Year, y = value, linetype = variable)) +
  geom_line() +
  geom_point(aes(y = value, group = Party, colour = Party),
             subset(GDP2, variable == "GDPCA")) +
  scale_color_manual(values = c("blue", "red")) +
  #geom_smooth(method='lm') + # Linear regression
  #ylab("US$") + xlim(2000, 2010) + theme_minimal() # other features


  # geom_smooth(method = "glm", family = gaussian(link="log"))
  
  
# Use subset to only plot partial data
# I can expand this into making sections of the line with different colors

# Export your datasets from R to .csv file
# You can change datasets in RStudio then export in to files for other usages
# Export write.csv(Dataset, "Name.csv")
# Or you can manually export plots on the bottom right