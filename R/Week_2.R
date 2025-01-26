# Intermediate R Programming for Data Science
# Week 2
#View(here::here("figures", "image-W2-Topic3.png"))

## Reprex
library(reprex)
library(tidyverse)
library(here)

# Explicit for loop
for (idx in 1:5) {
  cat(sum(iris[idx]), "\n")
}

count_rows <- function(x) cat(sum(iris[x]), "\n")
# Sort of "hidden" loop
walk(1:4, ~ count_rows(.x))

# Actually ectoized function
colSums(iris[-5])

# Use Add-ins in Rstudio
# to use reprex


## Sourcing code
source(here("Week_2_sourced_file.R"))
sourced_func(4)


## Documentation
?if_else # vectorised if-else from dplyr
?ifelse # base package

# Help
help("ifelse") # help
?ifelse # help

# Under the hood
View(if_else)
if_else # run or press F2 with the mouse cursor over it

# Vignettes
browseVignettes()
vignette("rectangle", package = "tidyr")


## Debugging
# Line by line debugging
# just highlight section

# Interactive debugger
# add `browser()` to a function
# or set a red dot next to the line number in the editor window
# commands:
ls() # showing all variables / objects
ls.str() # exploring all variables / objects
# Usage of `print()`

# Sprinkle `str()`
mtcars %>%
  str()

# Usage of `traceback()`
f <- function(x) {
  x + 1
}

g <- function(x) f(x)

g(1)
g("a")
traceback()

sourced_func(2)
sourced_func("a")
traceback()
