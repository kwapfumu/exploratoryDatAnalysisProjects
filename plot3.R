#########Scripts that reads into R a dataset from a csv file, draws a plot out of "Sub_metering" values and Date/Time values#####################################
#########and saves it as a png file inside the working directory########################################################################################
plot3 <- function(){
    ##reads the processed data into R from a csv file containing data for 01/02/07 and 02/02/07 dates only and stores it into a data.frame
    rawData <- read.csv("exdata-data-household_power_consumption/processeData.csv")
    ##loads the reshape package
    library(reshape)
    ##renames the "Date" variable
    rawData <- rename(rawData, c(X = "Date"))
    ##changes the type of "Date" varialbe from factor to Date
    rawData$Date <- as.Date(rawData$Date, "%d/%m/%Y")
    # concatenating date and time to convert it to a time format
    xAxis <-paste(rawData$Date,rawData$Time,sep=' ') 
    x <- strptime(xAxis,"%Y-%m-%d %H:%M")
    ##Stores the "Sub_metering" values into a variable y1, y2, y3 respectively
    y1 <- rawData$Sub_metering_1 
    y2 <- rawData$Sub_metering_2 
    y3 <- rawData$Sub_metering_3 
    
    ##opens the screen device on windows
    windows()  
    ##creates a 1st plot and sends it to the screen
    plot(x, y1, type="l", xlab="datetime", ylab="Energy sub metering", col="black")
    ##creates a 2nd plot and sends it to the screen
    lines(x, y2, type="l", col="red")
    ##creates a 2nd plot and sends it to the screen
    lines(x, y3, type="l", col="blue")
    ##add legend 
    legend("topright", inset=0, lty=1, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"))
    ##copies the histogram to a "plot3.png" file inside the working directory
    dev.copy(png, file="plot3.png")
    ##closes the png device
    dev.off()
}