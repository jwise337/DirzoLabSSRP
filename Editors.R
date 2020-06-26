#Editors country dataset

#Change in editor countries over years
df <- Dryad_Cho_V2

library (ggplot2)

p <- ggplot (df, aes (x =YEAR, fill = COUNTRY)) + 
  geom_bar (position = "fill")

summary (df)

y2014 <- subset (df, YEAR == 2014)
y2013 <- subset (df, YEAR == 2013)


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

#Bin countries
