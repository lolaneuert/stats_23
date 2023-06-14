setwd("C:/RStudio/stats")

#### working with functions to reduce code length and increase readability
greet <- function() {
  print("Hi")
}
# this runs the function, as there are no arguments to be specified, the brackets stay empty
greet()

# to create a personalized greeting, define the argument as name and use function ~paste to join strings of code
greet_me <- function(name) {
  print(paste("Hi ", name, "!", sep = ""))
}
greet_me("Lola")

# create a function that calculates the mean of an argument, use ~return to clearly show the output
example_mean <- function(nums) {
  sum_nums <- sum(nums)
  length_nums <- length(nums)
  return(sum_nums / length_nums)
}

example_mean(1:50)
# you can use the "magic wand" above to turn a code chunk into a function, by marking it first
# objects defined inside a function are not saved in the global environment, but within the nested environment of the function

# create function with multiple arguments
remainder <- function(dividend, divisor) {
  whole <- floor(dividend / divisor)
  rem <- dividend - (whole * divisor)
  return(rem)
}
# this function gives the rest after the division of whole numbers
remainder(7, 4)

# uses a fixed divisor if no second argument is defined
remainder2 <- function(dividend, divisor = 2) {
  whole <- floor(dividend / divisor)
  rem <- dividend - (whole * divisor)
  return(rem)
}

remainder2(5)
remainder(dividend = 5, divisor = 3)
remainder(divisor = 3, dividend = 5)
remainder(3, dividend = 5)

whole <- function(dividend, divisor) {
  whl <- floor(dividend / divisor)
  return(whl)
}

# nestled functions
whole_and_remainder <- function(dividend, divisor) {
  whl <- whole(dividend = dividend, divisor = divisor)
  rem <- remainder(dividend = dividend, divisor = divisor)
  return(c(whl, rem))
}

whole_and_remainder(7,4)


#### missing data: 
NA # not available, vector of length 1
is.na(NA) # TRUE
is.na(c(1, NA)) # FALSE TRUE
typeof(NA) # "logical"
typeof(c(1L, NA)) # integer
typeof(c(1, NA)) # double
typeof(c("Hi", NA)) # character
# type is changed due to coercion, if NA is by itself it is a logical value (logical has least priority, can be converted into any other type)

typeof(NA_integer_) # integer
typeof(NA_real_) # double
typeof(NA_character_) # character

sum(c(1:10, NA)) # NA: is said to be contagious, just one NA can influence the whole list of x numbers
# R doesn't guess value of NA or remove it by default: you need to to it purposefully, explicitly
sum(c(1:10, NA), na.rm = TRUE) # 55: should R remove the NA before processing the function? default is FALSE

summary(c(1:10, NA, NA)) 
#   Min. 1st Qu.  Median    Mean 3rd Qu.    Max.    NA's 
#   1.00    3.25    5.50    5.50    7.75   10.00       2

library(tidyverse)
library(palmerpenguins)

data("penguins")
penguins
summary(penguins) # 2 individuals seem not to have specified body measurements, 11 seem to miss information on sex

# how to deal with missing values? typically remove whole row, especially if many NAs, or even column
# or we can convert NA to a guessed value: missing value computation (big topic), often median/mean/mode or much more complex

# either remove specific row, or use function ~na.omit() or ~drop_na() (from tidyverse package) to find NAs and remove those rows
na.omit(penguins)
drop_na(penguins, body_mass_g) # more flexible, columns can be specified in which R should look for NAs, so only rows are removed in which there are NAs in body mass

penguins %>%
  filter(!is.na(body_mass_g)) # this is another option to filter out NAs
