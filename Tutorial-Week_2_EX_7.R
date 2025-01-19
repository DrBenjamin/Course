

library(purrr)
library(dplyr)


fruits_num <- tibble(
  # create days of the week
  # if you are not sure what the arguments to ISOdate() are, look up the documentation!
  days = weekdays(ISOdate(1, 1, 1:7)),
  apples = c(1, 2, 4, 6, 2, 1, 8),
  bananas = c(6, 5, 3, 2, 1, 9, 4)
)

# Creating a new column in `fruits_num` called `total_fruit`
# which is the sum of each row in columns `apples` and `bananas`

fruits_num |>
  mutate(total_fruit = map2_dbl(.x = apples,
                                .y = bananas,
                                .f = \(x, y) x + y))


##### ----------------------- REPREX ##### -----------------------

## Can be created with Addin or with reprex::reprex(session_info = TRUE)

library(purrr)
library(dplyr)
#>
#> Attaching package: 'dplyr'
#> The following objects are masked from 'package:stats':
#>
#>     filter, lag
#> The following objects are masked from 'package:base':
#>
#>     intersect, setdiff, setequal, union



fruits_num <- tibble(
  # create days of the week
  # if you are not sure what the arguments to ISOdate() are, look up the documentation!
  days = weekdays(ISOdate(1, 1, 1:7)),
  apples = c(1, 2, 4, 6, 2, 1, 8),
  bananas = c(6, 5, 3, 2, 1, 9, 4)
)

# Creating a new column in `fruits_num` called `total_fruit`
# which is the sum of each row in columns `apples` and `bananas`

fruits_num |>
  mutate(total_fruit = map2_dbl(.x = apples,
                                .y = bananas,
                                .f = \(x, y) x + y))
#> # A tibble: 7 × 4
#>   days      apples bananas total_fruit
#>   <chr>      <dbl>   <dbl>       <dbl>
#> 1 Monday         1       6           7
#> 2 Tuesday        2       5           7
#> 3 Wednesday      4       3           7
#> 4 Thursday       6       2           8
#> 5 Friday         2       1           3
#> 6 Saturday       1       9          10
#> 7 Sunday         8       4          12


sessioninfo::session_info()
#> ─ Session info ───────────────────────────────────────────────────────────────
#>  setting  value
#>  version  R version 4.4.1 (2024-06-14 ucrt)
#>  os       Windows 11 x64 (build 22631)
#>  system   x86_64, mingw32
#>  ui       RTerm
#>  language (EN)
#>  collate  English_United Kingdom.utf8
#>  ctype    English_United Kingdom.utf8
#>  tz       Europe/London
#>  date     2025-01-14
#>  pandoc   3.1.11 @ C:/Program Files/RStudio/resources/app/bin/quarto/bin/tools/ (via rmarkdown)
#>
#> ─ Packages ───────────────────────────────────────────────────────────────────
#>  package     * version date (UTC) lib source
#>  cli           3.6.3   2024-06-21 [1] CRAN (R 4.4.1)
#>  digest        0.6.36  2024-06-23 [1] CRAN (R 4.4.1)
#>  dplyr       * 1.1.4   2023-11-17 [1] CRAN (R 4.4.1)
#>  evaluate      0.24.0  2024-06-10 [1] CRAN (R 4.4.1)
#>  fansi         1.0.6   2023-12-08 [1] CRAN (R 4.4.1)
#>  fastmap       1.2.0   2024-05-15 [1] CRAN (R 4.4.1)
#>  fs            1.6.4   2024-04-25 [1] CRAN (R 4.4.1)
#>  generics      0.1.3   2022-07-05 [1] CRAN (R 4.4.1)
#>  glue          1.7.0   2024-01-09 [1] CRAN (R 4.4.1)
#>  htmltools     0.5.8.1 2024-04-04 [1] CRAN (R 4.4.1)
#>  knitr         1.47    2024-05-29 [1] CRAN (R 4.4.1)
#>  lifecycle     1.0.4   2023-11-07 [1] CRAN (R 4.4.1)
#>  magrittr      2.0.3   2022-03-30 [1] CRAN (R 4.4.1)
#>  pillar        1.9.0   2023-03-22 [1] CRAN (R 4.4.1)
#>  pkgconfig     2.0.3   2019-09-22 [1] CRAN (R 4.4.1)
#>  purrr       * 1.0.2   2023-08-10 [1] CRAN (R 4.4.1)
#>  R.cache       0.16.0  2022-07-21 [1] CRAN (R 4.4.1)
#>  R.methodsS3   1.8.2   2022-06-13 [1] CRAN (R 4.4.0)
#>  R.oo          1.26.0  2024-01-24 [1] CRAN (R 4.4.0)
#>  R.utils       2.12.3  2023-11-18 [1] CRAN (R 4.4.1)
#>  R6            2.5.1   2021-08-19 [1] CRAN (R 4.4.1)
#>  reprex        2.1.0   2024-01-11 [1] CRAN (R 4.4.1)
#>  rlang         1.1.4   2024-06-04 [1] CRAN (R 4.4.1)
#>  rmarkdown     2.27    2024-05-17 [1] CRAN (R 4.4.1)
#>  rstudioapi    0.16.0  2024-03-24 [1] CRAN (R 4.4.1)
#>  sessioninfo   1.2.2   2021-12-06 [1] CRAN (R 4.4.1)
#>  styler        1.10.3  2024-04-07 [1] CRAN (R 4.4.1)
#>  tibble        3.2.1   2023-03-20 [1] CRAN (R 4.4.1)
#>  tidyselect    1.2.1   2024-03-11 [1] CRAN (R 4.4.1)
#>  utf8          1.2.4   2023-10-22 [1] CRAN (R 4.4.1)
#>  vctrs         0.6.5   2023-12-01 [1] CRAN (R 4.4.1)
#>  withr         3.0.0   2024-01-16 [1] CRAN (R 4.4.1)
#>  xfun          0.45    2024-06-16 [1] CRAN (R 4.4.1)
#>  yaml          2.3.8   2023-12-11 [1] CRAN (R 4.4.0)
#>
#>  [1] C:/ProgramData/R441/library
#>  [2] C:/Program Files/R441/library
#>
#> ──────────────────────────────────────────────────────────────────────────────
