## this R script generate plot2.png for Plotting Assignment 1 for Exploratory Data Analysis

## read data from the file
alldata <- read.table(file = "household_power_consumption.txt", header = TRUE, 
                      sep = ";", colClasses  = c("character", "character", "numeric", 
                                                 "numeric", "numeric", "numeric", "numeric", 
                                                 "numeric", "numeric"), na.strings = "?")
## get the data of the desired date from the full data set
twodaydata <- subset(alldata, (Date == "1/2/2007") | (Date == "2/2/2007"))

## transform the datetime from character to POSIXlt
charTime <- with(twodaydata, paste(Date, Time))
DateTime <- strptime(charTime, format = "%d/%m/%Y %H:%M:%S")

## generate the clean data set for the coming analysis
cleandata <- data.frame(Time = DateTime, 
                        subset(twodaydata, select = Global_active_power:Sub_metering_3))

## open the png graphic device
png(filename = "plot2.png", width = 480, height = 480)

## plot the graph
with(cleandata, plot(Time, Global_active_power, 
                     type = "l", xlab = "", ylab = "Global Active Power (killowatts)"))

## close the png device
dev.off()

