#Get the file

house<-read.csv("household_power_consumption.txt",sep=";",header=T)

#take out the "?"
house<-subset(house,Global_active_power!="?")

#setting the classes right_I admit_not in an elegant way
house$Global_active_power<-as.numeric(as.character(house$Global_active_power))
house$Global_reactive_power<-as.numeric(as.character(house$Global_reactive_power))
house$Voltage<-as.numeric(as.character(house$Voltage))
house$Global_intensity<-as.numeric(as.character(house$Global_intensity))
house$Sub_metering_2<-as.numeric(as.character(house$Sub_metering_2))
house$Sub_metering_1<-as.numeric(as.character(house$Sub_metering_1))

#Adapt the dates
library(chron)
house$Time<-times(house$Time)
library(lubridate)
house$Date<-dmy(house$Date)

#subsetting house into the subset we need
house2<-house[house$Date=="2007-02-01" |house$Date=="2007-02-02",]

# Get a datetime field for the plot 

Sys.setenv(TZ="Europe/Brussels")
house2$datetime <- as.POSIXct(paste(house2$Date,house2$Time),tz="Europe/Brussels")

#Plot the line graph

with(house2, plot(datetime, Sub_metering_1,xlab="",ylab="Energy sub metering",
                  cex.axis=0.6,cex.lab=0.7, type = "n"))
with(house2, points(datetime, Sub_metering_1, col = "blue",type="l"))
with(house2, points(datetime, Sub_metering_2, col = "red",type="l"))
with(house2, points(datetime, Sub_metering_3, col = "green",type="l"))
legend("topright", lty=1, col = c("blue", "red","green"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.5)


#Create the PNG file

png("plot3.png",width=480,height=480)
with(house2, plot(datetime, Sub_metering_1,xlab="",ylab="Energy sub metering" 
                  ,cex.axis=0.8,cex.lab=0.8, type = "n"))
with(house2, points(datetime, Sub_metering_1, col = "blue",type="l"))
with(house2, points(datetime, Sub_metering_2, col = "red",type="l"))
with(house2, points(datetime, Sub_metering_3, col = "green",type="l"))
legend("topright", lty=1, col = c("blue", "red","green"), 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.8)

dev.off()
