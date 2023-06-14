# set a working directory using function ~setwd() for R to save all documents, files, objects etc in: in this case it is in the folder stats (see path below)
setwd("C:/RStudio/stats")

# data types````````````````````````````````````````````````````````````````````
# in R there are 4 data types: logical values (true, false), numerical values (integer, real), characters("a", "B" etc))

# logical values
TRUE # or just T (becomes 1: presence)
typeof(TRUE) # = "logical", function ~typeof() gives you the data type of the data in the brackets as output = "integer" etc.
FALSE # or just F (becomes 0: absence of a certain characteristic for ex.)

# integer numbers (whole numbers, no specification after the decimal separator)
1L # R needs you to specify that it is an integer by adding an upper case L directly behind the number, meaning there will be nothing behind the separator
typeof(1L) # = "integer" 

# numeric (not everyone agrees on the definition of numeric)
3.14
typeof(3.14) # = "double" (means double precision: specification on left and right side of the value)

# characters (all values between quotes)
"hello"
"a"
"whateveryouwant"
"even a whole book"
typeof("even a whole book") # = "character"

######## he said hitting not eating so what have you been hitting this morning gets a whole lot more innuendo

?typeof # access documentation of a function in help by adding ? in  front

# to combine different character variables use function ~paste() to concatenate strings
first_word <- "Bellis" # <- assignment operator
(second_word <- "perennis") # assigns using <-, but () also run it

paste(first_word, second_word) # concatenate strings
species_name <- paste(first_word, second_word) # store it by giving it a name (rather random names here)
full_name <- paste(species_name, "L.") # you can also specify elements inside the function, just insert it with quotes

# packages `````````````````````````````````````````````````````````````````````

install.packages("palmerpenguins") # penguin data
library(palmerpenguins)

dplyr::select() # function ~select() is part of the dplyr package (top down approach in specifying the function, as part of a package)
raster::select() # but also part of raster package; the double :: allows you to specify from which packages you want to use the function
