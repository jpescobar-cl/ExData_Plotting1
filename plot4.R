url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url,"./data/power.zip",mode = "wb")
unzip(zipfile = "./data/power.zip",exdir = "./data")
power <- read.table("./data/household_power_consumption.txt",header = TRUE,sep = ";")
cols <- c(3:8)
for(i in cols){
    class(power[,i])="numeric"
}

library(data.table)
library(lubridate)
library(dplyr)
library(datasets)

parse_date_time(power$Date,orders = "dmy")
power$Date <- as.Date(power$Date,"%d/%m/%Y")
power$Time <- as.ITime(power$Time)
power$Time <- as.POSIXct(power$Time)

power_filtered <- filter(power,Date >="2007-02-01" & Date <= "2007-02-02")

power_filtered[1:1440,"Time"]       <- format(power_filtered[1:1440,"Time"],"2007-02-01 %H:%M:%S")
power_filtered[1441:2880,"Time"]    <- format(power_filtered[1441:2880,"Time"],"2007-02-02 %H:%M:%S")

par(mfrow =c(2,2))
#top left quadrant
plot(power_filtered$Time,power_filtered$Global_active_power,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)")
#top right quadrant
plot(power_filtered$Time,power_filtered$Voltage,type = "l",xlab = "datetime",ylab = "Voltage")
#bottom left quadrant
plot(power_filtered$Time,power_filtered$Sub_metering_1,type = "n",xlab = "",ylab = "Energy sub metering")
with(power_filtered,lines(Time,Sub_metering_1,type = "l"))
with(power_filtered,lines(Time,Sub_metering_2,type = "l",col="red"))
with(power_filtered,lines(Time,Sub_metering_3,type = "l",col="blue"))
legend("topright",lty=1,col = c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))
#bottom right quadrant
plot(power_filtered$Time,power_filtered$Global_reactive_power,type = "l",xlab = "datetime", ylab = "Global_reactive_power")

png(filename = "C:/Users/jpesc/Desktop/ExData_Plotting1/plot4.png")
dev.off()