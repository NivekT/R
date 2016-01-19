# Created by Kevin Tse
# University of Chicago 

# Learning is much more effective if you attempt to think about
# what the codes do before typing them in and running them in the
# console. I strongly encourage to think about them before running
# them or even before reading the explanations.

# Aside from the built-in functions, R has many different 
# additional packages available to be installed and used.
# A package is basically a set of functions written by others
# and provided to us for our convenience. There is a package
# out there for almost any purpose that we can think of.

# Here is some background information about the interface of RStudio
# The top left window displays the R scripts/codes and dataframe
# You can highlight codes in this window and Press Run (or Ctrl/Cmd + R)
# to run the highlighted codes, so you dont have to copy and paste them
# The bottom left window is your Console where you can type in and run codes
# The top right window shows different datasets that you have and code history
# The bottom right window display plots, help, files, packages

# The package "mosaic" has many tools for mathematics, statistics,
# computation and modeling. More details on mosaic-web.org

# Here is one way to install a package, notice the " "
install.packages("mosaic")

# Then, you need to tell R that you would like to use the package
# This needs to be done each time you start a session of RStudio
require(mosaic)

# R has 
getwd() # Returns the current working directory, where you access your 
        # data files and save your data files to
setwd("Address") # Allows you to change your working directory
                 # Ex. setwd("c:/Users/Desktop")


#Creating Dataset
Position <- c(1,2,3) # This creates a vector with elements 1, 2, and 3
                     # saved to the variable Position
Position # Check out what it looks like!
Letters <- c("a","b","c")
Letters[2] # You can access an individual element in the vector with 
           # its index position
Caps <- c("A","B","C")

# This compiles the three vectors into a data frame
abc = data.frame(Letters, Position, Caps) 
abc # Notice that the variable names become column names

# Data frame can be seen as a matrix 
# and its elements can be accessed as Variable[row,column]
# Similarly, to change an element by V[r,c] = x
abc[3,3] # Returns C
abc[2,2] # Returns 2

# Another way to access a vector within a dataframe is to 
# use the $
abc$Letters # Returns the Letter vector within abc dataframe
abc$Letters[3] # We can treat abc$Letters like a vector and 
               # access an element like so

# colnames(df)
colnames(abc) # Allows you to access the colnames within the dataframe
              # in the form of a vector
colnames(abc)[1] # We can access an element with its index
colnames(abc)[1] = "Letter" # Similarly, we can change 
                            # colname within the dataframe

# You can learn the number of elements in the vector by using
length(abc$Letters) # This will return 3

# Now here is something slightly more advanced, we want to search
# a vector for a certain value
# Let's say we want to find the position of "C" in Caps
Caps # Let's review what the Caps vector looks like
match("C",Caps) # Returns 3, which is the same result as eyeballing
match("C",abc$Caps) # We can also do this to search a vector in a dataframe
# Now we want to find the corresponding lower case of "C" 
abc$Letters[match("C",abc$Caps)] # This first finds the location of C, and returns
                                 # the element in the same position in Letters

# For loop
# This allows you do something repeated for a number of times
# For instance, let's say we want to increase every number of the Position
# vector in abc by 10
for (i in 1:length(abc$Position))
{
  abc$Position[i] = abc$Position[i] + 10
}

# I have created a dataset on the U.S. GDP for practice purposes
# Source: https://research.stlouisfed.org/fred2/series/GDPCA

# We can import the data into R with the following
GDP = read.csv("GDP_for_R.csv") # It will be saved to variable GDP
# Alternatively, you can clickt the Import Dataset on the top right window
# it will give you more options on importing the data and parsing

head(GDP) # Will give you a peek at the data, rather than its entirety

# Play around with this dataset, try to access different variable
# Some functions to try
mean(GDP$GDPCA)
median(GDP$GDPCA)
sd(GDP$GDPCA)

# Using what we have learned so far, 
# I want you to add a new column called Diff in GDP, that will contain
# the difference between the GDP of the year and the GDP from the year before

# GDP$ColName <- NULL # Allows you to delete a column

# Sample Solution:
GDP$Diff = 0 # Create a new column in dataframe
GDP$Diff[1] = 0 # Since there is no previous year, set to 0
                # This is not necessary if they already are 0 as I have done
for (i in 2:length(GDP$GDPCA)) # Start from the second available year
{
  GDP$Diff[i] = GDP$GDPCA[i] - GDP$GDPCA[i-1] # Computing the difference
}

