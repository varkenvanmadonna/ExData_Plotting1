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

plot(house2$datetime,house2$Global_active_power,type="n",xlab="",
     ylab="Global Active Power ( kilowatts)",cex.axis=0.7,cex.lab=0.7,font.axis=2,font.lab=2)

lines(house2$datetime,house2$Global_active_power)

#Create the PNG file

png("plot2.png",width=480,height=480)
plot(house2$datetime,house2$Global_active_power,type="n",xlab="",
     ylab="Global Active Power ( kilowatts)",cex.axis=0.7,cex.lab=0.7,font.axis=2,font.lab=2)

lines(house2$datetime,house2$Global_active_power)

dev.off()
