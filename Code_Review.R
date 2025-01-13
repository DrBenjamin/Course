# Code Review

# Code to review
leap_year <- function(year){
  if(year %% 400 == 0){
    if(year %% 100 == 0){
      return(T)
    } else{
      if (years %% 4 == 0){
        return(T)
      } else{
        return(F)
      }
      return(F)
    }
  }
}
print(leap_year(1979))
print(leap_year(1980))
print(leap_year(1981))

# Corrected code to
leap_year_corrected <- function(year) {
  (year %% 4 == 0 && year != 100) || (year %% 400 == 0)
}
print(leap_year_corrected(1979))
print(leap_year_corrected(1980))
print(leap_year_corrected(1981))
print(leap_year_corrected(1982))
print(leap_year_corrected(1983))
print(leap_year_corrected(1984))
