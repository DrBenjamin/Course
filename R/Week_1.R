# Intermediate R Programming for Data Science 
# Week 1 
library(tidyverse)

my_function <- function(arg1, arg2) {
  result <- arg1 + arg2
  return(result)
}

my_func <- function(arg1, arg2) {
  arg1 + arg2
}

my_function(1, 2)
my_func(1, 2)


is_even <- function(number) {
  if (number %% 2 == 0) {
    return(TRUE)
  } else {
    return(FALSE)
  }
}

is_even(2)
is_even(3)

library(lubridate)

get_ages <- function(birth_dates) {
  print(birth_dates)
  for (birth_date in birth_dates) {
    age <- time_length(interval(ymd(birth_date), now()), unit = "years")
    print(floor(age))
  }
}


birth_dates <- c("1979-07-02", "1991-10-20")
get_ages(birth_dates)

minors <- sample(1:17, size = 20, replace = TRUE)
adults <- sample(18:64, size = 50, replace = TRUE)
seniors <- sample(65:99, size = 30, replace = TRUE)

age_vector <- c(minors, adults, seniors)

generate_age_vector <- function(n_minors, n_adults, n_seniors) {
  minors <- sample(1:17, size = n_minors, replace = TRUE)
  adults <- sample(18:64, size = n_adults, replace = TRUE)
  seniors <- sample(65:99, size = n_seniors, replace = TRUE)
  age_vector <- c(minors, adults, seniors)
  return(age_vector)
}
generate_age_vector(20, 50, 30)
