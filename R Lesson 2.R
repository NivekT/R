# Created by Kevin Tse
# University of Chicago 

# As always
require(mosaic)

# Import the dataset from last time

# Plotting:
# https://cran.r-project.org/web/packages/ggplot2/ggplot2.pdf
ggplot(data = GDP, aes(x = Year, y = GDPCA, group = 1)) + 
  geom_line() + 
  geom_point() + 
  ggtitle("U.S. Annual GDP")

# aes - aesthetic mapping
# grouping of lines using group =

#geom_line draw lines
#geom_line(colour="red", linetype="dashed", size=1.5)

# geom_point() draws individual data points
#scale_color_manual

# 0 = blank, 1 = solid, 2 = dashed, 3 = dotted, 4 = dotdash, 5 = longdash, 6 = twodash


ggplot(data = GDP, aes(x = Year, y = GDPCA)) +
  geom_line(aes(y = GDPCA, linetype = "GDPCA")) +
  geom_line(aes(y = Consumption, linetype = "Consumption")) +
  geom_line(aes(y = Investment, linetype = "Investment")) +
  geom_point(aes(group = Party, colour = Party)) +
  #(aes(y =  Consumption, colour = Party)) +
  #geom_point(aes(y = Investment, colour = Party)) +
  #scale_linetype_manual(values = c("solid", "dashed", "doubledashed")) +
  scale_color_manual(values = c("blue", "red"))

#Alternative: Need reshape package
require(reshape)
GDP2 <- melt(GDP, id = c("Year", "Party"))
# melt puts all non-specified columns (GDPCA, C, I) into
# two new "variable" and "value" columns
head(GDP2)

ggplot(data = GDP2, aes(x = Year, y = value, linetype = variable)) +
  geom_line() +
  geom_point(aes(y = value, group = Party, colour = Party), subset(GDP2, variable == "GDPCA")) +
  scale_color_manual(values = c("blue", "red")) #+
  # geom_smooth(method='lm')
  # Linear regression
  
  # geom_smooth(method = "glm", family = gaussian(link="log"))
  
  
  
# Use subset to only plot partial data
# I can expand this into making sections of the line with different colors
  
# Export write.csv(Dataset, "Name.csv")
# Or you can manually export plots on the bottom right