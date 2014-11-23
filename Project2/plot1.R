####Script addressing this quetion: Have total emissions from PM decreased in the United States from 1999 to 2008?############################
##############################################################################################################################################
plot1 <- function(){
    ##reads the dataset into a data.frame. This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008.#########
    NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
    #loads sqldf package and computes the total Emissions per year
    library(sqldf)
    totalEmissionsPerYear <- sqldf("select year, sum(Emissions) as totalEmissions from NEI group by year")
    
    ##Stores the "year" values into a variable x
    x <- factor(totalEmissionsPerYear$year)
    ##Stores the "totalEmissions" values into a variable y
    y <- totalEmissionsPerYear$totalEmissions    
    
    ##opens the screen device on windows
    windows()  
    ##creates a plot and sends it to the screen
    plot(x, y, type="l", main="US PM2.5 Total Emissions from 1999 to 2008", xlab="Year", ylab="Emissions")
    ##copies the plot to a "plot1.png" file inside the working directory
    dev.copy(png, file="plot1.png")
    ##closes the png device
    dev.off()
}
    