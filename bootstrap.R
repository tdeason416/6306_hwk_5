#examples of using the function sample

rm( list = ls()); cat("\014")  # Clear environment

#permutation of seq 1-10
sample(10)

#resample from seq 1-10
sample(10, replace=T)

#resampling from 1-10 
#probabilities favor numbers 1-5
prob1 <- c(rep(.15, 5), rep(.05, 5))
prob1
sample(10, replace=T, prob=prob1)

#sample of size 5 from elements of a matrix 
y1 <- matrix( round(rnorm(25,5)), ncol=5)
y1

x1 <- y1[sample(25, 5)]
x1

#sampling the rows of the a matrix
y2 <- matrix( round(rnorm(40, 5)), ncol=5)
y2

x2 <- y2[sample(8, 3), ]
x2

#bootstrap the standard error of the median
data <- round(rnorm(100, 5, 5))
data[1:10]

?lapply

# TODO 1: Complete the second parameter of lapply function with
# function(i) 
#   that adopts "sample" function with the first parameter "data", the second parameter "replace=T"
#   HINT: function lappy of the function(data, num) in the below
data.boots <- function(num, data){
  return(sample(data, num, replace= TRUE))
}

resamples <- lapply(rep(10, 20), data.boots, data)
resamples[1]
r.median <- sapply(resamples, median)
r.median
sqrt(var(r.median))
# windows(5,5)
# TODO 2: Take a screenshot of the following histogram
hist(r.median)

# function which will bootstrap the standard error of the median
b.median <- function(data, num){
   resamples <- lapply(rep(length(data), num), data.boots, data)
   r.median <- sapply(resamples, median)
   std.err <- sqrt(var(r.median))
   list(std.err=std.err, resamples=resamples, medians=r.median)   
}

data1 <- round(rnorm(100, 5, 5))
b1 <- b.median(data1, 30)
b1$resamples[1]
b1$std.err
# windows(5,5)
hist(b1$medians)

b.median(rnorm(100, 5, 2), 50)$std.err

#making the function more general
#can use any summary statistic not just median
    # TODO 3: refer to b.mean to complete the following lapply function
    #    the first paramer is 20 elements and the second paramete is fuction with sample function 
    #     with the first parameter as data and the second parameter as replace=T
b.stat <- function(data, num, stat) {
    resamples <- lapply(rep(length(data), num), data.boots, data)
    r.stat <- sapply(resamples, stat)
    std.err <- sqrt(var(r.stat))
    list(std.err=std.err, resamples=resamples, stats=r.stat)   
  }
    
b.stat(rnorm(100, 5, 2), 50, var)$std.err
# windows(5,5)
# TODO 4: Take a screenshot of the following histogram
hist(b.stat(rnorm(100, 5, 2), 50, var)$stats)

