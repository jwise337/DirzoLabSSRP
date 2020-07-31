dataclean <- function (textfile) {
  dat1 <- references_read(data = textfile)
  
  # disambiguate author names and parse author address
  dat2 <- authors_clean(references = dat1)
  
  # after revieiwng disambiguation, merge any necessary corrections
  dat3 <- authors_refine(dat2$review, dat2$prelim)
  write.csv(dat3, "year.csv")
  
}
dataclean ("1997.txt", )

list <- c ("1997.txt","2020.txt")

for (i in list){dataclean (i)}

1921
1940
1960
1970
1975
1980
2000
2019
2020

%>% #piping

#look at UN for metrics in order to bin by income or 
# look in reserach how they differnet globaol north and south