#Editors country dataset

#load libraries
library (ggplot2)
library (dplyr)

#load data file
df <- read.csv ("Dryad_Cho_V2.csv") #From Cho et al. paper
wdi <- read.csv ("WDI_data.csv") #From Espin et al. paper, the World Development Index of Countries by their income level

#Explore and clean data
summary (df)
sort (unique (df$COUNTRY)) #sorts unique countries by alphabetical order

#Fix mislabeled data
df$COUNTRY[df$COUNTRY == "Usa"] <- "USA"
df$COUNTRY[df$COUNTRY == "UsA"] <- "USA"
df$COUNTRY[df$COUNTRY == "ITALY"] <- "Italy"

#plot stacked barplot of editor countries over years
p <- ggplot (df, aes (x =YEAR, fill = COUNTRY)) + 
  geom_bar (position = "fill")

p

#View years by subsets
y2014 <- subset (df, YEAR == 2014)
y2013 <- subset (df, YEAR == 2013)

#Facet barplot by journals
p + facet_grid (rows = vars(JOURNAL))

#chisquared test
tbl <- table (df$YEAR, df$COUNTRY)
tbl

chisq.test (tbl) #too many years, chiqsquared not appropriate

#Bin years
df$binyears <- ifelse (df$YEAR < 1991, "early", "late")

ggplot (df, aes (x =binyears, fill = COUNTRY)) + 
  geom_bar (position = "fill")

tbl2 <- table (df$binyears, df$COUNTRY)
tbl2

chisq.test (tbl2)

#Bin countries using wdi dataset
#Explore wdi data
sort (unique (wdi$country))
names (wdi) [names (wdi) == "country"] <- "COUNTRY" #rename column name to match df column names

colnames (df)
colnames (wdi)

#merge df and wdi dataframes by the same country
?merge
dfwdi <- merge (df, wdi, by = "COUNTRY", all.x = T) #merges the two datasets by matching the same column

#trim the columns to only those of interest
colnames (dfwdi)
df1 <- dfwdi [, c ("COUNTRY", "JOURNAL", "YEAR", "NAME",
                   "GENDER", "CATEGORY", "region", "income", "binyears")]

err <- df1[is.na(df1$region)>0, ] #subsetting rows where the two dataframes did not merge correctly
unique (err$COUNTRY) #these are the 8 countries that did not have a corresponding wdi
sort (unique(wdi$COUNTRY)) #by looking, it seems that the official names of the countries are not aligned

wdi$COUNTRY <- as.character(wdi$COUNTRY) #turn the COUNTRY column input from factor to character 
wdi$COUNTRY[wdi$COUNTRY == "United States"] <- "USA"
wdi$COUNTRY[wdi$COUNTRY == "Brunei Darussalam"] <- "Brunei"
wdi$COUNTRY[wdi$COUNTRY == "Egypt, Arab Rep."] <- "Egypt"
wdi$COUNTRY[wdi$COUNTRY == "Iran, Islamic Rep."] <- "Iran"
wdi$COUNTRY[wdi$COUNTRY == "United Kingdom"] <- "UK"
wdi$COUNTRY[wdi$COUNTRY == "Venezuela, RB"] <- "Venezuela"
#the remaining two countries of USSR and French Guiana have no match with the wdi
#rerun lines 60-65 again

#Plot stacked barplot of country income by year
ggplot (df1, aes (x =binyears, fill = income)) + 
  geom_bar (position = "fill")

#chisq test of income levels
tbl <- table (df1$binyears, df1$income)
tbl

chisq.test (tbl) #chisq not the best test since the high number of OECD income countries are not normally distributed

#Use a Fisher's Exact Test 
fisher.test (tbl) #p < 0.05 show that representation of countries are significant in the two time periods
