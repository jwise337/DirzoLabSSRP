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

dat1 <- references_read(data = "2000.txt")
  


# disambiguate author names and parse author address
dat2 <- authors_clean(references = dat1)


# after revieiwng disambiguation, merge any necessary corrections
dat3 <- authors_refine(dat2$review, dat2$prelim)

dat3$year <- 2000
write.csv(dat3, "2000.csv")
head(2000)
dat3 <- read.csv ("2000.csv")
w
sub <- sample_n(dat3, 10)

# georeference the author locations
dat4 <- authors_georef(dat3)

dat4$year <- 2020
write.csv(dat4, "dat4.csv")
head(dat3)
dat3 <- read.csv ("dat3.csv")

# generate a map of coauthorships; this is only one of the five possible visualizations  
plot_net_address(dat4$addresses)

read_csv("1921.csv")
