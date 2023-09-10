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

## Set up dimensions of multiple plots
par(mfrow = c(2,2))

## Create top left plot
plot(src$Datetime, src$Global_active_power, type = "l",
     xlab = "", ylab = "Global Active Power")

## Create top right plot
plot(src$Datetime, src$Voltage, type = "l",
     xlab = "datetime", ylab = "Voltage")

## Create bottom left plot
plot(src$Datetime, src$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
points(src$Datetime, src$Sub_metering_2, type = "l", col = "red")
points(src$Datetime, src$Sub_metering_3, type = "l", col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty = 1, 
       col = c("black", "red", "blue"), bty = "n")

## Create bottom right plot
plot(src$Datetime, src$Global_reactive_power, type = "l",
     xlab = "datetime", ylab = "Global_reactive_power")

## Copy plot to .png
dev.copy(png, file = "plot4.png")
dev.off()
