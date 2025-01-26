library(testthat)
source(file.path(getwd(), "/R/square.R"))

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
