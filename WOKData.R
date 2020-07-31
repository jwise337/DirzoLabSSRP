## Loading packages and data ####
# install.packages ("devtools")
# library (devtools)
# devtools::install_github("ropensci/refsplitr")
library (refsplitr)
library (dplyr)
library (ggplot2)
install.packages("maps")
library (maps)

## Running RefSplitr ####
# From https://github.com/ropensci/refsplitr
# load the Web of Science records into a dataframe

dat1 <- references_read(data = "2019.txt")


# disambiguate author names and parse author address
dat2 <- authors_clean(references = dat1)

# after revieiwng disambiguation, merge any necessary corrections
dat3 <- authors_refine(dat2$review, dat2$prelim)

#Add year column to datasets and save as csv
dat3$year <- 2019
write.csv(dat3, "2019.csv")
head(2019) 
dat3 <- read.csv ("2019.csv")


# georeference the author locations
dat4 <- authors_georef(dat3)

# generate a map of coauthorships; this is only one of the five possible visualizations  
plot_net_address(dat4$addresses)

## Running ggplot ####
#upload previous csv into global environment
ex. 
# From https://github.com/tidyverse/ggplot2

# Bar graph of one year, x = year, y= country (NAs still present)- prelim graph
ggplot (WOK1940, aes (x = year, fill = country)) + geom_bar (position = "fill")

#Bar graph for multiple years, x= year, y = country (NAs still present)- prelim graph
dat <- rbind(WOK1921, WOK2019)

dat <- as.data.frame(dat)

ggplot (dat, aes (x = year, fill = country )) + geom_bar (position = "fill", width = 30)

## Subsetting to only first author and filling in NAs manually ####
#subsetting first author
firstauth <- subset (WOK1940, author_order == 1) 

#check to see if it was done
firstauth

# install data editor package from CRAN

install.packages("editData")

#highlight wanted dataset to change, click add ins, and select edit data
  #be sure to SAVE AS NEW CSV file after changes are made, preferably as "edited-year.csv"

ex. firstauth -> edited-1960.csv


## Standardize country names to same as WDI datbase ####
#load standardize text function#
library(StandardizeText)

#check column names is dataset#
colnames (firstauth)

#Add new column iso which contians the standardized names based on country
WOK1940$iso <- standardize.countrynames (WOK1940$country, standard = "iso", suggest = "auto") #wales, scotland, england

#Ensure all names in iso now match to WDI database
unique (WOK1940$iso)

#If not, manually change names 
WOK1980$iso[WOK1980$iso == "Venezuela"] <- "Venezuela, RB"
WOK1940$iso[WOK1940$iso == "australia"] <- "Australia"
WOK1940$iso[WOK1940$iso == "USA"] <- "United States"
WOK1940$iso[WOK1940$iso == "usa"] <- "United States"
WOK1940$iso[WOK1940$iso == "uk"] <- "United Kingdom"
WOK1980$iso[WOK1980$iso == "canada"] <- "Canada"
WOK1980$iso[WOK1980$iso == "fed rep ger"] <- "Germany"
WOK2019


wdi <- read.csv("WDI_data.csv")



tbl <- table (first_wdi$income)
tbl

chisq.test(tbl)
firstauth <- subset (WOK1960, author_order == 1) 
firstauth
read_csv(edited-1921.csv)



#deleting 1960 column

View(WOK2019)


WOK1940$country <- NULL

first_wdi <- merge (WOK1940, wdi, by = "iso", all.x = T)
first_wdi <- merge ()

WOK1980
#After checking iso, change iso column name to country and delete country column

names(WOK1940)[names(WOK1940) == "iso"] <- "country"
names(WOK1940)[names(WOK1940) == "country"] <- "iso"

ggplot (first_wdi, aes (x =year, fill = income)) + 
  geom_bar (position = "fill")

#reach out to refsplitr team

ggplot (first_wdi, aes (x =year, fill = income)) + 
  geom_bar (position = "fill") 

#1960 color hue

git push origin master --force = pushes whatever you have


fill in missing data(
  RBIND TOGETHER
  MERGE WITH WDI
)

write.csv(first_wdi,"1980-iso.csv")

chi-sqr- differnce between countries
linesar regression- gives us changes over time(
  differing from global south and global north 
)
