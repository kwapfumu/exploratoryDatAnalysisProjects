#########Scripts that reads into R a dataset from a csv file, draws a plot out of "Sub_metering" values and Date/Time values#####################################
#########and saves it as a png file inside the working directory########################################################################################
plot4 <- function(){
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
    y1 <- rawData$Global_active_power 
    y2 <- rawData$Voltage 
    y31 <- rawData$Sub_metering_1 
    y32 <- rawData$Sub_metering_2 
    y33 <- rawData$Sub_metering_3
    y4 <- rawData$Global_reactive_power
    
    ##opens the screen device on windows
    windows()  
    
    opar <- par(no.readonly=TRUE)
    par(mfrow=c(2,2), mar=c(4,4,3,2), oma = c(0,0,2,0))
    
    ##creates a 1st plot and sends it to the screen
    plot(x, y1, type="l", xlab=" ", ylab="Global Active Power", col="black")
    
    ##creates a 2nd plot and sends it to the screen
    plot(x, y2, type="l", xlab="datetime", ylab="Voltage", col="black")
    
    ##creates a 3rd plot and sends it to the screen
    plot(x, y31, type="l", xlab=" ", ylab="Energy sub metering", col="black")
    ##creates a 2nd plot and sends it to the screen
    lines(x, y32, type="l", col="red")
    ##creates a 2nd plot and sends it to the screen
    lines(x, y33, type="l", col="blue")
    ##add legend 
    legend("topright", inset=0, lty=1, c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black","red","blue"))
    ##copies the histogram to a "plot3.png" file inside the working directory
    
    ##creates a 4th plot and sends it to the screen
    plot(x, y4, type="l", xlab="datetime", ylab="Global Reactive Power", col="black")
    
    mtext("Plot 4", outer =TRUE)
    
    par(opar)
        
    dev.copy(png, file="plot4.png")
    ##closes the png device
    dev.off()
}