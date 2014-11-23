####Script addressing this quetion: Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?########################
##############################################################################################################################################################
plot4 <- function(){
    ##reads the dataset into a data.frame. This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008.#########
    NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
    ##reads the dataset into a data.frame. This table provides a mapping from the SCC digit strings int he Emissions table to the actual name of the PM source.
    SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
    SCC$SCC <- as.character(SCC$SCC)
    
    #loads sqldf package 
    library(sqldf)
    ##searches for COAL dataset
    eiSectorWithCoal <- sqldf('select * from SCC WHERE "EI.Sector" LIKE "%Coal%" OR ("EI.Sector" LIKE "%Fuel Comb%" AND "SCC.Level.Three" LIKE "%Coal%")')
    ##matching SCC numbers
    coalSCCs <- eiSectorWithCoal$SCC
    ##subset Emissions whose values match eiSectorWithCoal$SCC
    coalemissions <- subset(NEI, SCC%in%coalSCCs, select=c(SCC,Emissions, type, year))
    ##computes total emissions by type and year
    totalEmissionsPerYear <- sqldf('select year,type, sum(Emissions) as totalEmissions from coalemissions group by year,type')
    
    #loads ggplot2 package 
    library(ggplot2)
    windows()
    p4 <-  qplot(factor(year),totalEmissions, data = totalEmissionsPerYear, facets=.~type)
    finalPlot <- p4 + labs(title="US PM2.5 Total Emissions from coal combustion-related sources") + labs(x=expression("Year"),y="Emissions (tons)")
    print(finalPlot)
    ##copies the plot to a "plot4.png" file inside the working directory
    dev.copy(png, file="plot4.png")
    ##closes the png device
    dev.off()
}
