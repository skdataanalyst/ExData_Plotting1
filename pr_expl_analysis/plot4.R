#### R script for Exploratory Analysis Project Plot 1 ####

####### The below code is commented as its being considered
####### that the file is already downloaded and present in 
#######current working directory

##dir.create("./pr_expl_analysis")
##fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
##download.file(fileUrl, destfile = "./power_consump.zip")
##unzip("./power_consump.zip")

###### Read File as a data frame #####
power_consump <- read.table("./household_power_consumption.txt",header = TRUE, sep=";", na.strings = "?")

## Invoke lubridate library to use the date and Time functions
library(lubridate)

power_consump$Date <- dmy(power_consump$Date)

## Subset the data for the requested dates

spwc <- subset(power_consump, Date == ymd("2007-02-01")|Date == ymd("2007-02-02"))

### Open the png file and plot the hist
png("plot4.png", width=480, height = 480)
par(mfrow=c(2,2))
plot(spwc$Global_active_power ~ ymd_hms(paste(spwc$Date,spwc$Time)), type ="l", xlab= "", ylab ="Global Active Power (kilowatts)", lwd=1.5 )
plot(spwc$Voltage ~ ymd_hms(paste(spwc$Date,spwc$Time)), type ="l", xlab= "datetime", ylab ="Voltage", lwd=1.5 )
plot(spwc$Sub_metering_1 ~ ymd_hms(paste(spwc$Date,spwc$Time)), type ="l", xlab= "", ylab ="Energy Sub metering")
points(spwc$Sub_metering_2 ~ ymd_hms(paste(spwc$Date,spwc$Time)), type ="l", col="red")
points(spwc$Sub_metering_3 ~ ymd_hms(paste(spwc$Date,spwc$Time)), type ="l", col="blue")
legend("topright",col=c("black","blue", "red"),legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), lwd=c(1,1,1), lty=c(1,1,1),cex=1.0,bty="n" )
###legend("topright",col=c("black","blue", "red"),legend = c("Sub_Metering_1", "Sub_Metering_2", "Sub_Metering_3"), lwd=c(1,1,1), lty=c(1,1,1),cex=0.25 )
plot(spwc$Global_reactive_power ~ ymd_hms(paste(spwc$Date,spwc$Time)), type ="l", xlab= "datetime", ylab ="Global_reactive_power", lwd=1.0 )

### Close the Display device
dev.off()
