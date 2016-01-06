#download file
if (!file.exists("./Fhousehold_power_consumption.zip")) {
    download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", "Fhousehold_power_consumption.zip" )
    unzip("Fhousehold_power_consumption.zip")
    
}

#load data
hpc <- read.table("household_power_consumption.txt",header=TRUE,sep=";")

#new row with real dates
hpc$Date2 <- as.Date(hpc$Date,"%d/%m/%Y")

#Dates to search
date07<- as.Date(c("01/02/07","02/02/07"),"%d/%m/%y")

#Subset
sub_hpc<-subset(hpc, Date2 %in% date07)

#new row with date time
sub_hpc$DateTime <- paste(sub_hpc$Date,sub_hpc$Time)
sub_hpc$DateTime <- strptime(sub_hpc$DateTime,"%d/%m/%Y %H:%M:%S")

#prepare data
sub_hpc$Sub_metering_1<-as.numeric(as.character(sub_hpc$Sub_metering_1))
sub_hpc$Sub_metering_2<-as.numeric(as.character(sub_hpc$Sub_metering_2))
sub_hpc$Sub_metering_3<-as.numeric(as.character(sub_hpc$Sub_metering_3))

#reset parameters
plot.new()

#print
Sys.setlocale("LC_TIME", "English")
png(filename = "assignment1/ExData_Plotting1/plot3.png", width = 480, height = 480, units = "px")
plot(sub_hpc$DateTime,sub_hpc$Sub_metering_1,type="n" ,xlab = NA ,ylab="Energy Sub Metering")
lines(sub_hpc$DateTime,sub_hpc$Sub_metering_1,type="l" )
lines(sub_hpc$DateTime,sub_hpc$Sub_metering_2,type="l" ,col="red")
lines(sub_hpc$DateTime,sub_hpc$Sub_metering_3,type="l" ,col="blue")

## Add Legend
legend("topright",legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       text.col=c("black","black","black"),pch=c("-","-","-"),col=c("black","red","blue") )

dev.off()