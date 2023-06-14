setwd("C:/Rstudio/stats")

# dataset containing three penguin species on the palmer archipelago, this is used for data exploration & visualization
library(palmerpenguins)
library(tidyverse)

# first look at data
data(penguins) # load a dataset made available by a package
head(penguins)
head(penguins, n = 10) # we see that there is missing data (NA)

glimpse(penguins) # the function ~glimpse() is an alternative of the ~str() function available in tidyverse

# visualization using ggplot, the pipe-symbol %>% adds data into a function (here the plot) that is scripted after
p <- penguins %>% 
    ggplot(aes(x = flipper_length_mm, y = body_mass_g, shape = island)) + 
    geom_point() +
    labs(title = "Penguin size, Palmer Station LTER", 
         subtitle = "Flipper length vs body mass for Adelie, Chinstrap and Gentoo", 
         x = "Flipper length (mm)", y = "Body mass (g)") +
    theme(panel.background = element_rect(fill = "white")) + 
    geom_point(aes(color = species)) +
    scale_color_manual(values = c("darkorange", "purple", "cyan4"), name = "Species")
  
# aes defines the aesthetics: dimensions of a Cartesian system, R defines the optimal range of both axes to see the data
# add geometry using + and then choose a geometry, in this case point symbols: creates a Scatterplot
# then we define the shape to be dependent on the variable island
# add labels, for example title, subtitle or axis description  
# change the theme of specific parameters, here the background, which is a rectangular object, we can change line-width, type, color etc
# or use a readily available theme: theme_bw() for example
# add color to the different species by defining the aes as color by species
# create a color palette using ~scale_color_manual(values = c()), we can also specify a legend title
# or use a readily available color palette: scale_color_brewer(palette = "Set2")

# univariate distributions
# using ggplot we create a barchart (for qualitative or discrete quantitative variables)
penguins %>% 
  ggplot() +
  geom_bar(aes(x = species))
# or a histogram (for continuous data)
penguins %>% 
  ggplot() +
  geom_histogram(aes(x = body_mass_g, color = species),
                 binwidth = 250)
# if the binwidth is broadend, we can reduce the noise
# if you add colors (border) for each species, it shows stacked bars, showing us where the species are distributed in the graph (gentoo appear to be bigger on average)
# to control the color of a geometry use ~fill for the bars, and add color = black (outside of aes) to add black borders to the bars
penguins %>% 
  ggplot() +
  geom_histogram(aes(x = body_mass_g,fill = species),
                 binwidth = 250, color = "black")
# or a density plot
penguins %>%
  ggplot() + 
  geom_density(aes(x = body_mass_g, fill = species), binwidth = 250, color = "black")
# use ~alpha to control transparency ( 0 = totally transparent, 1 = solid)
dens <- penguins %>%
  ggplot() + 
  geom_density(aes(x = body_mass_g, fill = species), binwidth = 250, color = "black", alpha = 0.5)

# bivariate distributions
# how does a quantitative variable vary in respect to a quantitative variable?
# box and whisker plots ( often more elegant to have species on y if you have to compare many boxplots)
penguins %>%
  ggplot() +
  geom_boxplot(aes(x = species, y  = flipper_length_mm, color = species))

# use ~facet_wrap to create subplots, in this case for multiple years/islands (facet_grid would work to but flip the graph)
penguins %>%
  ggplot() +
  geom_boxplot(aes(x = species, y  = flipper_length_mm, fill = species)) + 
  facet_wrap(vars(year, island))

# export graphs (this automatically exports the last image, otherwise we have to assign the graph a name and export that)
ggsave(filename = "boxplot.png")
ggsave(filename = "density_plot.png", plot = dens, width = 7, height = 7)
