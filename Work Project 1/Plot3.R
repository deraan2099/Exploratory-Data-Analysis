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

##Plot 3:
subMetering1 <- as.numeric(datasub$Sub_metering_1)
subMetering2 <- as.numeric(datasub$Sub_metering_2)
subMetering3 <- as.numeric(datasub$Sub_metering_3)
global_active_power <- as.numeric(datasub$Global_active_power)
nsamples <- length(subMetering1)
with(datasub, {
    plot(subMetering1,type = "l",ylab = "Energy sub metering", xlab = "", xaxt = "n")
    lines(subMetering2,type = "l",xlab = "",col = "red")
    lines(subMetering3,type = "l",xlab = "", col = "blue")
    axis(1,at=c(0,ceiling(nsamples/2),nsamples),labels = c("Thu","Fri","Sat"))
})
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, lwd=2.5, col=c("black", "red", "blue"))

## Save to file:
dev.copy(png, file="Plot3.png", height=480, width=480)
dev.off()



