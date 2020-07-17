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
dat1 <- references_read(data = "2020.txt")

# disambiguate author names and parse author address
dat2 <- authors_clean(references = dat1)

# after revieiwng disambiguation, merge any necessary corrections
dat3 <- authors_refine(dat2$review, dat2$prelim)

sub <- sample_n(dat3, 10)
  
# georeference the author locations
dat4 <- authors_georef(dat3)

# generate a map of coauthorships; this is only one of the five possible visualizations  
plot_net_address(dat4$addresses)

## Running maps ####
# From https://sarahpenir.github.io/r/making-maps/
world <- map_data("world")
head (world)
worldplot <- ggplot() +
  geom_polygon(data = world, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)
worldplot

#stacked barplot of country income by year
ggplot ((dat3, aes (x = year, fill = country)) + 
        geom_bar (position = "fill") 

# load the Web of Science records into a dataframe
dat1 <- references_read(data = "2019.txt)



# disambiguate author names and parse author address
dat2 <- authors_clean(references = dat1)


# after revieiwng disambiguation, merge any necessary corrections
dat3 <- authors_refine(dat2$review, dat2$prelim)

dat3$year <- 2020
write.csv(dat3, "dat3.csv")
head(dat3)
dat3 <- read.csv ("dat3.csv")

sub <- sample_n(dat3, 10)

# georeference the author locations
dat4 <- authors_georef(dat3)

# generate a map of coauthorships; this is only one of the five possible visualizations  
plot_net_address(dat4$addresses)

rbind 
install.packages ("StandardizeText")

#Statistical Analysis
library(StandardizeText)
 colnames (dat3)
 dat3iso <- standardize.countrynames(dat3$country,standard="iso",suggest="auto")
unique (dat3$iso) 

#subset first author
firstauth <- subset(dat3, author_order == 1) #check duplicates/ co-first author
wdi$COUNTRY[wdi$COUNTRY == "United States"] <- "USA"
firstauth$iso[firstauth$iso == "usa"] <- "United States"
firstauth$iso[firstauth$iso == "wales"] <- "United Kingdom"
firstauth$iso[firstauth$iso == "scotland"] <- "United Kingdom"
firstauth$iso[firstauth$iso == "england"] <- "United Kingdom"


sort (unique(wdi$country))
names (wdi) [names (wdi) == "country"] <- "iso"

first_wdi <- merge (firstauth, wdi, by = "iso", all.x = T)

colnames (first_wdi)
first_wdi <- first_wdi[, c("iso", "year", "income", "UT")]

length (unique (first_wdi$UT))
unique (first_wdi$income)

#standardize country name + merge country name

#stacked bar plot + test
ggplot (first_wdi, aes (x = year, fill = income)) + 
  geom_bar (position = "fill")

ggplot (first_wdi, aes (x = year, fill = iso)) + 
  geom_bar (position = "fill")
  
  ggplot ("2020.csv", aes (x = year, fill = iso)) + 
  geom_bar (position = "fill")


#proportion analysis + test

#check NAs

#subset last author (indexing from behind) [-1] per unique paper----- 

maybe----dplyr function:group_by()

#proportion of authors
