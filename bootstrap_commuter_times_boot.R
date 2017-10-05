# a package boot with a function boot() that does the bootstrap for many situations. I
#  will revisit the Atlanta Commute Times example. 
library(boot)
data(CommuteAtlanta)

my.mean = function(x, indices) {
  return( mean( x[indices] ) )
}

# The function boot() requires three arguments:
#   (1) the data from the original sample (a data frame or a matrix or an array); 
#   (2) a function to compute the statistics from the data where the first argument is the data and the second argument
#      is the indices of the observations in the bootstrap sample; 
#   (3) the number of bootstrap replicates.
time.boot = boot(CommuteAtlanta$Time, my.mean, 10000)

# Notice that my.mean(CommuteAtlanta$Time,1:length(CommuteAtlanta$Time) computes the mean of the original sample.
# The object time.boot is a list with many elements. One is time.boot$t0 which is the sample
# mean of the original data. Another is time.boot$t which is the collection of bootstrap statistics
# that can be used as above. 


# the built-in function boot.ci() will calculate bootstrap condence
# intervals using multiple methods.
#    Result: Basic uses the estimated standard error. Percentile uses percentiles. BCa also uses percentiles,
#    but adjusted to account for bias and skewness.
boot.ci(time.boot)