## R
## Minimalistic introduction

## Forbes billionaires

## More vectors
## https://www.forbes.com/billionaires/
## wektors napisów (character vector)

milioner <- c('Jeff Bezos', 'Bill Gates', 'Bernard Arnault',
              'Warren Buffett', 
              'Larry Ellison', "Amancio Ortega", 
              "Mark Zuckerberg", "Jim Walton", "Alice Walton", "Rob Walton")

## numeric vectors
## majątek (wealth)
majatek <- c(113, 98,76, 67.5,59,55.1,54.7,54.6,54.4, 54.1)

## wiek (age)
wiek <- c(56, 64, 71, 89, 75, 84, 35, 71, 70, 75 )

## urodzony (born)
## character vector (fake) dates
urodzony <- c( 
   '1964-01-01', '1956-01-01', '1949-01-01', '1931-01-01', '1945-01-01',
   '1936-01-01', '1985-01-01', '1949-01-01', '1950-01-01', '1945-01-01' )

## ISO codes
## factors
kraj <- c( 'US', 'US', 'FR', 'US', 'US', 'ES', 'US', 'US', 'US', 'US' );

## F&I = finance and investment
## factors
branza <- c("Technology", "Technology", "Retail", "F&I", "Technology", "Retail",
   "Technology", "Retail", "Retail", "Retail")

## dataframe = list of named vectors

forbes <- data.frame(milioner, majatek, urodzony, wiek, kraj, branza)

##
##Let's check
##

## str(ucture)
str(forbes)

## print frame (not particularily useful)
forbes


## Print column (more useful)
## df$colum

forbes$majatek


##Mean wealth
## (wealth is numeric)
mean(forbes$majatek)

## kraj is non-numeric
mean(forbes$kraj)

##
## print column using numbers
## columns are numbered from 1
forbes[, 3]


###
## useful functions
head(forbes, n=13)
###
tail(forbes)
##
## size-of 
?nrow

nrow(forbes)


##
## Basic (descriptive) statistics (at least)

?mean
?median

## mean of a vector majatek
mean(majatek)

## summary (forbes) ERROR
## but
forbes.wiek <- forbes$wiek

summary(forbes.wiek)
sd(forbes.wiek)
min(forbes.wiek)

## Simple plot
## plot with default chart (R decides based on the data to plot)
## Guess the plot type :-)
plot(forbes$wiek)

plot(forbes$wiek, forbes$majatek)

hist(forbes$wiek)

## In practice data are loaded from files or URLs
##
## Forbes billionaires (full data)

## Import data into frame (function csv.read)



forbes <- read.csv("FB2020.csv", dec=".", sep = ';',
  header=T, na.string="NA");

str(forbes)


## indexing
w  <- forbes[,3]
p <- forbes[1,]

p
w <- forbes$worth

billionares <- forbes[,"name"]
## or: billionares <- forbes$name

## 
## Basic statistics again

summary(forbes$worth)
forbes.summary <- summary(forbes$worth)
str(forbes.summary)
forbes.summary[1]

## Extract atribute 'Median'
forbes.summary["Median"]
forbes.median <- forbes.summary["Median"]
forbes.median


forbes.mean  <- mean(forbes$age, na.rm = T)

## Printing results
print (forbes.mean)

## Formatted print
sprintf ("%.2f", forbes.mean)

## or (cat = concatenate)
cat ("Median:", forbes.median)

summary(forbes)

## The distibution is extremly skew
forbes.table <- table(forbes$worth)

length(forbes.table)

forbes.table

cut(forbes$worth, breaks=seq(0,120, by=10))

qq <- table(cut(forbes$worth, breaks=seq(0,120, by=10)))

hist(qq)


## Fundamental data manipulation libraries dplyr/tidyverse

## Filtering rows
library("dplyr")
## install.packages("dplyr") if not found
## installation is automatic (upon confirmation) in RStudio

nonus.forbes <- filter(forbes, country != "United States")
nonus.forbes

## pipe operator %>%
## selecting columns
nonus.forbes.worth <- filter(forbes, country != "United States") %>% 
  select(worth)
## łącznie ile mają
sum(nonus.forbes.worth)

## Print countries  without repetitions
select(forbes, country) %>% unique
## How many countries
select(forbes, country) %>% unique %>% nrow
## alternative syntax:
forbes %>% select(country) %>% unique %>% nrow

## Grouping
by.country <- forbes %>% group_by(country) %>%
    summarise(t = sum(worth), n=n())

by.country

## #####################################################################
## Graphics
## default chart for list of numbers
## ####################################################################

plot (forbes$worth)
## boxplot
boxplot(forbes$worth)
## color= breaks
hist(forbes$worth)

## 
boxplot(worth ~ branch, data=forbes)
select(forbes, branch) %>% unique %>% nrow

## mutate = create new variables
forbes.x <- mutate(forbes, 
  branch = case_when(branch == "Technology" ~ "IT", 
                     branch == "Fashion & Retail" ~ "FR",
                     TRUE ~ "Other"))
forbes.x
boxplot(worth ~ branch, data=forbes.x)

## basic plot
## for two lists (XY-plot)
plot(forbes.x$age, forbes.x$worth)

##
##
## better plots ggplot2
##

library ("ggplot2")

#  quick-plot (default charts are generated based on data types)
qplot(data=forbes.x, age, worth, color=branch)
qplot(data=forbes.x, age, worth, facets = . ~ branch)


