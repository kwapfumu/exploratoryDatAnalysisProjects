####Script addressing this quetion:How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?###################################
##############################################################################################################################################################
plot5 <- function(){
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
    ##searches for "motor vehicule" dataset
    sccWithVehicle <- sqldf('select * from SCC WHERE "Short.Name" LIKE "%Vehicle%"')
    ##matching SCC numbers
    vehicleSCCs <- sccWithVehicle$SCC
    ##subset Emissions whose values match sccWithVehicle$SCC
    motorVehiclEmissions <- subset(marylandEmissions, SCC%in%vehicleSCCs, select=c(SCC,Emissions, type, year))    
    ##computes total emissions by type and year
    totalEmissionsPerYear <- sqldf('select year,type, sum(Emissions) as totalEmissions from motorVehiclEmissions group by year,type')
    
    ##loads ggplot2package
    library(ggplot2)
    windows()
    p5 <-  qplot(factor(year),totalEmissions, data = totalEmissionsPerYear, facets=.~type)
    finalPlot <- p5 + labs(title="Maryland PM2.5 Total Emissions from motor vehicles sources") + labs(x=expression("Year"),y="Emissions (tons)")
    print(finalPlot)
    ##copies the plot to a "plot5.png" file inside the working directory
    dev.copy(png, file="plot5.png")
    ##closes the png device
    dev.off()
}
