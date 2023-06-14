install.packages("GGally")

# Load packages ----

library(tidyverse)
library(GGally)

# Load data ----

dat <- read_csv("data/global_brownbear_attacks.csv")

# Inspect data set ----

dim(dat)
names(dat)
#nrow(dat)
#ncol(dat)
glimpse(dat)
#str(dat)

# Inspect anomalies ----

sort(unique(dat$NumberofBrownBears)) # shows that a specific row has unknown values
sort(unique(dat$`BrownBearDensity(bears/1000km2)`), decreasing = TRUE)

# we use the function ~which() to see which row is containing an unknown value
which(dat$NumberofBrownBears == "unknown") # row number 8 has a problem, has effects on all column NumberofBrownBears 
which(dat$`BrownBearDensity(bears/1000km2)` == "unknown") # the same row has issues for BrownBearDensity

# to select just row 8: creates a tibble with data about iran, which is missing the number of brown bears, obriously the density is therefore missing as well
dat[8, ]

# Remove missing data, in this case row 8, we use the function ~filter(from dplyr package)
# the pipes operator %>% takes whatever is before it and "pipes" it into the subsequent script
dat <- dat %>% 
  rename(country = `Country/State`) %>% 
  filter(country != "Iran")
# we pipe dat into the rename function, to renames the column 'Country/State' to country, which is much shorter and more clear
# and we use the function ~filter to select everything except data where country = Iran, using != meaning not equal to

# to check if this operation was successful use the function ~glimpse
glimpse(dat)

# Fix wrong data types ----
# NumberofBrownBears had been imported as character values, we have now removed unknown values so we can convert them into integer values
# for this we use the function ~mutate that transforms an existing column, it overwrites it
dat <- dat %>% 
  mutate(NumberofBrownBears = as.integer(NumberofBrownBears),
         `BrownBearDensity(bears/1000km2)` = as.double(`BrownBearDensity(bears/1000km2)`))

glimpse(dat)

# Further fix data ----
# we rename the other columns too, and mutate the data type of n_attacks and n_fatalities
dat <- dat %>% 
  rename(n_attacks     = `NumberofAttacks(2000–2015)`,
         n_fatalities  = `NumberofFatalities(2000–2015)`,
         n_bears       = NumberofBrownBears,
         range         = `BrownBearRange(km2)`,
         human_density = `HumanDensity(inhabitants/km2)`,
         bear_density  = `BrownBearDensity(bears/1000km2)`) %>% 
  mutate(n_attacks    = as.integer(n_attacks),
         n_fatalities = as.integer(n_fatalities))

glimpse(dat)

# Exploratory Data Analysis ----

## Summary statistics ----

head(dat)
summary(dat)

## Data visualization ----

### Univariate distributions ----

# ggplot(data = dat) +
#   geom_histogram(aes(x = n_fatalities))

ggplot(data = dat) +
  geom_bar(aes(x = n_fatalities)) +
  scale_x_continuous(breaks = 0:11) +
  scale_y_continuous(breaks = 1:9) +
  labs(y = "Number of countries",
       x = "Number of fatalities") +
  theme_classic()

# ggplot(data = dat) +
#   geom_histogram(aes(x = n_bears))
# 
# ggplot(data = dat) +
#   geom_histogram(aes(x = log(n_bears)))

ggplot(data = dat) +
  geom_density(aes(x = log10(n_bears))) +
  labs(y = "Kernel density estimate",
       x = "Log10(Number of bears)") +
  theme_classic()

ggplot(data = dat) +
  geom_density(aes(x = bear_density)) +
  labs(y = "Kernel density estimate",
       x = "Bear density (bears / 1000km²)") +
  theme_classic()

ggplot(data = dat) +
  geom_density(aes(x = human_density)) +
  labs(y = "Kernel density estimate",
       x = "Human density (inhabitants / km²)") +
  theme_classic()

### Bivariate distributions ----

ggplot(data = dat) +
  geom_point(aes(x = log10(n_bears),
                 y = n_fatalities),
             alpha = 0.3)

ggplot(data = dat) +
  geom_jitter(aes(x = log10(n_bears),
                  y = n_fatalities),
              alpha = 0.3) +
  geom_smooth(aes(x = log10(n_bears),
                  y = n_fatalities))

## Extra ----

dat %>% 
  select(-country) %>% 
  ggpairs()


