## Reading the data from a "data" subdirectory
data_complete <- read.csv("./Data/household_power_consumption.txt", header=T, sep=';', na.strings="?", 
                          nrows=2075259, check.names=F, stringsAsFactors=F, comment.char="", quote='\"')
data_complete$Date <- as.Date(data_complete$Date, format="%d/%m/%Y")

## Getting the subset of the data for date range 2007-02-01 to 2007-02-02
data <- subset(data_complete, subset=(Date >= "2007-02-01" & Date <= "2007-02-02"))
## removing data_complete as "data" will now be used moving forward. 
rm(data_complete)

## Converting the dates
datetime <- paste(as.Date(data$Date), data$Time)
data$Datetime <- as.POSIXct(datetime)

## Plotting...
with(data, {
    plot(Sub_metering_1~Datetime, type="l",
         ylab="Global Active Power (kilowatts)", xlab="")
    lines(Sub_metering_2~Datetime,col='Red')
    lines(Sub_metering_3~Datetime,col='Blue')
})
legend("topright", col=c("black", "red", "blue"), lty=1, lwd=2, 
       legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

##Saving as png file.
dev.copy(png, file="Plot3.png", height=480, width=480)
dev.off()