setwd("C:/Rstudio/stats")

# Lists'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
# create data
student <- "lola"
scores <- c(first_test = 26, second_test = 29, third_test = 25, fourth_test = 30)
is_enrolled <- FALSE

# create a list containing this data
my_list <- list(student = student, scores = scores, enrollment = is_enrolled)

# ways to extract components
my_list[[1]]
my_list[["student"]]
my_list$student

# to extract parts of a component
my_list[[2]][1]
my_list[[c(2, 1)]]
my_list[["scores"]]["first_test"]

# this extracts a list with the component we indexed
my_list[1]
my_list[1:2]

# get a view of the list structure
str(my_list)

# modify an element in a list
my_list[[2]][1] <- 27

# add a new component to a list
my_list[["course"]] <- "GCE"
my_list$internship <- FALSE

# check list length: 5 components
length(my_list)

# if you add a component to a new, detached index, R fills in the empty index places inbetween with NULLs
my_list[[8]] <- "B2"

# change the names of a component
names(my_list)[8] <- "english certification"

# remove components 
my_list[[6]] <- NULL # by assigning it NULL (in this case it already contains NULL, as it doesn't have any data)
my_list[-6]

# append lists
list1 <- list(a1 = 1:10, b1 = LETTERS[1:3]) # first create data
list2 <- list(a2 = c(2.2, 3.1), b2 = c(FALSE, TRUE))

# now add them togehter using ~c, they all get joined at the same level one after the other, you can even specify their names
c(list1 = list1, list2 = list2)

# or use ~list, this time a nested structure is created
list(list = list1, list2 = list2) 
str(list(list1 = list1, list2 = list2)) # shows this is just a list of two, both in turn being another list of two


# Dataframes''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
# create dataframe
dat <- data.frame(a = 1:10, b = letters[1:10], c = rep(c(FALSE, TRUE), 5))
# when no rownames are provided they will be filled by integers starting from 1 to N (N being the total number of observations)

# get information about the dataframe
nrow(dat) # 10 observations
ncol(dat) # 3 variables/components
dim(dat) # 10 3 dimensions (nr of rows and nr of columns)

# add names to the variables
names(dat) <- c("col1", "col2", "col3")

# access elements inside the dataframe
dat[1, ] # extracts the first row
class(dat[1, ]) # gives the class of the first row: data.frame
dat[, 2] # extracts the first variable/vector
class(dat[, 2]) # "character"
dat[, 2:3] # gives whole 2nd and 3rd column
dat[1,3] # 1st row, 3rd column
dat[1:2, 2:3] # this output gives a another data.frame not a vector
dat[[2]] # 2nd column, obtain a vector
dat[["col2"]]
dat[, "col2"]
dat$col2
dat$col1 < 6 # gives us TRUE or FALSE for each observation in column 1
dat[dat$col1 < 6, ] # works as a condition to extract rows additionally: only observations that satisfy this condition will be in the output in form of a data.frame
dat[dat$col3 == FALSE, ] # only extracts rows that contain false in column 3

# assign a new variable in a dataframe
dat$col4 <- LETTERS[1:10]

# modify an element in a dataframe
dat[1, 1] <- 1.4

# remove column from a dataframe
dat$col4 <- NULL
dat <- dat[, -3] # you need to assign it to store the change

# combine dataframes, bind rows using ~nrow()
dat_1 <- data.frame(genus = c("Silene", "Pinus"), has_flower = c(TRUE, FALSE), n = c(10, 2))
dat_2 <- data.frame(genus = "Malus", has_flower = TRUE, n = 1)
dat_3 <- rbind(dat_1, dat_2)

# add new column
is_herbaceous <- c(TRUE, FALSE, FALSE)
dat_4 <- cbind(dat_3, is_herbaceous)

