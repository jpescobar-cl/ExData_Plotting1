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

par(mfrow =c(1,1))
with(power_filtered,plot(Time,Global_active_power,type = "l",xlab = "",ylab = "Global Active Power (kilowatts)"))

png(filename = "C:/Users/jpesc/Desktop/ExData_Plotting1/plot2.png")
dev.off()
