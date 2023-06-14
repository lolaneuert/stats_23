# set a working directory using function ~setwd() for R to save all documents, files, objects etc in: in this case it is in the folder monitoring (see path below)
setwd("C:/RStudio/stats")

# to show you a table of all installed packages
my_packages <- as.data.frame(installed.packages()[ , c(1, 3:4)]) # create list of installed packages

# for easily updating the R version install package installr and run its function updaterR() as well as update.packages()
install.packages("installr")
library(installr)
updateR()
update.packages(checkBuilt=TRUE, ask=FALSE)
