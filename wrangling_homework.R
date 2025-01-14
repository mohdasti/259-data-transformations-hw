#PSYC 259 Homework 2 - Data Transformation
#For full credit, provide answers for at least 7/10

#List names of students collaborating with: 

#### MOHAMMAD DASTGHEIB (only me) ####

### SETUP: RUN THIS BEFORE STARTING ----------

#Load packages
library(tidyverse)
ds <- read_csv("data_raw/rolling_stone_500.csv")
  
### Question 1 ---------- 

#Use glimpse to check the type of "Year". 
#Then, convert it to a numeric, saving it back to 'ds'
#Use typeof to check that your conversion succeeded

#ANSWER
glimpse(ds)
## The type of "Year" is character
ds$Year <- as.numeric(as.character(ds$Year)) 
typeof(ds$Year) # now it returns "double"

### Question 2 ---------- 

# Using a dplyr function,
# change ds so that all of the variables are lowercase

#ANSWER
ds %>% rename_with(tolower) # now rank, song, artist, and year are all lowercase

### Question 3 ----------

# Use mutate to create a new variable in ds that has the decade of the year as a number
# For example, 1971 would become 1970, 2001 would become 2000
# Hint: read the documentation for ?floor

#ANSWER
#ds <- ds %>% mutate(decade=Year)
#ds$decade <- floor(ds$decade/10)*10 
ds <- ds %>% mutate(decade=Year)
ds <- ds %>% mutate(decade = floor(ds$decade/10)*10)
### Question 4 ----------

# Sort the dataset by rank so that 1 is at the top

#ANSWER
ds %>% arrange(Rank)
### Question 5 ----------

# Use filter and select to create a new tibble called 'top10'
# That just has the artists and songs for the top 10 songs

#ANSWER
top10 <- ds %>% filter(Rank<11) %>% select(Artist, Song)

### Question 6 ----------

# Use summarize to find the earliest, most recent, and average release year
# of all songs on the full list. Save it to a new tibble called "ds_sum"

#ANSWER
ds_sum <- ds %>% summarise(earliest=min(Year, na.rm=TRUE), most_recent=max(Year, na.rm=TRUE), average_release_year=mean(Year, na.rm=TRUE))

### Question 7 ----------

# Use filter to find out the artists/song titles for the earliest, most 
# recent, and average-ist years in the data set (the values obtained in Q6). 
# Use one filter command only, and sort the responses by year

#ANSWER
ds3 <- ds %>% filter(Year %in% c("1879","2020","1980")) %>% select(Artist, Song, Year) %>% arrange(Year)

### Question 8 ---------- 

# There's and error here. The oldest song "Brass in Pocket"
# is from 1979! Use mutate and ifelse to fix the error, 
# recalculate decade, and then
# recalculate the responses from Questions 6-7 to
# find the correct oldest, averag-ist, and most recent songs

#ANSWER
ds$Year <- as.numeric(as.character(ds$Year)) 
ds <- ds %>% mutate(Year=ifelse(Year=='1879',"1979", Year)) %>% mutate(decade=Year) %>% mutate(decade = floor(ds$decade/10)*10)
ds_sum <- ds %>% summarise(earliest=min(Year, na.rm=TRUE), most_recent=max(Year, na.rm=TRUE), average_release_year=mean(Year, na.rm=TRUE))
dsQ7 <- ds %>% filter(Year %in% c("1937","2020","1980")) %>% select(Artist, Song, Year) %>% arrange(Year)

### Question 9 ---------

# Use group_by and summarize to find the average rank and 
# number of songs on the list by decade. To make things easier
# filter out the NA values from decade before summarizing
# You don't need to save the results anywhere
# Use the pipe %>% to string the commands together

#ANSWER
ds %>% drop_na(decade) %>% group_by(decade) %>% summarise(average_rank=mean(Rank), number_of_songs=n())

### Question 10 --------

# Look up the dplyr "count" function
# Use it to count up the number of songs by decade
# Then use slice_max() to pull the row with the most songs
# Use the pipe %>% to string the commands together

#ANSWER
ds %>% drop_na(decade) %>% count(decade) %>% slice_max(n)
  