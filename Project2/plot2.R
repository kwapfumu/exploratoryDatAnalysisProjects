####Script addressing this quetion: Have total emissions from PM decreased in the Baltimore City, Maryland ( fips == "24510" ) from 1999 to 2008?############################
##############################################################################################################################################
plot2 <- function(){
    ##reads the dataset into a data.frame. This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008.#########
    NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
   
     
    #loads sqldf package
    library(sqldf)
    ##subset Emissions from Maryland
    marylandEmissions <- sqldf('select * from NEI where "fips"=="24510"')
    ##computes the total Emissions per year
    totalEmissionsPerYear <- sqldf('select year, sum(Emissions) as totalEmissions from marylandEmissions group by year')
    
    ##Stores the "year" values into a variable x
    x <- factor(totalEmissionsPerYear$year)
    ##Stores the "totalEmissions" values into a variable y
    y <- totalEmissionsPerYear$totalEmissions    
    
    ##opens the screen device on windows
    windows()  
    ##creates a plot and sends it to the screen
    plot(x, y, type="l", main="Plot 2: Maryland PM2.5 Total Emissions per Year", xlab="Year", ylab="Emissions (tons)")
    ##copies the plot to a "plot2.png" file inside the working directory
    dev.copy(png, file="plot2.png")
    ##closes the png device
    dev.off()
}
