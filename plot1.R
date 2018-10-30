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

# Generate the plot 

hist(house2$Global_active_power,col="red",main = "Global Active Power",
     font.axis=1,cex.axis=0.6,xlab="Global Active Power(kilowatts)",
     cex.lab=0.5,font.lab=1,cex.main=0.8)

#Create the PNG file

png("plot1.png",width=480,height=480)
hist(house2$Global_active_power,col="red",main = "Global Active Power",
     font.axis=1,cex.axis=0.6,xlab="Global Active Power(kilowatts)",
     cex.lab=0.5,font.lab=1,cex.main=0.8)
dev.off()
