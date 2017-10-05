# plot1 example
B <- 50  # 50 dice rolling
n <- 1000   # 1,000 samples
sampl <- sample(1 : 6, n * B, replace = TRUE)

#resamples <- matrix(sampl, B, n)
# B x n: 50 values with 1000 cases
resamples <- matrix(sampl, n)

# (1) With Median
medians <- apply(resamples, 1,  median)
sd(medians)
quantile(medians, c(.025, .975))

dat_med <- data.frame(x = medians)
g <- ggplot(dat_med, aes(x = x)) + 
  geom_histogram(binwidth=.2, colour = "black", fill = "blue", aes(y = ..density..)) 
print(g)

## (2) with Mean
means1 <- apply(resamples, 1, mean)
#means1 <- apply(matrix(sampl, n), 1, mean)
sd(means1)
quantile(means1, c(.025, .975))

dat <- data.frame(x = means1)
#dat <- data.frame(x = apply(matrix(sampl, n), 1, mean))
# Theoretically, the average is 3.5. 
g2 <- ggplot(dat, aes(x = x)) + 
  geom_histogram(binwidth=.2, colour = "black", fill = "salmon", aes(y = ..density..)) 
print(g2)

# (3) With Boot median
library(boot)
stat <- function(x, i) {median(x[i])}
# bootstrapping with n replications
boot.out <- boot(data = 1:6,
                 statistic = stat,
                 R = n)
boot.ci(boot.out)

# view results
boot.out 
plot(boot.out)



