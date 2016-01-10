## Loading the data:
data <- read.table("household_power_consumption.txt",header = TRUE,sep = ";",na.strings = "?",stringsAsFactors = FALSE)
data$Date <- as.Date(data$Date,format="%d/%m/%Y")

## Subsetting the data for using data from the dates 2007-02-01 and 2007-02-02:
datasub <- subset(data,subset = (as.character(Date) %in% c("2007-02-01","2007-02-02")))

## Adding a Datetime column:
datetime <- strptime(paste(datasub$Date,datasub$Time),format = "%d/%m/%Y %H:%M:%S")
datasub$Datetime <- datetime

## Plot1:
global_active_power <- as.numeric(datasub$Global_active_power)
hist(global_active_power,main = "Global Active Power",xlab = "Global Active Power (kilowatts)", ylab = "Frequency",col = "red")

## Saving to file
dev.copy(png, file="Plot1.png", height=480, width=480)
dev.off()