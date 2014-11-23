####Script addressing this quetion:How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?###################################
##############################################################################################################################################################
plot6 <- function(){
    ##reads the dataset into a data.frame. This file contains a data frame with all of the PM2.5 emissions data for 1999, 2002, 2005, and 2008.#########
    NEI <- readRDS("exdata-data-NEI_data/summarySCC_PM25.rds")
    ##reads the dataset into a data.frame. This table provides a mapping from the SCC digit strings int he Emissions table to the actual name of the PM source.
    SCC <- readRDS("exdata-data-NEI_data/Source_Classification_Code.rds")
    SCC$SCC <- as.character(SCC$SCC)
    SCC$Short.Name <- as.character(SCC$Short.Name)
    
    ##loads sqldf package 
    library(sqldf)
    ##subset Emissions from Maryland
    marylandEmissions <- sqldf('select * from NEI where "fips"=="24510"')
    ##subset Emissions from Los Angeles County,
    lAcountyEmissions <- sqldf('select * from NEI where "fips"=="06037"')
    ##searches for "motor vehicule" dataset
    sccWithVehicle <- sqldf('select * from SCC WHERE "Short.Name" LIKE "%Vehicle%"')
    ##matching SCC numbers
    vehicleSCCs <- sccWithVehicle$SCC
    ##subset Emissions whose values match sccWithVehicle$SCC
    marylandMotorVehiclEmissions <- subset(marylandEmissions, SCC%in%vehicleSCCs, select=c(SCC,Emissions, type, year)) 
    lAcountyMotorVehiclEmissions <- subset(lAcountyEmissions, SCC%in%vehicleSCCs, select=c(SCC,Emissions, type, year))
    ##computes total emissions by type and year in maryland
    marylandTotalEmissionsPerYear <- sqldf('select year,type, sum(Emissions) as totalEmissions from marylandMotorVehiclEmissions group by year,type')
    ##computes total emissions by type and year in Los Angeles County
    lAcountyTotalEmissionsPerYear <- sqldf('select year,type, sum(Emissions) as totalEmissions from lAcountyMotorVehiclEmissions group by year,type')
    
    ##loads ggplot2package
    library(ggplot2)
    windows()
    mPlot <-  qplot(factor(year),totalEmissions, data = marylandTotalEmissionsPerYear, facets=.~type)
    marylandPlot <- mPlot + labs(title="Maryland PM2.5 Total Emissions") + labs(x=expression("Year"),y="Emissions (tons)")
    laPlot <-  qplot(factor(year),totalEmissions, data = lAcountyTotalEmissionsPerYear, facets=.~type)
    laCountyPlot <- laPlot + labs(title="LA County PM2.5 Total Emissions") + labs(x=expression("Year"),y="Emissions (tons)")
    
    library(gridExtra)
    grid.arrange(marylandPlot,laCountyPlot,ncol=2)
    ##copies the plot to a "plot6.png" file inside the working directory
    dev.copy(png, file="plot6.png")
    ##closes the png device
    dev.off()
}
