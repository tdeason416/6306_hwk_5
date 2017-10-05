# Put initialization code in this file.
# Install package ggplot2
# install.packages("ggplot2")
library(ggplot2)
data(InsectSprays)

getwd()
#fname <- paste(getwd(),"Statistical_Inference/Hypothesis_Testing/father_son.csv",sep="/")
setwd("G:\\onlineSchool\\SMU\\MSDS6306\\lectureNotes\\week5\\swirlInference")
fname <- "father_son.csv"
#fname <- pathtofile("father_son.csv")
fs <- read.csv(fname)
sh <- fs$sheight
fh <- fs$fheight
nh <- length(sh)
B <- 1000
