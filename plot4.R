#Read in the electric power consumption dataset from UCI and unzip
#Install library lubridate if not loaded

library(lubridate)

url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
file <- "household_power_consumption"
download.file(url, file)
unzip (file)

# Read data into a table with appropriate classes
hhpower.df <- read.table('household_power_consumption.txt', header=TRUE,
                         sep=';', na.strings='?',
                         colClasses=c(rep('character', 2), 
                                      rep('numeric', 7)))

# Convert dates and times
hhpower.df$Date <- dmy(hhpower.df$Date)
hhpower.df$Time <- hms(hhpower.df$Time)

# Reduce data frame to specified dates
start <- ymd('2007-02-01')
end <- ymd('2007-02-02')
hhpower.df <- subset(hhpower.df, year(Date) == 2007 & 
                       month(Date) == 2 &
                       (day(Date) == 1 | day(Date) == 2))

# Combine date and time
hhpower.df$date.time <- hhpower.df$Date + hhpower.df$Time


# Save plot into plot4.png file

png(filename='plot4.png')

## plot four graphs Top left plot Global Active Power over days, Top right plot Voltage #over days, Bottom left plot Energy sub metering over days and Bottom right plot Global #reactive power over days

par(mfrow=c(2,2))

# Top left
plot(hhpower.df$date.time, hhpower.df$Global_active_power,
     ylab='Global Active Power', xlab='', type='l')

# Top right
plot(hhpower.df$date.time, hhpower.df$Voltage,
     xlab='datetime', ylab='Voltage', type='l')

# Bottom left
plot(hhpower.df$date.time, hhpower.df$Sub_metering_1, type='l',
     xlab='', ylab='Energy sub metering')
lines(hhpower.df$date.time, hhpower.df$Sub_metering_2, col='red')
lines(hhpower.df$date.time, hhpower.df$Sub_metering_3, col='blue')
legend('topright', 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'),
       col=c('black', 'red', 'blue'), 
       lty='solid', bty='n')

# Bottom right
plot(hhpower.df$date.time, hhpower.df$Global_reactive_power,
     xlab='datetime', ylab='Global_reactive_power', type='l')

# Turn off device
dev.off()
