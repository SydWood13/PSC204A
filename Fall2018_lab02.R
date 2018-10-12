####################################################
##                                                ##
##                   204A Lab 2                   ##
##                October 12, 2018                ##
##                                                ##
##               Kristine O'Laughlin              ##
##                   Fall 2018                    ##
##                                                ##
####################################################



## Today's Objectives:
####################################################
# 1. Recap
# 2. Distributions in R 
# 3. Central Limit Theorem
# 4. Describing Data/Basics of Plotting
# 5. Standardizing Scores
# 6. Confidence Intervals around a Sample Mean
# 7. z-test for a Mean



## RECAP:
####################################################

# In our first lab, we talked about some basics of 
# using R, including assigning names to objects, 
# data types, getting and setting working 
# directories, reading in data, subsetting data, 
# and getting help in R.


# What function would I use to see my current
# working directory?


# What function would I use to look at the contents
# of that directory?


# What function would I use to read in a .csv file?


# So, how can I look at the data type of an object?


# How could I subset the data to create a data frame
# including only rows 50-100 and columns 3-4?


# If I was unsure about how to use a function, how could
# I access the help file for that function?



## DISTRIBUTIONS IN R
####################################################

# We can use functions in R to generate data with
# certain distributional properties

# runif(N, min, max)
# Generates random uniform distribution data based on
# argument parameters
runif(100, 0, 10)
hist(runif(1000, 0, 10))

# rnorm(N, mean, sd)
# Generates random normal distribution data based on
# argument parameters
rnorm(100, 0, 1)
hist(rnorm(1000, 0, 1))

# rf(N, df1, df2)
# Generates random F distribution data based on
# argument parameters
rf(100, 1, 6)
hist(rf(1000, 1, 6))


# And just for funsies, my personal favorite distribution...
plot(density(rbeta(1000, .25, .25)))



# BATMAN...

# ...but really, rbeta(n, shape1, shape2)
# Generates random beta distribution data based on
# argument parameters

# I also threw in plot(density()), which is how you 
# generate a kernel density plot in R...because Batman
# is "smooth"... :|



## CENTRAL LIMIT THEOREM
####################################################

# Let's talk about the Central Limit Theorem (CLT)

# We'll begin by making some populations of scores:

set.seed(101317) # By running set.seed(), you can replicate
# randomly generated values
# By running this line, before the proceeding 
# line, you should also 
# get the same results as me
pop.norm = rnorm(400000, 0, 1)

set.seed(101417)
pop.unif = runif(400000, -5, 5)

set.seed(101517)
pop.f = rf(400000, 1, 30)


# What does the CLT tell us about these populations?


## 1. The sampling distribution of the mean will have
#     mean equal to mu.

## 2. The variance of the sampling distribution of the 
#     mean will be equal to sigma^2/N (and it's square 
#     root, sigma/sqrt(N) is the standard deviation of
#     this sampling distribution OR "the standard error
#     of the mean".

## 3. If the population distribution is normal, the 
#     sampling distribution of the mean will also be
#     normal, no matter the size of N.

## 4. If the population distribution is NOT normal,
#     but N is sufficiently large, then the sampling
#     distribution of the mean will be approximately
#     normal.


# Let's use our generated populations to visualize the 
# properties of the CLT:

# par() is a function to control various plot features
# mfrow allows us to change the number and arrangement
# of plots displayed within a single image 
# Arranged by rows and columns : 
# c(rows, columns)
par(mfrow = c(3, 1))

hist(pop.norm); hist(pop.unif); hist(pop.f)

# How should the distributions of the means look for 
# each of these populations?

# Let's use R to verify:

# In the code below, we are taking samples of 1, 5, 
# 15, 30, and 50 from our populations we just created 
# and repeating this 300 times for each sample size 
# and computing means for each of the populations
pop.norm.mean = lapply(c(1, 5, 15, 30, 50), function(x){
  unlist(lapply(1:300, function(y){
    mean(sample(pop.norm, x, replace = FALSE))
  }))
})


pop.unif.mean = lapply(c(1, 5, 15, 30, 50), function(x){
  unlist(lapply(1:300, function(y){
    mean(sample(pop.unif, x, replace = FALSE))
  }))
})

pop.f.mean = lapply(c(1, 5, 15, 30, 50), function(x){
  unlist(lapply(1:300, function(y){
    mean(sample(pop.f, x, replace = FALSE))
  }))
})

# Now, creating a set of names for our sampling distributions:
sampsize = c('Sample Size of 1', 'Sample Size of 5', 
             'Sample Size of 15', 'Sample Size of 30', 
             'Sample Size of 50')

# Naming the sampling distributions:
names(pop.norm.mean) = sampsize
names(pop.unif.mean) = sampsize
names(pop.f.mean) = sampsize

# We can then plot our sampling distributions

# Start by rearranging our plot window
par(mfrow = c(2, 3))

# In this line of code, I'm simply plotting the
# histogram for the normal population
# The "col" argument allows us to change the plotting color
# The "main" argument allows us to add a title to our plot
hist(pop.norm, col = 'tomato', main = 'Normal Population Distribution')

# I am using this next bit of code to loop over the 
# elements of my list of sampling means from each of 
# the different N's, and I am just plotting a histogram 
# for each of those sampling distributions for each of the N's
# NOTE: I have also added an xlim argument to change 
#       the limits on the x-axis
lapply(names(pop.norm.mean), function(x){
  hist(pop.norm.mean[[x]], col = 'slategray',
       main = x, xlab = '', xlim = c(-4, 4))
})

# Plotting the histogram for the uniform population
hist(pop.unif, col = 'tomato', main = 'Uniform Population Distribution')

# Plotting the sampling distributions of the mean from
# the uniform distribution
lapply(names(pop.unif.mean), function(x){
  hist(pop.unif.mean[[x]], col = 'slategray',
       main = x, xlab = '', xlim = c(-4, 4))
})

# Plotting the histogram for the F population
hist(pop.f, col = 'tomato', main = 'F Population Distribution',
     xlim = c(-4, 4))

# Plotting the sampling distributions of the mean from
# the F distribution
lapply(names(pop.f.mean), function(x){
  hist(pop.f.mean[[x]], col = 'slategray',
       main = x, xlab = '', xlim = c(-4, 4))
})


# Returning plotting parameters to display a single plot
# at a time:
par(mfrow = c(1, 1))



## DESCRIBING DATA/BASICS OF PLOTTING
####################################################

# Some functions to describe data:

mean(pop.norm, na.rm = T)
median(pop.norm)
max(pop.norm)
min(pop.norm)
sd(pop.norm)
var(pop.norm)
# all of these functions use the na.rm = TRUE argument
# the default argument is na.rm = FALSE


# Histograms for the populations we generated earlier:
hist(pop.norm)
hist(pop.unif)
hist(pop.f)


# Denstiy plots:
plot(density(pop.norm))
plot(density(pop.unif))
plot(density(pop.f))


# Some plotting parameters we can manipulate:
hist(pop.norm, main = "Histogram of Standard Normal Pop",
     xlab = "Values", xlim = c(-2, 2), breaks = 200, col = 'slategray')

hist(rnorm(25, 0, 1), main = "Histogram of Standard Normal Pop",
     xlab = "Values", xlim = c(-2, 2), breaks = 200, col = 'tomato')

hist(rnorm(25, 0, 1), main = "Histogram of Standard Normal Pop",
     xlab = "Values", xlim = c(-2, 2), breaks = 10, col = 'cyan')

# We can also add horizontal and vertical lines to an 
# existing plot using the abline() function
abline(v = .25) # to add a vertical line
abline(v = .25, lwd = 2) # to change the line weight
abline(h = 3, lty = 3) # to add a horizontal line
                       # and change line type



## STANDARDIZING SCORES
####################################################

# Let's generate some data to illustrate how to 
# create standardized scores in R
set.seed(10090)
temp = rnorm(500, 5, 2.3)
hist(temp)
mean(temp)
sd(temp)

# Let's start by standardizing the values manually
# (i.e., subtacting the mean of temp from each observed
# value and dividing each by the SD of temp)
temp2 = (temp - mean(temp))/sd(temp)
hist(temp2)
mean(temp2)
sd(temp2)

# Now using the scale() function in R
temp3 = scale(temp) 
mean(temp3)
sd(temp3)

tdat = data.frame(temp, temp2, temp3)
cor(tdat)
# cor() is the correlation function, we'll talk about
# it much more later, for now it can be used to
# show us that the variability between temp versions
# is identical. So, even though the values have changed
# the relative location of all the observations are
# identical in each version of temp.


# The scale() function will return standarized
# scores so that our distribution has a mean of zero and
# a standard deviation of 1. However, we can easily 
# change the mean and SD to be anything we want:

# Start by standarding temp:
temp4 = scale(temp)

# Then re-scale by the SD we want:
temp4 = temp4 * 2

# Next, add the mean value:
temp4 = temp4 + 10

mean(temp4)
sd(temp4)

# Will temp4 show perfect correspondence with temp, temp2, 
# and temp3?

# Let's see!
cor(data.frame(tdat, temp4))

# And it does!



## CONFIDENCE INTERVALS AROUND A SAMPLE MEAN
####################################################

# In class yesterday we learned how to compute a 
# confidence interval around a sample mean.

# Let's practice this concept using the following example:

# We know that IQ scores follow a normal distribution 
# with mean equal to 100, and standard deviation
# equal to 15 in the population.

# Imagine you have 3 random samples of IQ scores, 
# each with the following characteristics:

# samp1: xbar = 82, N = 15
# samp2: xbar = 96, N = 10
# samp3: xbar = 110, N = 11

# Let's construct confidence intervals for each of these
# sample means:

# Recall the steps to constructing a confidence interval:

## 1. Draw a sample from the population. 

## 2. Compute sample mean.

## 3. Compute the standard error, i.e., the SD of the
#     sampling distribution of the mean.

## 4. Construct a confidence interval around the
#     sample mean:
#     xbar +/- Std.Error * Critical.z.score


# We have already (presumably) taken random samples from
# our population of IQ scores.

# Let's assign our means as objects in R:
samp1.xbar = 82
samp2.xbar = 96
samp3.xbar = 110

# Next, we need to compute the standard error of the mean 
# for each of our samples.
# Standard error is computed as sigma/sqrt(N)
samp1.se = 15/sqrt(15) 

## YOUR TURN!
# Try to compute the standard error of the mean for the
# two remaining samples.



# qnorm() is a function that will return the inverse of 
# the cumulative density. So in other words,
# it will return the value associated with a given probablity.
# Using qnorm(), we can get a critical z-value

# qnorm() will return the value corresponding to the 
# probability, p, to the right of that value. So when providing
# a p to R, we need to enter it as 1 - alpha/2...
# But why do we have to divide our alpha by 2?

# So, if we want a 95% confidence interval, we would need
# to enter a p of 1 - .05/2 = .975 
qnorm(.975, 0, 1)

# Alternatively, we could just set lower.tail = FALSE,
# and use alpha/2. Here, .05/2 = .025:
qnorm(.025, 0, 1, lower.tail = F)
# which gives us the same answer

# Let's store this critical z in our environment:
critz = qnorm(.025, 0, 1, lower.tail = FALSE)


# And finally, we can construct our 95% confidence interval:

# 95% CI for mean of samp1:
c((samp1.xbar - samp1.se * critz), (samp1.xbar + samp1.se * critz))
# Is 100 within the 95% CI?

# How do you interpret this CI?


## YOUR TURN!
#  Compute 95% CI's for the means of samp2 and samp3
#  Is 100 contained within either or both of the CI's?  



# What if you wanted to compute a 99% CI?

# You would only need to tweak one element to
# get a 99% CI.

# You need a new critical value:
critz.99 = qnorm(.005, lower.tail = F)


# And then you can construct the new interval:
c((samp1.xbar - samp1.se * critz.99), (samp1.xbar + samp1.se * critz.99))
# Is this interval wider or more narrow than the interval
# we previously saw?



## Z-TEST FOR A MEAN
####################################################

# We can get to the same conclusion using a z-test for a mean

# Recall that we know that IQ scores ~N(100, 15) 
# in the population

# Also recall our 3 random samples of IQ scores 
# each with the following characteristics:

# samp1: xbar = 82, N = 15
# samp2: xbar = 96, N = 10
# samp3: xbar = 110, N = 11

# Do any of these samples differ significantly from the population?

# Steps to conducting a one-sample z-test:

## 1. State the null and alternative hypotheses.

## 2. Compute a z-value:
#     (xbar - mu)/(sigma/sqrt(15)) 

## 3. Compare your z-value to a critical z


# What are our null and alternative hypotheses
# for sample 1?

# HO: mu = 100
# Ha: mu != 100

# Computing a z-value for the mean of sample 1
samp1z = (samp1.xbar - 100)/(15/sqrt(15))
samp1z

# Is the probability of obtaining this z-value
# less than our specified alpha level in either 
# of the tails?

# pnorm() is a function that will give us the
# cumulative density for a normal distribution.
# We need to input q, which in this case in the
# z-value we are evaluating.

# For a two-tailed test, remember that we need to 
# divide our alpha by 2. Because our z-value is 
# negative, we also need to set the lower.tail 
# argument to TRUE
.025 > pnorm(samp1z, lower.tail = TRUE)
# Two-tailed, alpha = .05

.005 > pnorm(samp1z, lower.tail = TRUE)
# Two-tailed, alpha = .01


# Let's say that for sample 2, you hypothesize
# that the sample mean is actually less than
# the population mean.

# What would be the null and alternative hypotheses?

# H0: mu = 100
# Ha: mu < 100

# Let's compute our z-score:
samp2z = (samp2.xbar - 100)/(15/sqrt(10))
samp2z

# Finally, let's check the probability.
# We are now using a one-tailed test, which means
# that we are only intereste in values in the lower
# end of the tail, so we don't divide by 2:
.05 > pnorm(samp2z, lower.tail = TRUE)
# One-tailed, alpha = .05

# And we see that our sample mean is NOT less than
# the population mean.




## PRACTICE
#################################################

# Now you try!

# Create the data set
set.seed(10913)
v1 = rnorm(500, 5, 3.3)
v2 = rnorm(500, 3.3, .5)
v3 = sample(c(0, 1), 500, replace = TRUE)
v4 = sample(c(1, 2, 2, 3, 3, 3, 4, 4, 4, 4, 4, 5, 5, 5, 6, 6, 7), 
            500, replace = TRUE)
d = data.frame(v1, v2, v3, v4)


# Some exercises to conduct:

# 1. Get the mean, median, min, max for v1 & v2
# 2. Plot v1-v4, describe the distribution of the data
# 3. Calculate the biased and unbiased SD for v1-v2 & v4
# 4. Calculate the frequency of 0 and 1 for v3
# 5. Transform v1 and v2 into normal standard distributions
#	   by "hand" and using scale()