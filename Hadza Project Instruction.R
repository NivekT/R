# Hadza and the Endowment Effect
# By Gabriel Varela and Kevin Tse
# Oeconomica at the University of Chicago

# This project is based on the paper
# Evolutionary Origins of the Endowment Effect: Evidence from Hunter-Gatherers
# by Coren Apicella, Eduardo Azevedo, Nicholas Christakis, and James Fowler
# http://assets.wharton.upenn.edu/~eazevedo/papers/Apicella-et-al-Endowment-Effect.pdf

# Commands we expect you to know:
for (i in n:m) {}
if (condition) {} else {}
%in% # From the second big group section

# What's na.rm? It's going to be important here
mean(data, na.rm = TRUE) 

# The ggplot cheatsheet I sent out will come in handy
ggplot() + geom_point() + geom_bar() + ... 

# We'll introduce new ones along the way

# If you want to know what any command does, just type ?command_name into the console. eg:
?mean

# Keep a .R file with all your commands to send to us so we can try out your code later


# Background Information

# Set your work directory and import the data

# What some of the columns mean:
  # utm36m: UTM geographic coordinates of camp. 
  # v9: UTM geographic coordinates of camp.
  # gpsx: GPS geographic coordinates of camp.
  # gpsy: GPS geographic coordinates of camp.
  # endowmentcondition: Whether subject was tested according to condition 1 or 2 in the experiment.
  # endowmentlighter: Whether subject traded the item in the choice among lighters. 
  # endowmentbiscuit: Whether subject traded the item in the choice among biscuits.


# Clean up the data

# You won't need all of these columns so start off by deleting the 
# ones you don't (for convenience). It's up to you what you delete, but
# keep in mind the objective of our project. We won't need GPS co-ordinates.

# Look through the data frame. There are 2 rows that 
# aren't particularly useful to us. Delete them.
# Tip: delete row i from data fram df with:
df <- df[-c(i),]      # What's happening here?

# Rename columns as you wish


# Data Manipulation

# First off we want dummies for trades happening in each condition and for each object
  # For example, one of these should be a column called (say) lighter_c1 that takes the value
    # 1 if the subject was tested in condition 1 AND traded the lighter
    # 0 if the subject was tested in condition 1 AND didn't trade the lighter
    # NA if the subject wasn't tested in condition 1
  # You should have 4 such columns
# Why is this useful? We will use it further on
# This might be useful:
if ((condition 1) && (condition 2) && ...) {command}

# Endowment Effect x Exposure to Modern Societies

# Create a column for the exposure (high or low) of each camp
# These camps should be High Exposure (HE):
  # Endadubu, Mayai, Mizeu, Mwashilatu, Onawasi
# What data type is this and what do we want it to be? 
# Think about the second big group session...

# Now, to plot Trades vs. Exposure we need a data frame that tells us total 
# trades for each exposure. We'll use the aggregate function here.
# A model is given below:
aggregate(df[, n:m], by = list("list name" = what_to_list_them_by), FUN = f, ...)
# What aggregate does is:
  # It compiles a new data frame using the data we give it (first argument)
    # In this example it'll use columns from n to m of the data frame df
    # We want to aggregate trades by exposure so use the columns lighter_c1, etc.
      # These columns tell us whether trades happened or didn't
  # It compiles this data aggregating by some factor
    # We want our data to be aggregated by camp exposure (HE and LE separately)
    # aggregate needs a list to aggregate by so we create a list using
    # list("list name" = what_to_list_them_by)
    # So the second argument (what_to_list_them_by) should be our exposure 
    # column in our data frame
  # It uses the function we tell it to (e.g. FUN = var will take variances)
    # We want the means of trades happening in each object/condition pair
      # Why are we using the mean, but not the total?
  # And we can give it more commands
    # In this case we want to tell it na.rm = TRUE. Why? 
      # This is important. See what happens if we don't
# Try to figure out how to do this alone.
# If you can't / don't want to, here is ours to help (you'll have to do this again later on):
Mangola <- aggregate(Hadza[10:13], by = list(Exposure = Hadza$Exposure), FUN = mean, na.rm = TRUE)
View(Mangola)

# You should have one column saying 1 or 0 (exposure from your original data frame)
# and four others aggregating the means of lighter_c1, lighter_c2, etc by exposure
# To make it prettier, replace exposure == 1 by "HE" and ==0 by "LE"
  # Hint: Just assign a new value to it with some condition (%in% will come in handy)

# We don't care about trades by condition/object pair, we care about total trades
# so make a new column with total trade. What will this be?
  # It will be the mean of the trades in all cond/obj pair.
  # This will be helpful:
?rowMeans
  # And so will the for function: for (i in n:m) {command}
  # We want row i in the "total" column to be the mean of all the other columns (except exposure)

# Now make a plot of Exposure vs. Trades using ggplot exactly like the one we sent
  # We want it exactly like it so that you practice using different ggplot functions
  # The cheat sheet will help

# Lastly correlate Exposure with Trades
  # You learnt this in the third group section.
  # Which correlation formula should be use? Remember the data types!

# Endowment Effect x Distance

# Now we need a column that gives us the distance from Mangola village centre
# Mangola's UTM position is: utm36m = 765668 and v9 = 9611785
# Each unit in UTM is one metre and each value above gives the x or y position
# So just use Pythagoras' Theorem to find the distance in metres of each camp from Mangola
# and then change that to kilometres

# Now we want a new data frame with the data for our second plot: distance, trades and camp size
# (point size is proportional to camp size in the plot)
# Hint: Use aggregate to create a data frame like the one for exposure but with dist instead of ex
# Then add the total trades column just like you did for the previous one
# And a distance column and a camp size column
# Hint: distance for camp i will be equal to the mean dist of each subject in camp i
# Hint: size of camp is sum of appearances of that camp in the original data set

# Now plot it just like the one we sent you
# This one's tricky but you should be able to use the cheat sheet to do it
# These should also help
+ annotate("text", label = "label_you_want", x = x_pos, y = y_pos, size = 4) # Dont change 1st thing
+ scale_size_area(max_size = 12) # Not necessary but w/out this the points are very small


# Correlation Coefficients

# Now we want to find out the relationship between exposure, distance and trades.
# Start off by correlating trades with distance by camp (This is important! Why?).
# Now do the same with trades and exposure
# We will need a numeric variable for exposure here, in case you don't have one yet
# What type of variable is this? So what method of correlation should we use?
# Look at your correlation coefficients. Do they seem reasonable?

# There is a problem with these values.
# This is because distance and exposure are themselves related so each one also influences
# the coefficient for the other (i.e. in measuring the effect of distance, for example, we are
# also implicitly measuring the effect of exposure and vice-versa).
# So we need to control for one variable in order to examine the correlation of trade with the other.
# How do we do this?

# Our end goal is to compare the importance of exposure and distance on trade.
# One way to do this is to model trades as a function of both:
# trades = A*exposure + B*distance
# and compare the magnitudes of the coefficients A and B
# This is called making a linear regression

# Usually we cannot make linear regressions with independent variables (exp and dist) that have
# covariance. But there are functions that correct for covariance.
# For example, the function:
lm(formula = dependent_var ~ independent_var1 + independent_var2)
# creates a formula dep_var = A*indep_var1 + B*indep_var2 with a correction for covariance of
# indep_var1 and indep_var2.
# Make a linear regression of trade as a function of exposure and distance.

# There's one more problem, though. The range of exposure values is FAR smaller
# than the range of distances. Why is this a problem?
# Create a new column that gives distance in the same range (1) as exposure.
# You can give the farthest camp a value of 1 for this column. This may help:
max()
# Do the regression again using this new column in the place of distance.
# Tip: if you save the regression as an object (eg. lin_reg <- lm()), you can access the result 
# more easily (just type lin_reg) and with more info (summary(lin_reg)).


# Another way to look at the data is to separate them into two groups
# Create new data frames HE and LE that are exactly like the aggregate Camp one but each one
# with camps from the same exposure.
# We want the columns to be camp, trades, exposure (numeric!) and distance

# Now correlate trades with exposure using the original camp aggregate data frame
# and correlate trades with distance within each one of these groups (HE and LE).
# Is there a big difference between this and the previous method?
# Which one is better?

