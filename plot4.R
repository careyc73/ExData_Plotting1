getFilteredDataSet <- function() {
    setwd("~")
    
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="powerConsumption.zip")
    
    unzip("powerConsumption.zip")
    
    power <- read.table("household_power_consumption.txt", header=TRUE,sep=";",stringsAsFactors=FALSE)
    
    power$Date <- as.Date(power$Date, format="%d/%m/%Y")
    
    februaryData <- subset(power, Date == ("2007-02-01") | Date == ("2007-02-02"))
    
    februaryData$Time <- strptime(paste(februaryData$Date, februaryData$Time), format="%Y-%m-%d %H:%M:%S")
    
    februaryData$Global_active_power <- as.numeric(februaryData$Global_active_power)
    februaryData$Global_reactive_power <- as.numeric(februaryData$Global_reactive_power)
    
    februaryData$Sub_metering_1 <- as.numeric(februaryData$Sub_metering_1)
    februaryData$Sub_metering_2 <- as.numeric(februaryData$Sub_metering_2)
    februaryData$Sub_metering_3 <- as.numeric(februaryData$Sub_metering_3)
    februaryData$Voltage <- as.numeric(februaryData$Voltage)
    
    februaryData
}

februaryData <- getFilteredDataSet()

png(file="plot4.png")

par(mfrow=c(2,2))

with(februaryData, {
  plot(Time, Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(Time, Voltage, type="l", xlab="datetime", ylab="Voltage")
  plot(Time, Sub_metering_1, type="l", xlab="", ylab="Energy sub metering")
    points(Time, Sub_metering_2, type="l", col="red")
    points(Time, Sub_metering_3, type="l", col="blue")
    legend("topright", col=c("black", "red", "blue"), bty="n", lty=1, lwd=2, legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
  plot(Time, Global_reactive_power, type="l", xlab="datetime", ylab="Global Reactive Power")
})

dev.off()