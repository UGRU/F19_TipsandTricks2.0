##############################
## Tips and tricks round 2
##
## Matt Brachmann (PhDMattyB)
##
## 2019-10-17
##
##############################

## Main tip: organization will make your life easier

## tab complete setting your working directory
setwd('~/PhD/R users group/')
## or getwd()
## or use projects for all of your stuff 

## Organize your code so you load your packages at once
## Saves you having random packages loading in places
library(patchwork) #great for stitching plots together
library(janitor) #cleans and standardizes column names
library(devtools) #loads in packages from github
library(skimr) #gives a good look at your data
library(rsed) # data manipulation using regular expressions
library(data.table) #other ways to manipulate your data
library(tidyverse) # the best series of packages ever

## set your plotting theme if you make a lot of graphs
## and want to keep them consistent
theme_set(theme_bw())

## Four of any symbol makes code into a drop down menu and collapsable 
## OR
## as Joey Burant pointed out, control (command) shift R generates this
## automatically

## CHEAT SHEETS! ####
# Look up the dplyr and ggplot cheat sheets
# see: https://rstudio.com/resources/cheatsheets/

## How to make your R look sweet ####
# Tools
# Global options
# Appearance
## Brackets and apostrophes ####

## Using the tidy verse makes your code cleaner and more readable
## Pipe opperator #####
# Control (command) shift m %>% 
# the pipe opperator links different functions together
# Example:

mtcars %>%
  mutate(NEW_COLUMN = mpg + cyl) %>%
  rename(new_column_new_you = NEW_COLUMN) %>%
# rename can also be used to change the names of fixed positions
  arrange(hp) %>%
  dplyr::select(-new_column_new_you)
  
## Bulk comment code ####
# Control (command) shift c the highlighted code




## Code example: ####

## If I have multiple lists and want to compare them
## I can do it by either hard to read base R or abuse the join functions
## in dplyr

df1 = sample(1:10, size=100, replace=TRUE) %>% 
  as_tibble()
df2 = sample(1:3, size=100, replace=TRUE) %>% 
  as_tibble()
df3 = sample(5:8, size=100, replace=TRUE) %>% 
  as_tibble()


## Quantify the number of SNPs that are only in the 
## carbon - genotype association

'%!in%' <- function(x,y)!('%in%'(x,y)) # not in
df1_unique = df1$value[df1$value %!in% df2$value]
length(df1_unique)
df1_unique = df1_unique[df1_unique %!in% df3$value]
length(df1_unique)

## This will also only give you the list you asked for 
## and not associated data

## OR

df1_nums = anti_join(df1,
                     df2,
                     by = 'value')

df1_nums = anti_join(df1_nums,
                           df3,
                           by = 'value')

## This not only gives you the number of snps in this test but
## gives you all of the associated data if the df had it. 
## The join functions in dplyr are easy to code and understand
## however, they are computationally slower than the base r counterpart