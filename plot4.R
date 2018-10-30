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

#Plot the graph

par(mfrow = c(2, 2),mar = c(4, 0, 1, 0), oma = c(1, 0, 0, 0),cex.axis=0.5,cex.lab=0.6) 
with(house2, {
        plot(datetime,Global_active_power,type="n",xlab="",
             ylab="Global Active Power",
             cex.axis=0.7,cex.lab=0.7,font.axis=2,font.lab=2)
        lines(datetime,Global_active_power)
        
        plot(datetime,Voltage,type="n",xlab="datetime",
             ylab="Voltage",
             cex.axis=0.7,cex.lab=0.7,font.axis=2,font.lab=2)
        lines(datetime,Voltage)
        
        with(house2, plot(datetime, Sub_metering_1,xlab="",ylab="Energy sub metering",
                          cex.axis=0.7,cex.lab=0.7,font.lab=2,font.axis=2, type = "n"))
        with(house2, points(datetime, Sub_metering_1, col = "blue",type="l"))
        with(house2, points(datetime, Sub_metering_2, col = "red",type="l"))
        with(house2, points(datetime, Sub_metering_3, col = "green",type="l"))
        legend("topright", lty=1, col = c("blue", "red","green"), 
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.6)
        plot(datetime,Global_reactive_power,type="n",xlab="datetime",
             ylab="Global_reactive_power",
             cex.axis=0.7,cex.lab=0.7,font.axis=2,font.lab=2)
        lines(datetime,house2$Global_reactive_power)
        
        

})





#Create the PNG file

png("plot4.png",width=480,height=480)
par(mfrow = c(2, 2),mar = c(4, 04, 1, 1), oma = c(1,1 , 1, 1),cex.axis=0.5,cex.lab=0.6) 
with(house2, {
        plot(datetime,Global_active_power,type="n",xlab="",
             ylab="Global Active Power",
             cex.axis=0.7,cex.lab=0.7,font.axis=2,font.lab=2)
        lines(datetime,Global_active_power)
        
        plot(datetime,Voltage,type="n",xlab="datetime",
             ylab="Voltage",
             cex.axis=0.7,cex.lab=0.7,font.axis=2,font.lab=2)
        lines(datetime,Voltage)
        
        with(house2, plot(datetime, Sub_metering_1,xlab="",ylab="Energy sub metering",
                          cex.axis=0.7,cex.lab=0.7,font.lab=2,font.axis=2, type = "n"))
        with(house2, points(datetime, Sub_metering_1, col = "blue",type="l"))
        with(house2, points(datetime, Sub_metering_2, col = "red",type="l"))
        with(house2, points(datetime, Sub_metering_3, col = "green",type="l"))
        legend("topright", lty=1, col = c("blue", "red","green"), 
               legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),cex=0.6)
        plot(datetime,Global_reactive_power,type="n",xlab="datetime",
             ylab="Global_reactive_power",
             cex.axis=0.7,cex.lab=0.7,font.axis=2,font.lab=2)
        lines(datetime,house2$Global_reactive_power)
        
        
})


dev.off()
