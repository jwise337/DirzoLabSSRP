## Loading packages and data ####
# install.packages ("devtools")
# library (devtools)
# devtools::install_github("ropensci/refsplitr")

library (refsplitr)
library (dplyr)
library (ggplot2)
library (ggsci)
install.packages("ggsci")
library (RColorBrewer)
wdi <- read.csv ("edited-WDI")

## Running RefSplitr ####
# From https://github.com/ropensci/refsplitr
# load the Web of Science records into a dataframe

dat1 <- references_read(data = "1940.txt")


# disambiguate author names and parse author address
dat2 <- authors_clean(references = dat1)

# after revieiwng disambiguation, merge any necessary corrections
dat3 <- authors_refine(dat2$review, dat2$prelim)

#Add year column to datasets and save as csv
dat3$year <- 1940
write.csv(dat3, "1940.csv")
head(1940) 
dat3 <- read.csv ("1940.csv")

# georeference the author locations (not fully working yet due to lack of exact addresses)
dat4 <- authors_georef(dat3)

# generate a map of coauthorships; this is only one of the five possible visualizations  
plot_net_address(dat4$addresses)

## Running ggplot ####
#upload previous csv into global environment
ex. 1930.csv -> WOK1930

# From https://github.com/tidyverse/ggplot2

# Bar graph of one year, x = year, y= country (NAs still present)- prelim graph
ggplot (WOK1940, aes (x = year, fill = country)) + geom_bar (position = "fill") 


#Bar graph for multiple years (only two at time), x= year, y = country (NAs still present)- prelim graph

dat <- merge(WOK1930, WOK1940)

ggplot (dat, aes (x = year, fill = country)) + geom_bar (position = "fill")

## Subsetting to only first author and filling in NAs manually ####
#subsetting first author
firstauth <- subset (WOK1940, author_order == 1) 

ggplot (firstauth, aes (x = year, fill = country)) + geom_bar (position = "fill")


#check to see if it was done
firstauth

# install data editor package from CRAN

install.packages("editData")

#highlight wanted dataset to change, click add ins, and select edit data
  #be sure to SAVE AS NEW CSV file after changes are made, preferably as "edited-year.csv"

ex. firstauth -> edited-1940.csv


## Standardize country names to same as WDI datbase ####
#load standardize text function#
library(StandardizeText)

#check column names is dataset#
colnames (WOK2000)

#Add new column iso which contians the standardized names based on country
WOK2000$iso <- standardize.countrynames (WOK2000$country, standard = "iso", suggest = "auto") #wales, scotland, england

#Ensure all names in iso now match to WDI database
unique (WOK2000$iso)

#If not, manually change names 
WOK1980$iso[WOK1980$iso == "USA"] <- "United States"
WOK2000$iso[WOK2000$iso == "usa"] <- "United States"
WOK1940$iso[WOK1940$iso == "uk"] <- "United Kingdom"
WOK1980$iso[WOK1980$iso == "canada"] <- "Canada"
WOK2019$iso[WOK2019$iso == "germany"] <- "Germany"
WOK2019$iso[WOK2019$iso == "peoples r china"] <- "China"
WOK2019$iso[WOK2019$iso == "australia"] <- "Australia"
WOK2019$iso[WOK2019$iso == "USA"] <- "United States"
WOK2019$iso[WOK2019$iso == "usa"] <- "United States"
WOK2000$iso[WOK2000$iso == "scotland"] <- "United Kingdom"
WOK2019$iso[WOK2019$iso == "French Guiana"] <- "France"
WOK2019$iso[WOK2019$iso == "brazil"] <- "Brazil"
WOK2019$iso[WOK2019$iso == "French Guiana"] <- "France"

#check graph, it now has all countries shown- No NAs#

ggplot (WOK2000, aes (x = year, fill = iso)) + geom_bar (position = "fill")


##Making WDI graph####
#merging WDI with country year#

sort (unique (wdi$country))
names (wdi) [names (wdi) == "country"] <- "iso"

first_wdi <- merge (WOK2000, wdi, by = "iso", all.x = T)


#Check it worked# 
ggplot (first_wdi, aes (x =year, fill = income)) + geom_bar (position = "fill")

#save new file#
ex. 2019
write.csv(first_wdi, "2000-iso.csv")

#Merge two years and check chi square
dat <- rbind(WOK1940, WOK1960)
ggplot (dat, aes (x =year, fill = income)) + geom_bar (position = "fill")

#Get a chi square#
tbl <- table (dat$income)
tbl

chisq.test (tbl)


#updating country column to match iso column

WOK2019$country= WOK2019$iso
WOK1940$country= WOK1940$iso
WOK1960$country= WOK1960$iso
WOK1980$country= WOK1980$iso
WOK2000$country= WOK2000$iso
WOK1921$country= WOK1921$iso

#save file#

ex. WOK1940 <- final-1940
  write.csv(WOK2000, "final-2000.csv")
  
##Merge All Files####
# seperate the years up first, then combine#
  da <- rbind(WOK1921,WOK1940)
  dt <- rbind(WOK1960, WOK1980)
  dz <- rbind(WOK2000, WOK2019)
  
  db <- rbind(da,dt)
  dat <-rbind(db,dz)
  
  
#IMPORTANT in prior merging columns could be duplicated check using#
colnames (WOK1960)
colnames (WOK1980)
colnames (WOK2000)
colnames (WOK2019)

#If so delete other column using#
WOK2000$X1_2<- NULL


#check its done# 

#creates clolor friendly graph#
cbp1 <- c("#8e327f", "#5cb455", "#784db1", "#a6bc3a", "#7b78e5", "#a0c95a",
          "#492d7d", "#5aca7b", "#da72c3", "#6e9327", "#5486e1", "#c1a830","#525da8",
          "#d6902c", "#20d8fd", "#a1291d", "#39dfe0", "#cf4658", "#42ce98", "#d44e6f",
          "#45ba99", "#912c5d", "#46a26c","#dc6598","#507a25","#bd84d7","#3c7937",
          "#dd5e55","#7199e0","#d6633b","#a4c06f","#932d44","#cdb359","#8c282f",
          "#857629","#de767a","#c07b31","#8d3925","#db925f","#8d4d18")

ggplot (dat, aes (x =year, fill = country)) + 
  geom_bar (position = "fill",width = 18) + scale_fill_manual(values = cbp1)

ggplot (dat, aes (x =year, fill = income)) + 
  geom_bar (position = "fill",width = 18) + scale_fill_manual(values = cbp1)

#you now have graph for a combined group of years showcasing country as well as income#

##Graph modifications####

#Captalizing columns#

names(dat)[names(dat) == "year"] <- "Year"
names(dat)[names(dat) == "income"] <- "Income"
names(dat)[names(dat) == "country"] <- "Country"

ggplot (dat, aes (x =Year, fill = Country)) + 
  geom_bar (position = "fill",width = 18) + scale_fill_manual(values = cbp1)

ggplot (dat, aes (x =Year, fill = Income)) + 
  geom_bar (position = "fill",width = 18) + scale_fill_manual(values = cbp1)

#Save final dataset, naming specifically whats shown#
write.csv(dat, "20-Yr-Gaps.csv")

##Other####

git push origin master --force = pushes whatever you have

chi-sqr- differnce between countries
linesar regression- gives us changes over time(
  differing from global south and global north 
)
install.packages("gtools")
library(gtools)


plot(income.y, first_wdi, main = "Scatterplot")


