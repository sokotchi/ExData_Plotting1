Sys.setlocale("LC_TIME", "C")

##-----------------
## Loading the data
##-----------------

## Download and unzip the zip file
if(!file.exists("./data")){
  dir.create("./data")
  fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  download.file(fileUrl, destfile="./data/zipdata.zip", method="curl")
  unzip(zipfile="./data/zipdata.zip", exdir="./data")
}
## Read the household electric power consumption from the folder
PowerConsumption <- read.table(file = "./data/household_power_consumption.txt", header = TRUE, sep = ";", na.strings = c("?"))
## Concatenate Date and Time to create a Date/Time variable
PowerConsumption$DateTime <- paste(PowerConsumption$Date, PowerConsumption$Time)
## Convert to a datetime format
PowerConsumption$DateTime <- strptime(PowerConsumption$DateTime, "%d/%m/%Y %H:%M:%S", tz = "Europe/Paris")
## Select data between 2007-02-01 and 2007-02-02
PowerConsumption <- PowerConsumption[(as.Date(PowerConsumption$DateTime, "%Y-%m-%d") == "2007-02-01" | as.Date(PowerConsumption$DateTime, "%Y-%m-%d") == "2007-02-02"),]
## Select and reorder columns
PowerConsumption <- PowerConsumption[c("DateTime", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")]

##-----------------------
## Making Plot: plot1.png
##-----------------------
png(filename = "plot1.png", width = 480, height = 480, units = "px")
hist(PowerConsumption$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", ylab = "Frequency")
dev.off()

