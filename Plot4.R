### This script creates a dataset that can be used to create PLOT 4 for the first project ###
### February 2017 ###

#### STEP 1: DOWNLOAD DATA  ####

fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, destfile="exdata_data_household_power_consumption.zip", method="curl")
unzip("exdata_data_household_power_consumption.zip",overwrite=TRUE)
dateDownloaded <- date()
dateDownloaded

#### STEP 2: SUBSET AND FORMAT DATA ###

data <- read.table("household_power_consumption.txt",header=TRUE,sep=";",na.string="?",stringsAsFactors=FALSE)
data <- subset(data, (data$Date=="1/2/2007"| data$Date=="2/2/2007"),)
data$datetime <- paste(data$Date, data$Time)
data$datetime <- strptime(data$datetime, "%d/%m/%Y %H:%M:%S")
tidydata <- data

### STEP 3: CREATE PLOT 4 ###

png(filename="Plot4.png",width=480, height=480, units="px")
par(mfrow= c(2,2))
plot(data$datetime,data$Global_active_power, type="l", ylab="Global Active Power", xlab="")
plot(data$datetime,data$Voltage, type="l", ylab="Voltage", xlab="datetime")
plot(data$datetime,data$Sub_metering_1, type="n", ylab="Energy sub metering", xlab="", ylim=c(0,30))
points(data$datetime, data$Sub_metering_1, col="black", type="l")
points(data$datetime, data$Sub_metering_2, col="red", type="l")
points(data$datetime, data$Sub_metering_3, col="blue", type="l")
legend("topright", lw=1, col= c("black", "red", "blue"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       box.col = "transparent", cex = 0.90)
plot(data$datetime,data$Global_reactive_power, type="l", ylab="Global Reactive Power", xlab="datetime")
dev.off()
