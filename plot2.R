getFilteredDataSet <- function() {
    setwd("~")
    
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="powerConsumption.zip")
    
    unzip("powerConsumption.zip")
    
    power <- read.table("household_power_consumption.txt", header=TRUE,sep=";",stringsAsFactors=FALSE)
    
    power$Date <- as.Date(power$Date, format="%d/%m/%Y")
    
    februaryData <- subset(power, Date == ("2007-02-01") | Date == ("2007-02-02"))
    
    februaryData$Time <- strptime(paste(februaryData$Date, februaryData$Time), format="%Y-%m-%d %H:%M:%S")
    
    februaryData$Global_active_power <- as.numeric(februaryData$Global_active_power)
    
    februaryData
}

februaryData <- getFilteredDataSet()

png(file="plot2.png")

plot(februaryData$Time, februaryData$Global_active_power, type="l", ylab="Global Active Power (kilowatts)", xlab="")

dev.off()