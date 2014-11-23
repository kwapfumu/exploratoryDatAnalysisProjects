####Script addressing this quetion: Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, which######################
######of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? Which have seen increases in emissions from 1999-2008?############################
##############################################################################################################################################
plot3 <- function(){
    ##reads the dataset into a data.frame. This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008.#########
    NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
    
    #loads sqldf package 
    library(sqldf)
    ##subset Emissions from Maryland
    marylandEmissions <- sqldf('select * from NEI where "fips"=="24510"')
    ##computes the total Emissions per year
    totalEmissionsPerYear <- sqldf('select year,type, sum(Emissions) as totalEmissions from marylandEmissions group by year,type')
    
    library(ggplot2)
    windows()
    p3 <-  qplot(factor(year),totalEmissions, data = totalEmissionsPerYear, facets=.~type)
    finalPlot <- p3 + labs(title="Maryland PM2.5 Total Emissions by source and per Year") + labs(x=expression("Year"),y="Emissions (tons)")
    print(finalPlot)
    ##copies the plot to a "plot3.png" file inside the working directory
    dev.copy(png, file="plot3.png")
    ##closes the png device
    dev.off()
}
