n = 50 #nrow
B = 1000 #ncol

## our data
d = sample(1 : 6, n, replace = TRUE)

# g1 <- ggplot(as.data.frame(prop.table(table(d))), 
#             aes(x = d, y = Freq)) + geom_bar(colour = "black", fill = "lightblue", stat = "identity") 
tbl_d = table(d)
prop_table = prop.table(tbl_d)
# frequency of each side of the dice computed
as_data_frame = as.data.frame(prop_table)
g1 <- ggplot(as_data_frame, 
             aes(x = d, y = Freq)) + geom_bar(colour = "black", fill = "lightblue", stat = "identity") 
print(g1)

## bootstrap resamples
resamples = matrix(sample(d,
                          n * B,
                          replace = TRUE),
                   B, n)
resampledMeans = apply(resamples, 1, mean)

g2 <- ggplot(data.frame(d = resampledMeans), 
             aes(x = d)) + geom_histogram(binwidth=.2, colour = "black", fill = "salmon", aes(y = ..density..)) 
#grid.arrange(g1, g2, ncol = 2)
print(g2)

