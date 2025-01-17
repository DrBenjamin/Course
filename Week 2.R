# Intermediate R Programming for Data Science 
# Week 2
here::here('figures', 'image-W2-Topic3.png')

# Reprex
library(reprex)
library(tidyverse)

# Explicit for loop
for (idx in 1:5) {
  cat(sum(iris[idx]), '\n')
}

count_rows <- function(x) cat(sum(iris[x]), '\n')
# Sort of "hidden" loop
walk(1:4, ~count_rows(.x) )

# Actually ectoized function
colSums(iris[-5])
