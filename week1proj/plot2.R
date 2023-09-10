setwd("~/R for DS/proj1/week1proj")

library(data.table)
library(dplyr)
library(lubridate)

## Read in source data
src <- fread("household_power_consumption.txt", na.strings = "?")

## Concatenate Date and Time variables
Datetime <- paste0(src$Date, "_", src$Time)

## Add Datetime variable to data frame
src <- cbind(src, Datetime)

## Convert the Datetime character column to a Datetime type, convert Date variable
## to Date type and filter to just the two days needed
src <- src %>% mutate(Datetime = dmy_hms(Datetime)) %>% 
    mutate(Date = dmy(Date)) %>% 
    filter(Date >= "2007-02-01" & Date <= "2007-02-02")

## Create plot using the graphics device
plot(src$Datetime, src$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power (kilowatts)")

## Copy plot to .png
dev.copy(png, file = "plot2.png")
dev.off()
