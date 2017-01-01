#### R script for Exploratory Analysis Project Plot 2 ####

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
png("plot2.png", width=480, height = 480)
plot(spwc$Global_active_power ~ ymd_hms(paste(spwc$Date,spwc$Time)), type ="l", xlab= "", ylab ="Global Active Power (kilowatts)", lwd=1.5 )

### Close the Display device
dev.off()
