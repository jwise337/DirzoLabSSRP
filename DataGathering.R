Loading packages and data ####
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
install.packages ("StandardizeText")
library (StandardizeText)

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
write.csv(dat3, "dat3.csv")
head (dat3) 
dat3 <- read.csv ("dat3.csv")

# georeference the author locations
dat4 <- authors_georef(dat3)

# generate a map of coauthorships; this is only one of the five possible visualizations  
plot_net_address(dat4$addresses)


## Statistical analysis ####
colnames (dat3)
dat3$iso <- standardize.countrynames (dat3$country, standard = "iso", suggest = "auto") #wales, scotland, england
unique (dat3$iso)

#subset first author
firstauth <- subset (dat3, author_order == 1) #check duplicates/co-first author

#standardize country name + merge country income
firstauth$iso[firstauth$iso == "usa"] <- "United States"
firstauth$iso[firstauth$iso == "wales"] <- "United Kingdom"
firstauth$iso[firstauth$iso == "scotland"] <- "United Kingdom"
firstauth$iso[firstauth$iso == "england"] <- "United Kingdom"

sort (unique (wdi$country))
names (wdi) [names (wdi) == "country"] <- "iso"

first_wdi <- merge (firstauth, wdi, by = "iso", all.x = T)

colnames (first_wdi)
first_wdi <- first_wdi[, c("iso", "year", "income", "UT")]

#stacked bar plot
ggplot (first_wdi, aes (x =year, fill = income)) + 
  geom_bar (position = "fill")

#chisq test of income levels
tbl <- table (first_wdi$income)
tbl

chisq.test (tbl)

#fill year (random)
first_wdi$year <- sample (1921:2020, size = nrow (first_wdi), replace = T)

summary (first_wdi$income)

#proportion analysis + test
GS <- c("Low income", "Lower middle income")

first_wdi$NS <- ifelse (first_wdi$income %in% GS, "GS", "GN")

regtbl<- first_wdi %>%  #piping
  group_by (year) %>%
  count(NS)

ggplot (regtbl, aes (x = year, y = n, color = NS)) + 
  geom_point() +
  geom_smooth (method = lm, se = F, fullrange = T)

reg <- lm (n ~ year, data = regtbl)
summary (reg)

#check NAs


## Running maps ####
# From https://sarahpenir.github.io/r/making-maps/
world <- map_data("world")
world_single <- world %>% group_by()
#region to country
head (world)
worldplot <- ggplot() +
  geom_polygon(data = world, aes(x=long, y = lat, group = group)) + 
  coord_fixed(1.3)
worldplot