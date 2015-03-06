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

# Plot histogram and save it into a png file

png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "white")

par(mar = c(6, 6, 5, 4))


hist(hhpower.df$Global_active_power, 
                            main="Global Active Power", 
                            xlab="Global Active Power (kilowatts)", 
                            ylab="Frequency", 
                            col="red") 
dev.off()
