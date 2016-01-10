## Loading the data:
data <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?",stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date,format="%d/%m/%Y")

## Subsetting the data for using data from the dates 2007-02-01 and 2007-02-02:
datasub <- subset(data,subset = (as.character(Date) %in% c("2007-02-01","2007-02-02")))

## Adding a Datetime column:
datetime <- strptime(paste(datasub$Date,datasub$Time),format = "%d/%m/%Y %H:%M:%S")
datasub$Datetime <- datetime

## Adding a column with the weekdays:
day <- weekdays(datasub$Date,abbreviate = TRUE)
datasub$Weekday <- day

##Plot 4:
subMetering1 <- as.numeric(datasub$Sub_metering_1)
subMetering2 <- as.numeric(datasub$Sub_metering_2)
subMetering3 <- as.numeric(datasub$Sub_metering_3)
global_active_power <- as.numeric(datasub$Global_active_power)
global_reactive_power <- as.numeric(datasub$Global_reactive_power)
voltage <- as.numeric(datasub$Voltage)
nsamples <- length(subMetering1)
par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
with(data, {
    plot(global_active_power, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="",xaxt = "n")
    axis(1,at=c(0,ceiling(nsamples/2),nsamples),labels = c("Thu","Fri","Sat"))
    plot(voltage, type="l", 
         ylab="Voltage (volt)", xlab="datetime",xaxt="n")
    axis(1,at=c(0,ceiling(nsamples/2),nsamples),labels = c("Thu","Fri","Sat"))
    plot(subMetering1, type="l", 
         ylab="Global Active Power (kilowatts)", xlab="",xaxt="n")
    lines(subMetering2,col='Red')
    lines(subMetering3,col='Blue')
    legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, bty="n",
           legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
    axis(1,at=c(0,ceiling(nsamples/2),nsamples),labels = c("Thu","Fri","Sat"))
    plot(global_reactive_power, type="l", 
         ylab="Global Rective Power (kilowatts)",xlab="datetime",xaxt="n")
    axis(1,at=c(0,ceiling(nsamples/2),nsamples),labels = c("Thu","Fri","Sat"))
})

#Save to file:
dev.copy(png, file="Plot4.png", height=480, width=480)
dev.off()

