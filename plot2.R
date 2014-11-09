#########Scripts that reads into R a dataset from a csv file, draws a plot out of "Global Active Power" values and Date/Time values#####################################
#########and saves it as a png file inside the working directory########################################################################################
plot2 <- function(){
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
    ##Stores the "Global active power" values into a variable y
    y <- rawData$Global_active_power    
    
    ##opens the screen device on windows
    windows()  
    ##creates a histogram and sends it to the screen
    plot(x, y, type="l", main="Plot 2",xlab=" ", ylab="Global Active Power (kilowatts)")
    ##copies the histogram to a "plot2.png" file inside the working directory
    dev.copy(png, file="plot2.png")
    ##closes the png device
    dev.off()
}