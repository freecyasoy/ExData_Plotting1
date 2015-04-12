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

## Plotting....
hist(data$Global_active_power, main="Global Active Power", 
     xlab="Global Active Power (kilowatts)", ylab="Frequency", col="Red")

## Saving to as png file.
dev.copy(png, file="Plot1.png", height=480, width=480)
dev.off()