setwd("C:/RStudio/stats")

# simple mathematical expressions
1 + 2
4 - 2
3 * 4
2 / 1
2 ^ 2

# simple logical expressions: relations between two objects
1 < 2  # gives TRUE as 1 is actually smaller than 2
3 > 5  # FALSE
2 <= 2 # smaller than or equal: TRUE
2 >= 3 # FALSE
2 == 2 # identity operation equal to: TRUE, we need to use two "equal signs" as the = is also used as an assignment operator like <-
2 != 2 # negation of identity operation not equal to: FALSE

a = 2
b = 3
a > b  # FALSE
"a" < "b" # TRUE as are counts characters in alphabetical order, therefore a smaller than b

a <- "tree"
a == "tree" # TRUE
a != "tree" # FALSE

# logical operators: combine multiple operators

c <- 1
d <- 3

# && is the and operator: the expression is logically only true if both are TRUE
c < 3 && d < 4 # TRUE
c > 3 && d < 4 # FALSE

# || is the or operator: union operation, if one of them or both are true the result will be TRUE, both terms must be false for it to be evaluated FALSE
a > 3 || b < 4 # TRUE 

# ! is the not/negation operator: this gives the opposite value of each operation
!FALSE # TRUE
!(a > 3 || b < 4) # FALSE, as it negates a true expression

# use parenthesis to change priorities in calculations
(1 + 2) * 3 # 9
(1 + 2) * 3 < c # FALSE
(1 + 2) * 3 < c || b > 2 ** 3 / 2 # FALSE: exponentiation has priority, then division/multiplication, then relational operators: smaller/greater than? and last logical operator: is one of the two true?


# operator priority: parentheses, exponentiation, division and multiplication, additions and subtraction, relational operators, logical operators

### Data structures: VECTORS
# in a vector we can not mix data types, there is just one dimension (matrices for ex. have 2 dim but also only same data type, lists have several dim and any data type and dataframes have 2 dim and any data type)

# options to specify vectors and create sequences

e <- 1:10 # the operator : gives you a vector/sequence, here with the integer numbers from 1 to 10, don't have to specify L because of : this produces integer
f <- 10:1
seq(from = 1, to = 25) # gives same result, more coding though but it allows you to create more complex sequences
seq(from = 1, to = 25, by = 2) # by is used to specify the step; 1 + 2 = 3 +2 = 5 etc here 10 is never reached as it isn't in the correct place
seq(from = 1, to = 25, by = 2.2) # 1.0  3.2  5.4  7.6  9.8 12.0 14.2 16.4 18.6 20.8 23.0
seq(from = 1, to = 25, length.out = 50)  # 50 numbers in between 1 and 25 evenly spaced 
rep(1, times = 5) # creates a vector of 5 times 1
rep(1:5, times = 5) # repetition of sequence: 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5 1 2 3 4 5
rep(1:5, each = 5) # 1 1 1 1 1 2 2 2 2 2 3 3 3 3 3 4 4 4 4 4 5 5 5 5 5
rep("a", times = 5)

# concatenate function ~c() to connect from 0 to billions of elements
g <- c(TRUE, FALSE, TRUE) # logical vector
h <- c(1L, 10L, 15L) # integer vector
i <- c(1, 10.74, 12.34) # double vector
j <- c("plant", "bird", "mammal")

is_native <- c(TRUE, FALSE, TRUE)
n_ind <- c(10L, 7L, 5L)
taxa_age <- c(2.11, 10.5, 68.9)
taxa <- c("plant", "bird", "mammal")
data <- data.frame(is_native, n_ind, taxa_age, taxa) # even though we could store all our data in vectors, it is easier to add them together in a data frame that can contain more datatypes

# as vectors have only one dimension they can be measured simply by their length
length(taxa) # 3: simply counts objects, discrete elements, therefore integer data
typeof(n_ind) # gives you data type of a vector how it is saved in R
class(n_ind) # here ~class() and ~typeof() result in the same answer, this isn't always the case: class gives a larger/generalist overview
typeof(taxa_age) # double
class(taxa_age) # numeric: the two are more or less the same for us

# to access a vector
taxa

# but if we only want to look at certain elements we need to specify this by its element index
k <- 6:10
k[2] # 7: gives us only the element at index place 2
k[2:4] # 7 8 9 
k[c(1, 2, 4)] # 6 7 9

# use one vector to extract elements in another
l <- c(T, F, T, F, T)
k[l] # 6 8 10: extracts the values from k that correspond to the true indices in vector l
# if the two vectors do not have the same length R uses recycling: it cycles the shorter vector once it is done as many times at it fits in the longer vector
m <- c(F, T)
k[m] # 7 9 

