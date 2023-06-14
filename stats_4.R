setwd("C:/Rstudio/stats")

# indexing vectors
my_integer <- 6:10 # want to store the length of this vector
my_int_l <- length(my_integer) # 5L
# since the length of a vector corresponds to the index of the last element in the vector we can use this variable to select the last number in the vector
my_integer[my_int_l] # 10

my_int_l - 2 # gives third to last value of this variable: 3
my_integer[(my_int_l - 2):my_int_l] # 8 9 10 this extracts the last three elements of the sequence


# modify vectors
# for this we use index and assignment operators
work_days <- c("monday", "tuesday", "wednesday", "thursday", "sunday") # there is a mistake in this vector: we want to change it
# access the fifth element by indexing
work_days[5] <- "friday" # to overwrite the 5th element

# to modify multiple vectors at a time
scores <- c("good", "good", "n.c.", "n.c.", "excellent") # we need to change the name of n.c. to insufficient
scores[3:4] <- "insufficient" # index it by using [:]

scores2 <- c("good", "good", "n.c.", "n.c.", "excellent")
scores_to_fix <- c(F, F, T, T, F) # index by using logical function
scores2[scores_to_fix] <- "insufficient"

# append values to a vector (add to end)
my_integer <- 1:5 # we want it to continue until 10
my_integer <- c(my_integer, 6:10) # assign it to the name if you want it to be stored
my_integer2 <- 11:15
c(my_integer, my_integer2) #  1  2  3  4  5  6  7  8  9 10 11 12 13 14 15

# remove values from a vector
my_integer <- my_integer[-1] # this gives  2  3  4  5  6  7  8  9 10, by subtracting the value at index 1 and overwrite the old vector
my_integer[-(3:7)] #  1  2  8  9 10
my_integer[-c(3, 5, 9)] # 2 3 5 7 8 9

# operations with vectors
vec1 <- 0:2
vec2 <- 3:5
vec1 + vec2 # 3 5 7 : because 0+3 = 3, 1+4 = , 2+5 = 7 so the operations get carried out element wise because we use vectors of equal length
vec1 * vec2 # 0 4 10
vec1 - vec2 # -3 -3 -3
vec1 / vec2 # 0.00 0.25 0.40

vec1 * 5 # 0 5 10 this is a scalar operation

vec3 <- 1:2 # using vectors of differing length the operation is cycled in the longer one
vec1 + vec3 # 1 3 3

# vector names
plant_div <- c("Rosaceae" = 45L, "Fabaceae" = 30L, "Poaceae" = 56L) # stores values with names above -> metadata
plant_div["Rosaceae"] # these names can also be used to access values
plant_div[c("Rosaceae", "Poaceae")]
names(plant_div) # this function will give the vector names as a character vector output

# now to change one name inside the vector: index and assign
names(plant_div)[2] <- "Leguminosae"

# remove the names from a vector
names(plant_div) <- NULL # NULL represents an empty set/list/vector: it therefore replaces the names with an empty vector

# type coercion
c("hello", 3) # as types cannot mix: R has to modify this for us by adding quotes to 3: type coercion into character
c(F, 3L) # here the logical operator F=0
c(T, 3.14) # 1.00 3.14 because T=1
c(T, "hello") # "TRUE"  "hello"
c(3.14, 2L) # 3.14 2.00
c("hello", T, 3.14)# "hello" "TRUE"  "3.14"
# what is the prioritization: all types can become characters: this is the most general, then numbers, then logical operators


# family of functions to change data types as.*()
# ~as.integer() is a function to explicitly change the type of your data into integer
as.integer(c(TRUE, FALSE)) # 1 0
# the same goes for ~as.numeric, but better not to use, because ambiguous type, instead use
as.double(c(TRUE, FALSE)) # 1 0 
as.character(c(TRUE, FALSE)) # "TRUE"  "FALSE"
as.logical(c(0, 1, 2)) # FALSE  TRUE  TRUE: why does 2 turn into true? everything except 0 turns TRUE
as.logical(c(-1, 0, 1, 2.15)) # TRUE FALSE  TRUE  TRUE
as.logical(c("hello", "hi", "ciao")) # NA NA NA: not applicable/available: missing values: we cannot transform these character values into logical values
as.numeric(c("1", "hello", "3.14")) # 1.00   NA 3.14 because hello cannot be coerced into a numeric value
as.integer(c("1", "hello", "3.14")) # 1 NA 3: here R is flooring, meaning it removes everything after the decimal operator, not rounding
as.logical(c("1", "hello", "3.14")) # NA NA NA: R cannot transform numbers into logical values

# family of functions to question/recognize data types is.*()
is.logical(c(TRUE, FALSE)) # TRUE
is.logical(c(1, 3)) # FALSE
is.integer(c(1L, 3L)) # TRUE
is.double(c(1L, 3L)) # FALSE
is.numeric(c(1L, 3L)) # TRUE here again the discrepancy between double and numeric datatypes can be seen: this results from Rs origin from S, to keep consistent this wasn't changed
# in some cases numeric means real numbers(for us), in other cases it means real and numeric numbers, therefore we use double to have less bias
is.character("hello") # TRUE

# assignments
vec1 <- seq(5, -10, length.out = 1000) # create a vector of 1000 elements, evenly spaced between 5 and -10
length(vec1) == 1000 # this gives TRUE as the vec1 is 1000 elements long
vec2 <- vec1[-((length(vec1) - 9):length(vec1))] # creates a new vector with the same values, but subtracting the last 10 elements
length(vec2) == (length(vec1) - 10) # TRUE check if vec2 has length vec1-10
paste0(LETTERS[1:10], 1:10) # gives A1, B2, etc. the function ~paste() has a blank space as a default value to separate (would give A 1, B 2, etc), paste0() doesn't have any space as a separator
vec3 <- c("hi", 300)
vec3 # "hi"  "300" R coerces the datatype of the number to become a character string
