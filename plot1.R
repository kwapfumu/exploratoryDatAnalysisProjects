#########Scripts that reads into R a dataset from a csv file, draws a histogram out of "Global Active Power" values#####################################
#########and saves it as a png file inside the working directory########################################################################################
plot1 <- function(){
    ##reads the processed data into R from a csv file containing data for 01/02/07 and 02/02/07 dates only and stores it into a data.frame
    rawData <- read.csv("exdata-data-household_power_consumption/processeData.csv")
    ##loads the reshape package
    library(reshape)
    ##renames the "Date" variable
    rawData <- rename(rawData, c(X = "Date"))
    ##changes the type of "Date" varialbe from factor to Date
    rawData$Date <- as.Date(rawData$Date, "%d/%m/%Y")
    ##Stores the "Global active power" values into a variable x
    x <- rawData$Global_active_power
    ##opens the screen device on windows
    windows()
    ##creates a histogram and sends it to the screen
    hist(x, xlab="Global Active Power(kilowatts)", main="Global Active Power", col="red")
    ##copies the histogram to a "plot1.png" file inside the working directory
    dev.copy(png, file="plot1.png")
    ##closes the png device
    dev.off()
}