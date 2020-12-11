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

par(mfrow =c(1,1))
with(power_filtered,hist(Global_active_power,col="red",xlab = "Global Active Power (kilowatts)", ylab = "Frequency",main=title("Global Active Power")))

png(filename = "C:/Users/jpesc/Desktop/ExData_Plotting1/plot1.png")
dev.off() 