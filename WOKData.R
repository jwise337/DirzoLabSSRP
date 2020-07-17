## Loading packages and data ####
# install.packages ("devtools")
# library (devtools)
# devtools::install_github("ropensci/refsplitr")
library (refsplitr)
library (dplyr)
library (ggplot2)
install.packages("maps")
library (maps)
wdi <- read.csv("WDI_data.csv")
## Running RefSplitr ####
# From https://github.com/ropensci/refsplitr
# load the Web of Science records into a dataframe

dat1 <- references_read(data = "1940.txt")
  


# disambiguate author names and parse author address
dat2 <- authors_clean(references = dat1)



# after revieiwng disambiguation, merge any necessary corrections
dat3 <- authors_refine(dat2$review, dat2$prelim)

dat3$year <- 1940

write.csv(dat3, "1940.csv")
head(1940)
dat3 <- read.csv ("1940.csv")

sub <- sample_n(dat3, 10)

# georeference the author locations
dat4 <- authors_georef(dat3)



# generate a map of coauthorships; this is only one of the five possible visualizations  
plot_net_address(dat4$addresses)



dat <- rbind("WOK2020", "dat3")

ggplot (dat, aes (x = year, fill = country)) + geom_bar (position = "fill") 

ggplot (WOK2020, aes (x = year, fill = country)) + geom_bar (position = "fill") 



