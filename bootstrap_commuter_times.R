# Install packages for the data set
# install.packages("Lock5Data")

# The data set CommuteAtlanta from the textbook contains variables about a sample of 500
#  commuters in the Atlanta area.
library(Lock5Data)
data(CommuteAtlanta)
str(CommuteAtlanta)

# To construct the condence interval for the mean commute time in Atlanta, we need to find the
#   point estimate (sample mean) from the original sample.
time.mean = with(CommuteAtlanta, mean(Time))
time.mean

# To find the standard error, we will create a huge matrix with 1000 rows (one for each bootstrap sample) 
# and 500 columns (one for each sampled value, to match the original sample size). 
# We will then use apply() to apply mean() to each row of the matrix. This approach differs from the
# example in the author R guide that uses a for loop, but we can show this approach later as well.

# First create a large matrix to store all of the samples
B = 1000
n = nrow(CommuteAtlanta)
boot.samples = matrix(sample(CommuteAtlanta$Time, size = B * n, replace = TRUE),
                      B, n)

# the three arguments to apply() are (1) the object on which parts will applied the function, 
#  (2) the number 1 to indicate the function should be applied to each row (use 2 for columns), 
#  and (3) the function name mean.
boot.statistics = apply(boot.samples, 1, mean)

# ggplot() requires a data frame with the input data, so we use data.frame() to create one with the only
#   variable of interest
# You will see a distribution that is not too asymmetric and is bell-shaped, more or less. 
require(ggplot2)
ggplot(data.frame(meanTime = boot.statistics),aes(x=meanTime)) +
  geom_histogram(binwidth=0.25,aes(y=..density..)) +
  geom_density(color="red")

# The standard deviation of this distribution is as follows.
time.se = sd(boot.statistics)
time.se

# construct the confidence interval. Here, I round the margin of error up and to one
# decimal place so that it has two significant digits, and I am being cautious when rounding not to
# make the interval too small.
me = ceiling(10 * 2 * time.se)/10

# interpret in CI context. We are 95% confident that the mean commute time in Atlanta among commuters who
#  do not work at home is in the interval from 27.2 to 31 minutes.
round(time.mean, 1) + c(-1, 1) * me

# Function of the above to make it simple in the future
# A quick bootstrap function for a confidence interval for the mean
# x is a single quantitative sample
# B is the desired number of bootstrap samples to take
# binwidth is passed on to geom_histogram()
boot.mean = function(x,B,binwidth=NULL) {
  n = length(x)
  boot.samples = matrix( sample(x,size=n*B,replace=TRUE), B, n)
  boot.statistics = apply(boot.samples,1,mean)
  se = sd(boot.statistics)
  require(ggplot2)
  if ( is.null(binwidth) )
    binwidth = diff(range(boot.statistics))/30
  p = ggplot(data.frame(x=boot.statistics),aes(x=x)) +
    geom_histogram(aes(y=..density..),binwidth=binwidth) + geom_density(color="red")
  plot(p)
  interval = mean(x) + c(-1,1)*2*se
  print( interval )
  return( list(boot.statistics = boot.statistics, interval=interval, se=se, plot=p) )
}

# how to use the function for the heights of father in father_son.csv.
setwd("G:\\onlineSchool\\SMU\\MSDS6306\\lectureNotes\\week5\\swirlInference")
fname <- "father_son.csv"
fs <- read.csv(fname)
# father height: fheight; son height is sheight
out = with(fs, boot.mean(fheight, B = 1000))

# height interval of the father: 67.52432 67.84987
out$interval


# For Loop: (Optional)
#  Rather than taking all the samples at once, the for loop just takes samples one at a time. 
#   Usually, R code that uses apply() is more efficient than code that uses for loops. 
#   Try both out for a large number of bootstrap replicates!
n = length(fs$fheight)
B = 1000
result = rep(NA, B)
for (i in 1:B) {
  boot.sample = sample(n, replace = TRUE)
  result[i] = mean(fs$fheight[boot.sample])
}
# height interval of the father: 67.51901 67.85518
with(fs, mean(fheight) + c(-1, 1) * 2 * sd(result))

