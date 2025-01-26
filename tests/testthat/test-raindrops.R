library(testthat)
source(file.path(getwd(), "/R/raindrops.R"))

test_that("raindrops handles numbers divisible by 3", {
  expect_equal(raindrops(3), "Pling")
  expect_equal(raindrops(9), "Pling")
  expect_equal(raindrops(-3), "Pling")  # Negative divisible by 3
})

test_that("raindrops handles numbers divisible by 5", {
  expect_equal(raindrops(5), "Plang")
  expect_equal(raindrops(10), "Plang")
  expect_equal(raindrops(-5), "Plang")  # Negative divisible by 5
})

test_that("raindrops handles numbers divisible by 7", {
  expect_equal(raindrops(7), "Plong")
  expect_equal(raindrops(14), "Plong")
  expect_equal(raindrops(-7), "Plong")  # Negative divisible by 7
})

test_that("raindrops handles numbers divisible by 3 and 5", {
  expect_equal(raindrops(15), "PlingPlang")
  expect_equal(raindrops(-15), "PlingPlang")  # Negative divisible by 3 and 5
})

test_that("raindrops handles numbers divisible by 3 and 7", {
  expect_equal(raindrops(21), "PlingPlong")
  expect_equal(raindrops(-21), "PlingPlong")  # Negative divisible by 3 and 7
})

test_that("raindrops handles numbers divisible by 3, 5, and 7", {
  expect_equal(raindrops(105), "PlingPlangPlong")
  expect_equal(raindrops(-105), "PlingPlangPlong")  # Negative divisible by 3, 5, and 7
})

test_that("raindrops handles numbers not divisible by 3, 5, or 7", {
  expect_equal(raindrops(1), "1")
  expect_equal(raindrops(8), "8")
  expect_equal(raindrops(-1), "-1")  # Negative number not divisible
})

test_that("raindrops handles 0 correctly", {
  expect_error(raindrops(0), class = "simpleError")  # 0 Will throw a simpleError
})

# Edge cases
test_that("raindrops handles large numbers", {
  expect_equal(raindrops(105000000), "PlingPlangPlong")  # Divisible by 3, 5, and 7
})