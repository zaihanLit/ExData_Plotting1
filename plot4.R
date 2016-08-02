## this R script generate plot4.png for Plotting Assignment 1 for Exploratory Data Analysis

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
png(filename = "plot4.png", width = 480, height = 480)

## set the mfrow
par(mfrow = c(2, 2))

## plotting the topleft graph
with(cleandata, plot(Time, Global_active_power, 
                     type = "l", xlab = "", ylab = "Global Active Power"))

## plotting the topright graph
with(cleandata, plot(Time, Voltage,
                     type = "l", xlab = "datetime", ylab = "Voltage"))

## plotting the bottomleft graph
with(cleandata, plot(Time, Sub_metering_1,
                     type = "l", xlab = "", ylab = "Energy sub metering"))

with(cleandata, lines(Time, Sub_metering_2, type = "l", col = "red"))

with(cleandata, lines(Time, Sub_metering_3, type = "l", col = "blue"))

legend("topright", bty = "n", lty = 1, lwd = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       col = c("black", "red", "blue"), cex = 0.9)

## plotting the bottomright graph
with(cleandata, plot(Time, Global_reactive_power,
                     type = "l", xlab = "datetime", ylab = "Global_reactive_power"))

##close the graphic device
dev.off()
