library(ggplot2)

nosim <- 1000
cfunc <- function(x, n) mean(x)

g1 = ggplot(data.frame(y = rep(1/6, 6), x = 1 : 6), aes(y = y, x = x))
g1 = g1 + geom_bar(stat = "identity", fill = "lightblue", colour = "black")
print(g1)

# Here, we've run code and plotted a histogram after we took 1000 such averages, each of 50 dice rolls. 
# Note the unusual y-axis scale. We're displaying this as a density function 
# so the area of the salmon-colored region is theoretically 1. With this scale, though, all the heights of the bins
# actually add up to 5. So you have to multiply each height by .2 and add up all the results to get 1. 

# sample takes a sample of the specified size from the elements of x 
# using either with or without replacement.
# sample(x) generates a random permutation of the elements of x (or 1:x);
# sample(1 : 6, nosim * 50, replace = TRUE) with nosim * 50 permutations.
dat <- data.frame(x = apply(matrix(sample(1 : 6, nosim * 50, replace = TRUE), 
                                   nosim), 1, mean))
# Theoretically, the average is 3.5. 
g2 <- ggplot(dat, aes(x = x)) + 
  geom_histogram(binwidth=.2, colour = "black", fill = "salmon", aes(y = ..density..)) 
print(g2)
#grid.arrange(g1, g2, ncol = 2)

