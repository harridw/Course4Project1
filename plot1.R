#  Coursera: Data Science Specialization: Course 4 - Exploratory Data Analysis
#  Peer-graded Assignment:  Course 4 Project 1  [Course4Project1]
#  
#  Assignment Requirements / Guidelines:
#  Source data is text file 'household_power_consumption.txt' in working directory
#
#  NOTE: (per instructions in section 'Loading the data')
#  We will only be using data from the dates 2007-02-01 and 2007-02-02. One alternative is to read
#  the data from just those dates rather than reading in the entire dataset and subsetting to those
#  dates.
#
#  Review Criteria
#  1.	Was a valid GitHub URL containing a git repository submitted?
#  2.	Does the GitHub repository contain at least one commit beyond the original fork? 
#  3.	Please examine the plot files in the GitHub repository. Do the plot files appear to be
#     of the correct graphics file format?
#  4.	Does each plot appear correct? 
#  5.	Does each set of R code appear to create the reference plot?
#
#  setwd("/Users/harridw/Development/Coursera/Course4/Course4Project1")  ## Defines my working directory


#  Install packages anticipated to support Course 4 Programming Assignment
install.packages("plyr")
library(plyr)
install.packages("dplyr")
library(dplyr)
install.packages("data.table")
library(data.table)
install.packages("dtplyr")
library(dtplyr)
install.packages("lubridate")
library(lubridate)


################################################
##  Read in text file from working directory  ##
################################################

#  Define directory / folder data (format '.txt') is located
datapath <- getwd()
datafile <- "household_power_consumption.txt"
read_data <- paste(datapath, datafile, sep = "/")

#  Read Electrix Power Consumption text file into R
ElectricPowerConsumption <- data.table(read.table(read_data, sep = ";", dec = ".", na.strings = c("NA", "N/A", "?", "null"),
                                          stringsAsFactors = FALSE, header = TRUE, fill = TRUE, strip.white = FALSE))
ElectricPowerConsumption$X.Date <- dmy(ElectricPowerConsumption$X.Date)

#  Create susbset of original file consistent with target dates for Project 1
subsetDates <- ymd(c("2007-02-01", "2007-02-02"))
subsetEPC <- filter(ElectricPowerConsumption, X.Date %in% subsetDates)

#  Create new variable representing combined date / time to define individual points
subsetEPC$datetime <- as.POSIXct(paste(subsetEPC$X.Date, subsetEPC$Time),
                                 format="%Y-%m-%d %H:%M:%S")

#  Create new variable indicating the day of week that observation reflects
subsetEPC$dayofweek <- c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri","Sat")[as.POSIXlt(subsetEPC$datetime)$wday + 1]


####################################
##  Plot 1:  Global Active Power  ##
####################################

#  Create histogram of Global active power
hist(subsetEPC$Global_active_power, xlab = "Global Active Power (kilowatts", main = "Global Active Power", col = "red")

#  Copy line graph plot of three variables to PNG file
dev.copy(png, file = "Plot1.png")
dev.off()   ## Close device, png is this case, so file can be viewed

