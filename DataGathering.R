## Loading packages and data ####
# install.packages ("devtools")
# library (devtools)
# devtools::install_github("ropensci/refsplitr")
library (refsplitr)
library (dplyr)
library (ggplot2)
# install.packages("maps")
library (maps)
#Espin et al 
wdi <- read.csv ("WDI_data.csv")

## Running RefSplitr ####
# From https://github.com/ropensci/refsplitr
# load the Web of Science records into a dataframe
dat1 <- references_read(data = "savedrecs (3).txt")

# disambiguate author names and parse author address
dat2 <- authors_clean(references = dat1)

# after revieiwng disambiguation, merge any necessary corrections
dat3 <- authors_refine(dat2$review, dat2$prelim)

sub <- sample_n(dat3, 10)

dat3$year <- 2020

# georeference the author locations
dat4 <- authors_georef(dat3)

# generate a map of coauthorships; this is only one of the five possible visualizations  
plot_net_address(dat4$addresses)


## Statistical analysis ####
write.csv(dat3, "dat3.csv")
head (dat3) 

dat3 <- read.csv ("dat3.csv")

#subset first author

#standardize country name + merge country income

#stacked bar plot + test

#proportion analysis + test





## Running maps ####
# From https://sarahpenir.github.io/r/making-maps/
world <- map_data("world")
head (world)
worldplot <- ggplot() +
  geom_polygon(data = world, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)
worldplot
