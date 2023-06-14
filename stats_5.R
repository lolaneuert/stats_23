setwd("C:/Rstudio/stats")


# Matrices'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
vec1 <- 1:9
m <- matrix(vec1, nrow = 3) # use function ~matrix to create matrix, add data, specify the dimension using nrow, R will understand the number of columns
# to specify the place of an element, specify first the row, second the column [row, column]
class(m) # "matrix" "array"
typeof(m) # "integer"

n <- matrix(LETTERS[1:9], ncol = 3)
t(n) # transpose function: flip a matrix by its diagonal axis

o <- matrix(data = letters[1:9], ncol = 3, byrow = TRUE) # this filters it by rows instead of columns, because default value is set to byrows = FALSE

# create a matrix by defining rows first
first_row <- 1:5
sec_row <- 11:15
third_row <- 101:105
rbind(first_row, sec_row, third_row) # use function ~rbind() to bind the rows together in a matrix

# the same can be done for columns
first_col <- 1:5
sec_col <- 11:15
third_col <- 101:105
cbind(first_col, sec_col, third_col) # this binds columns together to a matrix

p <- matrix(1:6, ncol = 3)
dim(p) # 2 rows, 3 columns

# to specify the names of the matrixes rows and columns use the function ~rownames, and ~colnames
rownames(p) <- c ("r1", "r2") 
colnames(p) <- c("c1", "c2", "c3")
# to remove the names use the NULL
rownames(p) <- NULL

# indexing elements in a matrix
p[2, 3] # indexes the element at position row 2, column 3: 6

# to extract a whole row/column
p[1, ] # extracts the whole first row: 1 3 5
p[ , 3] # extracts only column 3: 5 6

# to access specific parts of a matrix
vec1[1:3]
p[, 2:3] 
p[, c(1, 3)]
p[, -2]

# the row and column names can be used to extract the data
p["r1", ] # 1 3 5
p[1, ] # same result using the index to access the first row
p["r1", c(1, 3)] # or mix names and indices: first row by name, column 1 and 3 by index

# Statistics with Matrices '''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
vec <- 1:9
vec
sum(vec) # 45

m <- matrix(vec, nrow = 3)
m
sum(m) # 45 because the same values

# community matrix
colnames(m) <- c("sp1", "sp2", "sp3")
rownames(m) <- c("cave1", "cave2", "cave3")
m

# now sum only the rows or only the columns or just one column for ex.
sum(m[, 1])
sum(m[2, ]) # using indices, but repetitive & errorprone when large dataset
colSums(m) # instead use function ~colSums which gives sum for each column
rowSums(m) # function ~rowSums gives sum for each row

# to find the mean of rows or columns
mean(vec) # gives mean of vector: 5
mean(m) # gives mean of matrix: also 5
colMeans(m) # gives mean of each column
rowMeans(m) # gives mean of each row

sd(m)
sd(m[1, ])

# summary function: can be used for a number of datatypes, also for a vector
summary(vec)
summary(m) # summary for species
t(m) # transform function to switch up rows and columns
summary(t(m)) # summary for sites

# Factors'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
# special integer vector with extra information: includes labels
vec <- c("Tree", "Grass", "Forb", "Grass", "Tree")
class(vec) # "character
fct <- factor(vec) # transform it into a factor: levels are forb, grass, tree: all possible categories
lev <- c("Tree", "Grass", "Forb", "Liana") # create new vector containing levels
fct <- factor(vec, levels = lev) # create factor, specifying the levels: there is the level liana, even though there is no data in this level
summary(fct) # gives absolute frequencies of elements per level

# mistakes
vec <- c("Tree", "Grass", "forb", "Grass", "Tree")
lev <- c("Tree", "Grass", "Forb", "Liana") # create new vector containing levels
fct <- factor(vec, levels = lev) # create factor, specifying the levels: there is the level liana, even though there is no data in this level
fct # Tree  Grass <NA>  Grass Tree: there are unaccounted for categories or errors in the data

# ordered factors
vec <- c("Low Temp", "High Temp", "Mid Temp", "Mid Temp", "Low Temp")
fct <- factor(vec)
# but if this is not enough: create intrinsic order, recognized by R
fct <- factor(vec, ordered = TRUE)
fct # Levels: High Temp < Low Temp < Mid Temp: this gives alphabetical order

# to have correctly encoded levels, specify the order
lev <- c("Low Temp", "Mid Temp", "High Temp")
fct <- factor(vec, levels = lev, ordered = TRUE)
fct # Low Temp < Mid Temp < High Temp
summary(fct)
levels(fct) # returns levels as characters

# Lists'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
# several dimensions, any data type: most powerful & flexible data type, they can contain: vectors, matrices, dataframes or lists (nestled lists)
# create some data
student <- "lola" # character value
scores <- c(27, 29, 25, 30) # vector of length 4
is_enrolled <- FALSE # logical vector

# create a list 
my_list <- list(student, scores, is_enrolled) # function ~list() works more or less like ~c()
my_list # contains all these different types, they are indexed as the list-components
class(my_list) # list
typeof(my_list) # list
str(my_list) # function ~str to investigate structure of my list (but also of other datatypes)
# List of 3
# $ : chr "lola"
# $ : num [1:4] 27 29 25 30
# $ : logi TRUE
length(my_list) # 3

# add names to list components
list_names <- c("student", "scores", "enrollment")
names(my_list) <- list_names
my_list # the $ is usable to access the different components of a list by name
str(my_list)

# other option to add names, same result
names(my_list) <- NULL # first clear previous names
my_list <- list(student = student, scores = scores, enrollment = is_enrolled)

# accessing the list elements through indices
my_list[1]
class(my_list[1])
str(my_list[1])

# to get the object within the component we need double square brackets
my_list[[1]]
class(my_list[[1]])
str(my_list[[1]])

my_list[["student"]]
str(my_list[["student"]])

# or as stated before use $ to index a component by its name
my_list$student

# double square brackets can only be used to extract *1* component, so we need to use ~c()
my_list[c(1,3)]
my_list[c("student", "enrollment")]

# new list
student <- "lola" # character value
scores <- c(first_test = 27, second_test = 29, third_test = 25, fourth_test = 30) # vector of length 4, with specified names
is_enrolled <- FALSE # logical vector

# create a list 
my_list <- list(student = student, scores = scores, enrollment = is_enrolled)# function ~list() works more or less like ~c()
str(my_list)
my_list[[c(2, 4)]] # this allows us to extract the 4th value in the 2nd component: so fourth_test result = 30
my_list[[c("scores", "fourth_test")]] # same result, allows us to access nested elements
my_list[[2]] # shows whole vector of scores
my_list[[2]][4] # this gives us fourth element of element 2
my_list[[2]]["fourth_test"] # same result
