getFilteredDataSet <- function() {
    setwd("~")
    
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="powerConsumption.zip")
    
    unzip("powerConsumption.zip")
    
    power <- read.table("household_power_consumption.txt", header=TRUE,sep=";",stringsAsFactors=FALSE)
    
    power$Date <- as.Date(power$Date, format="%d/%m/%Y")
    
    februaryData <- subset(power, Date == ("2007-02-01") | Date == ("2007-02-02"))
    
    februaryData$Time <- strptime(paste(februaryData$Date, februaryData$Time), format="%Y-%m-%d %H:%M:%S")
    
    februaryData$Global_active_power <- as.numeric(februaryData$Global_active_power)

    februaryData$Sub_metering_1 <- as.numeric(februaryData$Sub_metering_1)
    februaryData$Sub_metering_2 <- as.numeric(februaryData$Sub_metering_2)
    februaryData$Sub_metering_3 <- as.numeric(februaryData$Sub_metering_3)
    
    februaryData
}

februaryData <- getFilteredDataSet()

png(file="plot3.png")

plot(februaryData$Time,februaryData$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
points(februaryData$Time, februaryData$Sub_metering_2, type="l", col="red")
points(februaryData$Time, februaryData$Sub_metering_3, type="l", col="blue")

legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

dev.off()