# Week 4
library(stringr)
library(dplyr)
library(purrr)
library(here)

?str_detect()
?str_extract
?str_replace()
?str_sub()

sentences <- sentences[1:6] # sentences is an object included in `{stringr}`
print(sentences)
str_detect(
  string = sentences,
  pattern = "owl"
) # only one string contains "owl"

str_subset(
  string = sentences,
  pattern = "owl"
)

# Extracting substrings
str_extract(
  string = sentences,
  pattern = "the"
)


patterns <- str_extract_all(
  string = sentences,
  pattern = "the"
)
map(patterns, ~ length(.x))

# Removing string matches
str_remove(sentences, "[Tt]he")
str_remove_all(sentences, "[Tt]he")

# Case sensitivity
str_detect(sentences, "The")
str_detect(sentences, "the")
str_detect(sentences, "[Tt]he") # character class

raindrops <- c("pling", "plAng", "plong", "plang")
str_detect(raindrops, "pl[Aiao]ng")
str_detect(raindrops, "(?i)pl[a-z]ng")
str_detect(raindrops, "pl.ng")

str_detect(sentences, "(?i)the") # case insensitive matching

# Alternatives
?str_split() # splits a string into several
?str_sub() # extracts a substring based on position
split_by_spaces <- str_split(sentences, " ")
split_by_spaces

map(split_by_spaces, 4) |>
  str_c(collapse = " ") # stringr equivalent of base::paste
map(split_by_spaces, ~ .x[[4]]) |>
  str_c(collapse = " ")

str_sub(sentences, start = 1L, end = -1L)
# 1L means the extraction starts from the first character of each string
# -1L means the extraction goes up to the last character of each string
str_sub(sentences, start = 5, end = 10)
str_sub(sentences, start = 5, end = -10)
str_sub(sentences, start = -5, end = -10)

# Meta-characters
vignette("regular-expressions", "stringr")
?stringr

# Some more realistic use cases
patient_info <- readRDS(here("data_raw", "patient_info_df.RDS"))
address_df <- patient_info %>%
  select(address)
address_df
address_vec <- patient_info$address
address_vec

?filter
address_df %>%
  filter(str_detect(address, "^8"))
address_df %>%
  filter(str_detect(address, "8$"))
address_df %>%
  filter(str_detect(address, "St,"))

address_df %>%
  filter(str_detect(address, "St, ")) %>%
  mutate(
    street_name1 = str_extract(address, pattern = "[A-Z][a-z][0-9]+ St"),
    street_name2 = str_extract(address, pattern = "[A-Z][a-z0-9]+ St"),
    street_name3 = str_extract(address, pattern = "[A-Z] ?[a-z0-9]+ St"),
    street_name4 = str_extract(address, pattern = "[A-Z ]*[a-z0-9]+ St")
  )

# Activity 1
# See if you can get the entire street name:
# Including "Fake"
# Excluding "Fake"
address_df %>%
  filter(str_detect(address, "St, ")) %>%
  mutate(
    without_fake = str_extract(address, pattern = "[A-Z ]*[a-z0-9]+ St"),
    with_fake = str_extract(address, pattern = " Fake [A-Za-z0-9 ]+ St"),
  )
# Activity 2
# Can we filter patient_info_df for sex == 'male' using regex?
# If so, how, if not, why?
patient_info %>%
  filter(str_detect(sex, "\\bmale\\b"))

# Activity 3
# Replace 'R' with 'tea'.
string <- "i Really love R. R is the best!"
# So the output should be 'i Really love tea. tea is the best!'
string %>%
  str_replace_all("\\bR\\b", "tea")

# Activity 4
# See if you can extract the two-letter US state-code from all the addresses.
# The first 6 results should be: "MD" "TN" "FL" "FL" "OH" "OR"
address_df %>%
  mutate(
    state_code = str_extract(address, pattern = "[A-Z][A-Z]")
  )


## Providing feedback to your users
find_square_root <- function(x) {
  if (!is.numeric(x)) {
    stop("Error: Input must be numeric.")
  } else if (x < 0) {
    warning("Taking the square root of a negative number is a bit weird.\n")
  } else {
    message("Processing your numeric input.")
  }
  sqrt(x)
}

# Running to see messages and outputs
result_pos <- find_square_root(64)
result_pos

result_neg <- find_square_root(-64)
result_neg

result_str <- find_square_root("64")
result_str

# More advanced data validation
library(assertr)
verify(mtcars, mpg > 0)
verify(mtcars, mpg < 0)

# Activity 1
generate_age_vector_validated <- function(n_minors, n_adults, n_seniors) {
  if (!is.numeric(n_minors) || !is.numeric(n_adults) || !is.numeric(n_seniors)) {
    stop("Error: figures must be positive integer.")
  } else if (n_minors < 0 || n_adults < 0 || n_seniors < 0) {
    n_minors <- abs(n_minors)
    n_adults <- abs(n_adults)
    n_seniors <- abs(n_seniors)
    warning("Warning: input argument(s) transformed to positive integer.")
  }
  minors <- sample(1:17, size = n_minors, replace = TRUE)
  adults <- sample(18:64, size = n_adults, replace = TRUE)
  seniors <- sample(65:99, size = n_seniors, replace = TRUE)
  age_vector <- c(minors, adults, seniors)
  return(age_vector)
}
generate_age_vector_validated("20", 50, 30)
generate_age_vector_validated(-20, 50, 30)

# Activity 2
mean(c(1, 2, NA, 3, 4))
mean_func <- function(x) {
  non_na <- map_lgl(x, ~ !is.na(.x))
  if (any(!non_na)) {
    warning("Removing ", sum(!non_na), " NAs")
  }
  mean(x[non_na], na.rm = FALSE)
}
mean_func(c(1, 2, NA, 3, 4))
mean_func(c(1, 2, NA, 3, 4, NA, NA))

# Activity 3
# My team is helping our customer to implement their HIS into a hospital.
# Without input validation, the patient records could even lead to system crashes.

# Activity 4
patient_record <- function(pat_firstname, pat_surname, pat_age, pat_address) {
  stopifnot(
    is.character(pat_firstname),
    is.character(pat_surname),
    is.numeric(pat_age),
    pat_age > 0,
    is.character(pat_address)
  )
  if (pat_age > 122) {
    warning("Age is quite high!")
  }
  return(
    data.frame(
      FirstName = pat_firstname,
      Surname = pat_surname,
      Age = pat_age,
      Address = pat_address,
      stringsAsFactors = FALSE
    )
  )
}
patient_record(
  "Ben",
  "Hogan",
  85,
  "2604 Washington Rd, Augusta, GA 30904, United States"
)
patient_record(
  "Ben",
  "Hogan",
  185,
  "2604 Washington Rd, Augusta, GA 30904, United States"
)
patient_record(
  1,
  "Hogan",
  85,
  "2604 Washington Rd, Augusta, GA 30904, United States"
)


## Ad-hoc testing to TDD
# First write tests
stopifnot(
  # add meaningful error message
  "Birth year is outside of 1924-2023 range" =
    # define range, you can do this in an object as well
    birthdate >= as.Date(1924 - 01 - 01),
  birthdate <= as.Date(2023 - 01 - 01) # nolint
) |>
  # add message in console that test passed
  cat("Test passed, birth year is within 1924-2023 range")

# Then write a function to pass it
get_birthyear <- function(age) {
  2024 - age
}

# Test your function against the test - create birthdate object
birthdate <- get_birthyear(104)
birthdate <- get_birthyear(56)

# Activity
stopifnot(
  "age at death is below 30 years" =
    calculated_age >= 30,
  "age at death is above 90 years" =
    calculated_age <= 90 # nolint
) |>
  # add message in console that test passed
  cat("Test passed, age is within 30-90 years range")

# Reading data from RDS
patient_data <- readRDS(here("data_raw", "patient_info_df.RDS"))

# Creating function
age_at_death <- function(birth_year, death_year) {
  as.numeric(death_year) - as.numeric(birth_year)
}

# Running function
calculated_ages <-
  map2_dbl(
    patient_data[["born"]],
    patient_data[["deceased"]], # nolint
    ~ age_at_death(.x, .y)
  )
calculated_ages

# Testing
calculated_age <- calculated_ages[1]
calculated_age <- 91
calculated_age <- 29


## `testthat` package
library(testthat)
library(usethis)

# Invoke the test_that function
test_that("addition works correctly", {
  expect_equal(2 + 2, 4)
})
# Create a new test file in `tests/testthat`
# Creating a R package (to run the tests)
create_package(".", open = FALSE)

# square.R
square <- function(x) {
  x^2
}

# Define tests
test_that("square() works correctly for positive numbers", {
  expect_equal(square(2), 4)
  expect_equal(square(3), 9)
})

test_that("square() works correctly for negative numbers", {
  expect_equal(square(-2), 4)
  expect_equal(square(-3), 9)
})

test_that("square() works correctly for zero", {
  expect_equal(square(0), 0)
})

test_that("square() throws an error given a string", {
  expect_error(square("a"), class = "simpleError")
})

test_dir("tests/testthat")
