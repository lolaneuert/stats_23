## R Stats Project - Piero Zannini Class
## January 2023
## Global Change Ecology and Sustainable Development Goals
## Tarla Murphy, Lola Neuert, Emilija Zubac

# Measurement data of polar bears captured in the Chukchi
# and Southern Beaufort seas, 1981 - 2017

### Data
# Data is available from the Alaska Science Center at https://alaska.usgs.gov/products/data.php?dataid=315
# alternatively from data.world at https://data.world/us-doi-gov/581f789d-efa1-45db-a542-4812bed49004
# Data is made available by the Department of the Interior, US Government
# information on the methods used during capture and measurement can be found at 
# Rode, K.D., 2020, Measurement data of Polar Bears captured in the Chukchi and southern Beaufort Seas, 1981-2017
# U.S. Geological Survey data release, https://doi.org/10.5066/P9TVK3PX.


### Data Upload
# set working directory, eg. setwd("~/R_Stats")

# load requiring packages
library(ggplot2) # create aesthetic graphs
library(tidyverse) # used to make a tidy dataset to work with
library(GGally) # extension of ggplot
library(patchwork) # patch plots together easily
library(naniar) # this package allows us to change values to NAs
library(dplyr) # needed for filtering

# load the dataset
polar <- read.csv("data/polar.csv", header = TRUE)

# take a first look at the dataset
glimpse(polar)

# originally the data contained 22 columns,of which a few held no data however, in 3174 rows
# the variables showed measured data of captured polarbears, including the collecting agency, 
# the population group, 
# the date of capture, 
# the BearID (some bears were captured multiple times throughout their life over the years),
# the bears sex, age, length (standard and total),
# the bears heart girth, skull width, tail length, mass, 
# a score that represents their physical condition
# the number of cubs that accompanied them, the cubs age
# the bears gut fill, litter mass
# their fat amount, gut fill, snout length, resistence, body fat percentage (but all these contained no data)

# rename columns and change necessary data types
polar <- polar %>% 
  rename(agency = Collecting_Agency , population = Population, bearID = BearID, sex = Sex,
         age = Age, total_length = Total_Length, standard_length = Standard_Length, mass = Mass, 
         cubs = Number_of_cubs, heart = Heart_Girth, skull = Skull_Width) %>% 
  mutate(age  = as.integer(age),
         total_length = as.double(total_length),
         standard_length = as.double(standard_length),
         mass = as.double(mass), cubs = as.integer(cubs), 
         heart = as.double(heart), skull = as.double(skull))

# create a subset of only the relevant columns
polar1 <- subset(polar, select = c("agency", "population", "Date", "bearID", "sex", "age", 
                                   "total_length", "standard_length", "mass", "cubs", "heart", "skull"))

### EDA: look to see where NAs can be found in the dataset
# as well as look at some statistical parameters, including minimum value, 1st quantile, median, mean, 3rd quantile and maximum value
summary(polar1)

# we look at the first and last few lines of the dataset to see if everything is cohesive
head(polar1) 
tail(polar1)

# remove NAs
# however the NAs in the cub column cannot simply be removed, as no cubs accompany male bears our young (immature) females
cubs_male30<- polar1$cubs %>% replace_na(30) # change male/young female NAs to 30 in the cubs column 
# (as this value is unrealistic and cannot be mistaken with any real cub count)

# now subset the columns without the old cubs column
polar2 <- subset(polar, select = c("agency", "population", "Date", "bearID", "sex", "age", 
                                   "total_length", "standard_length", "mass", "heart", "skull"))
# add in the new column with the NAs changed to 30
polar3 <- cbind(polar2, cubs_male30)

# now omit all NAs in the dataset
polar4 <- na.omit(polar3) 

# we looked at some further parameters for some interesting variables
range(polar4$mass)
var(polar4$mass)
range(polar4$total_length)
var(polar4$total_length)

# cleaning data for average number of accompanying cubs per mature female

polar4$cubs_male30[polar4$cubs_male30==30] <- "NA" # 30s in the cubs column are replaced with NAs

# again subset the relevant columns for the mature female dataset
polar5 <- polar4 %>% 
  select(bearID, cubs_male30, age, total_length, standard_length, mass, heart, skull) %>%
  filter(cubs_male30 != "NA") # filter out the NAs so we only have rows for mature females

# change the column names for cubs and mutate them to be integer
colnames(polar5)[2] <- "cubs" 
polar5 <- polar5 %>% mutate(cubs = as.integer(cubs))

### graphs
## some simple graphs: density distributions and boxplots of bivariate data (impact of sex on age, mass and length)

dens_age <- polar4 %>% 
  ggplot() +
  geom_density(aes(x = age, fill = sex), color = "black", alpha = 0.3) +
  labs(title = "Age distribution for females & males", 
       subtitle =  "1981 - 2017", 
       x = "Age (in years)", y = "Density", fill = "Sex") +
  theme(panel.background = element_rect(fill = "white"))

dens_mass <- polar4 %>% 
  ggplot() +
  geom_density(aes(x = mass, fill = sex), color = "black", alpha = 0.3) + 
  labs(title = "Mass distribution", 
       x = "Mass (in kg)", y = "Density", fill = "Sex") +
  theme(panel.background = element_rect(fill = "white"))

dens_length <- polar4 %>% 
  ggplot() +
  geom_density(aes(x = total_length, fill = sex), color = "black", alpha = 0.3) +
  labs(title = "Length distribution",  
       x = "Total Length (in cm)", y = "Density", fill = "Sex") +
  theme(panel.background = element_rect(fill = "white"))

box_age <- polar4 %>% 
  ggplot() +
  geom_boxplot(aes(x = sex, y  = age)) +
  labs(title = "Age distribution for females and males", 
       subtitle = "1981 - 2017",
       x = "Sex", y = "Age (in years)") +
  theme(panel.background = element_rect(fill = "white"))

box_mass <- polar4 %>% 
  ggplot() +
  geom_boxplot(aes(x = sex, y  = mass)) +
  labs(title = "Mass distribution", 
       x = "Sex", y = "Mass (in kg)") +
  theme(panel.background = element_rect(fill = "white"))

box_length <- polar4 %>% 
  ggplot() +
  geom_boxplot(aes(x = sex, y  = total_length)) +
  labs(title = "Length distribution",  
       x = "Sex", y = "Length (in cm)") +
  theme(panel.background = element_rect(fill = "white"))

# now add all these graphs in one big frame using the package patchwork for better overview and comparison
dens_box_sex <- dens_age + dens_mass + dens_length +
  box_age + box_mass + box_length

ggsave(filename = "density_boxplots_sex.png", plot = dens_box_sex, width = 10, height = 10)

# plot showing skull width correlation to sex
box_skull <- polar4 %>% 
  ggplot() +
  geom_boxplot(aes(x = sex, y = skull, fill = sex)) +
  labs(title = "Skull width correlation to sex",
       x = "Sex", y = "Skull width (in cm)") + 
  theme(panel.background = element_rect(fill = "white"))

# bar plot for age distribution in the whole population observed - unvariate variable
bar_age <- polar4 %>% 
  ggplot() +
  geom_bar(aes(x = age))+
  labs(title = "Age distribution of all polarbears",
       x = "Age (in years)", y = "Number of polarbears") + 
  theme(panel.background = element_rect(fill = "white"))

# bar plot for mass distribution in the whole population observed - univariate variable
bar_mass <- polar4 %>% 
  ggplot() +
  geom_bar(aes(x = mass))+
  labs(title = "Mass distribution of all captured polarbears",
       x = "Mass (in kg)", y = "Number of polarbears") + 
  theme(panel.background = element_rect(fill = "white"))

# violin plot for age distirbution with males and females
violin_age <- polar4 %>% 
  ggplot() +
  geom_violin(aes(x = sex, y = age, color = sex, fill = sex)) +
  labs(title = "Age distribution of females and males",
       x = "Sex", y = "Age (in years") + 
  theme(panel.background = element_rect(fill = "white"))

box_skull + bar_age + bar_mass + violin_age # patchwork of these four plots

ggsave(filename = "boxplot_skull.png", plot = box_skull, width = 10, height = 10)
ggsave(filename = "barplot_age.png", plot = bar_age, width = 10, height = 10)
ggsave(filename = "barplot_mass.png", plot = bar_mass, width = 10, height = 10)
ggsave(filename = "violinplot_age.png", plot = violin_age, width = 10, height = 10)

# polar cubs graphs: does number of cubs correspond to age, mass or length of mothers?
polar6 <- polar5 %>% mutate(cubs = as.character(cubs)) # change cub variable back to characters for it to display more easily in graphs

cubs_age <- ggplot(data = polar6) +
  geom_boxplot(aes(x = cubs, y = age)) + 
  labs(title = "Cub count per age of mother",
       x = "Number of cubs", y = "Age (in years)") + 
  theme(panel.background = element_rect(fill = "white"))

cubs_mass <- ggplot(data = polar6) +
  geom_boxplot(aes(x = cubs, y = mass)) +
  labs(title = "Cub count per mass of mother",
       x = "Number of cubs", y = "Mass (in kg)") + 
  theme(panel.background = element_rect(fill = "white"))

cubs_length <- ggplot(data = polar6) +
  geom_boxplot(aes(x = cubs, y = total_length)) +
  labs(title = "Cub count per length of mother",
       x = "Number of cubs", y = "Length (in cm)") + 
  theme(panel.background = element_rect(fill = "white"))

cubs_plots <- cubs_age + cubs_mass + cubs_length # patchwork of the cubs plots

ggsave(filename = "cubs_plots.png", plot = cubs_plots, width = 15, height = 10)

### hypothesis
# our first hypothesis concerns the correlation between Total length of Polarbears and their Mass
# H0 is stated as: Total length and Mass are not positively correlated,
# and H1 is stated as: Total length and Mass are positively correlated
# to test this we use the function cor.test, and specify greater as the alternative

cor.test(polar4$total_length, polar4$mass, alternative = "greater")
# the Pearson's product-moment correlation shows a p-value of less than 0.05, meaning the correlation is significant
# the correlation value is 0.86, showing a strong positive correlation between length and mass of polarbears
# this means we can reject H0 and accept H1

# create plot to show correlation, with geom_smooth adding the correlation as a line for visualization
scatter_hyp1 <- ggplot(data = polar4) + 
  geom_point(aes(x = total_length, y = mass), alpha = 0.3) + 
  geom_smooth(aes(x = total_length, y = mass), method = "lm") +
  labs(title = "Polarbear length and mass correlation", 
       subtitle = "Measurements from Chukchi and Southern Beaufort seas, 1981 - 2017", 
       x = "Total Length (in cm)", y = "Mass (in kg)") +
  theme(panel.background = element_rect(fill = "white"))

scatter_hyp1
ggsave(filename = "scatterplot_hyp1.png", plot = scatter_hyp1, width = 10, height = 10)

# our second hypothesis tries to correlate the number of cubs in mature female polarbears with their mass, 
# as we saw a decreasing trend in the graphs above
# H0 is stated as: there is no negative correlation between number of cubs and mass 
# H1 is stated as: there is a negative correlation between number of cubs and mass
# we again use function cor.test

cor.test(polar5$cubs, polar5$mass, alternative = "less")
# this time the Pearson's correlation gave a p-value of 0.000651
# as this is smaller than 0.05, the test of correlation was significant
# the correlation comes out to be -0.16
# we therefore can reject H0 and accept H1

# now we create a plot that shows the correlation
scatter_hyp2 <- ggplot(data = polar5) + 
  geom_point(aes(x = cubs, y = mass), alpha = 0.3) + 
  geom_smooth(aes(x = cubs, y = mass), method = "lm") +
  labs(title = "Mature female Polarbears: correlation of number of cubs and mass", 
       subtitle = "Measurements from Chukchi and Southern Beaufort seas, 1981 - 2017", 
       x = "Number of cubs", y = "Mass (in kg)") +
  theme(panel.background = element_rect(fill = "white"))

scatter_hyp2
ggsave(filename = "scatterplot_hyp2.png", plot = scatter_hyp2, width = 10, height = 10)
