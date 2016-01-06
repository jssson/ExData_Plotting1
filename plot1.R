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
sub_hpc$Global_active_power[sub_hpc$Global_active_power=="?"]<-NA
sub_hpc$Global_active_power<-as.numeric(as.character(sub_hpc$Global_active_power))

#reset parameters
plot.new()

#print
png(filename = "assignment1/ExData_Plotting1/plot1.png", width = 480, height = 480, units = "px")
hist(sub_hpc$Global_active_power,xlab = "Global Active Power (kilowatts)", main = "Global Active Power", col = "red" )
dev.off()
