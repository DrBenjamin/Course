# Week 3
install.packages("ckanr")
install.packages("httr2")

library(ckanr)
library(httr2)
library(dplyr)
library(purrr)
library(here)

# CKAN setup
nhs_url <- "https://www.opendata.nhs.scot/" # PHS datastore
?ckanr_setup
ckanr_setup(url = nhs_url)

# Getting a list of packages
full_package_list <- package_list()
head(full_package_list)

# Showing package as an R list
package_show("annual-hospital-beds-information")

annual_beds_info <- package_show("annual-hospital-beds-information",
  as = "table"
)
# Showing all data.frames in the list
annual_beds_info %>%
  map(class)

# Showing the number of rows and columns of each dataframe
dim(annual_beds_info$resources) # Three individual data resources
dim(annual_beds_info$tags) # 6 tags applied to dataset
dim(annual_beds_info$groups) # Dataset is a member of 6 groups
dim(annual_beds_info$extras)

# or
map(
  c("resources", "tags", "groups", "extras"),
  ~ dim(annual_beds_info[[.x]])
)
# or
annual_beds_info[c("resources", "tags", "groups", "extras")] %>%
  map(dim)

# Inspecting the resources dataframe
annual_beds_info[["resources"]]

# Searching CKAN resources
drug_search_list <- resource_search(q = "description:drug", as = "list")
drug_search_table <- resource_search(q = "description:drug", as = "table")

drug_search_list
drug_search_table

# Combining search terms
resource_search(
  q = c("name:council", "description:drug"),
  as = "table"
)$results

preg_search <- resource_search(
  q = "description:pregnan",
  as = "table"
)
matern_search <- resource_search(
  q = "description:matern",
  as = "table"
)
joined_search <- full_join(preg_search$results, matern_search$results)$url[[1]]
joined_search

# Using other search methods
?package_search()
?tag_list(as = "table")
?tag_search("day", as = "table")

# Downloading a dataset
infant_search <- resource_search("description:infant", as = "table")
infant_search$results[c("name", "description")]

# Setting url
infant_feedint_url <- infant_search$results$url[[1]]
head(ckan_fetch(infant_feedint_url))

# Fetching the data
ckan_fetch(infant_feedint_url,
  store = "disk",
  path = here("data_raw", "infant_feedint.csv")
)

# Questions
my_list <- readRDS(here("data_raw", "quick-quiz-list.RDS"))
str(my_list)

# Answers
# 1)
cat(
  my_list[["AAA"]][1],
  my_list[["BBB"]][[1]][2],
  my_list[["CCC"]][["C_c"]],
  my_list[["DDD"]][[1]][[1]][4],
  my_list[["DDD"]][["E"]][[1]][["D_E_j"]]
)

# 2)
my_list[["DDD"]][2]

# 3a)
my_list[["DDD"]][["E"]][[1]][["D_E_j"]]
# or
my_list[["DDD"]][["E"]][[1]]$D_E_j
# 3b)
my_list[["DDD"]][["E"]][[1]][5]

# 4)
# What is the difference between the following three lines of code?
# a)
my_list$CCC["C_a"]

# b)
my_list$CCC[["C_a"]]

# c)
my_list$CCC$C_a

# 5)
# When might you prefer each of the following?

# a)
my_list$CCC[["C_a"]]
# Not appropriate as it mixes to subsetting styles.

# b)
my_list[[3]]$C_a
# Appropriate, if the number would be a int variable.

# c)
x <- "CCC"
my_list[[x]]$C_a
# If I need the `x` variable (as a user choice) later again.

# 6)
your_list <- list(
  AAA = c(0:4),
  BBB = list(c(10:14)),
  CCC = list(
    C_a = as.integer(20),
    C_b = as.integer(21),
    C_c = as.integer(22),
    C_d = as.integer(23),
    C_e = as.integer(24)
  ),
  DDD = list(
    list(c(30:34)),
    E = list(
      list(
        D_E_f = as.integer(40),
        D_E_g = as.integer(41),
        D_E_h = as.integer(42),
        D_E_i = as.integer(43),
        D_E_j = as.integer(44)
      )
    )
  )
)
str(your_list)

# httr2
example_url <- "https://www.swapi.tech/api/people/1"
example_request <- request(example_url) |>
  req_headers(`Accept` = "application/json")
req_dry_run(example_request)
example_response <- req_perform(example_request)
example_response
resp_body_raw(example_response)
json_object <- resp_body_json(example_response)
str(json_object)

# Checking last response
last_response()

## FHIR
base_url <- "https://lforms-fhir.nlm.nih.gov"
path <- "baseR4"
resource <- "Patient" # Note the capital "P"
patient_id <- "pat-106"

# Building the request
req_p106 <- request(base_url) |>
  req_url_path_append(path, resource, patient_id) |>
  req_headers(`Accept` = "application/fhir+json") |>
  req_method("GET")

# Performing the request
resp_p106 <- req_perform(req_p106)
resp_status(resp_p106)
resp_p106

# Saving the response
saveRDS(resp_p106, here("data_raw", "resp_p106.RDS"))

# Loading the response
resp_p106 <- readRDS(here("data_raw", "resp_p106.RDS"))
body_json_not_simplified <- resp_body_json(resp_p106, SimplifyVector = FALSE)
body_json <- resp_body_json(resp_p106, SimplifyVector = TRUE)

# More useful search
library(httr2)

# I'm naming it "saved" here,
# so there is no confusion in out mind over what is a saved object,
# and what is a request.
# You can call it whatever you like
pat_106_saved <- readRDS(here("data_raw", "resp_p106.RDS"))

base_url <- "https://lforms-fhir.nlm.nih.gov"
path <- "baseR4"
resource <- "Patient"
given_name <- "Jian"
surname <- "McIntosh"

req_jian <- request(base_url) |>
  req_url_path_append(path, resource) |>
  req_url_query(`name:given` = given_name,
                `name:familiy` = surname) |>
  req_headers(Accept = "application/fhir+json")

req_dry_run(req_jian)
resp_jian <- req_perform(req_jian)
parsed_jian <- resp_body_json(resp_jian)

parsed_jian
