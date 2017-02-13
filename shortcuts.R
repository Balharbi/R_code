#How to generate shortcut functions

#If you're lazy, you can use shorter names for functions, e.g. instead of typing 'summary', you can just type 's'
#You can also make it so the functions load with the parameters you typically set.
#Summary shortcut
s <- function(...)
	{
		summary(...)
	}


#Get a linear model summary quickly
slm <- function (...)
	{
		summary(lm(...))
	}

#Read csv file, but also have read the first line as a header, do NOT read strings as factors, and specify SPSS and Excel "NA" entries as true NA values, rather than interpreting them as text
rcsv <- function(...)
	{
		read.csv(..., header=T, stringsAsFactors=FALSE,na.strings=c("NA", "#N/A", "#NULL!"))
	}
  
  #To load this Rscript, put this file in your working directory. Then type source('shortcuts.R') in R. 
  #Alternatively, you can copy and paste these functions into R every time you start it. 
