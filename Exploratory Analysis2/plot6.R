#Question 6.Compare emissions from motor vehicle sources in Baltimore 
#City with emissions from motor vehicle sources in Los Angeles County, 
#California (fips == "06037"). Which city has seen greater changes over 
#time in motor vehicle emissions?

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
BaltimoreData <- subset(NEI,  fips == "24510" & type == "ON-ROAD")
CaliforniaData <- subset(NEI, fips == "06037" & type == "ON-ROAD")

#It looks like the code for SCC.index and SCC.vehicle did not have any impact.
SCC.Index <- grep("vehicle", SCC$EI.Sector, ignore.case = TRUE)
SCC.Vehicle <- SCC[SCC.Index, ]$SCC

Baltimore.vehicle <- BaltimoreData[BaltimoreData$SCC %in% SCC.Vehicle, ]
California.vehicle <- CaliforniaData[CaliforniaData$SCC %in% SCC.Vehicle, ]

Baltimore.vehicle$area <- "Baltimore, MD"
California.vehicle$area <- "Los Angeles, CA"
Baltimore.California <- rbind(Baltimore.vehicle, California.vehicle)

png("plot6.png")
graphic.plot <- ggplot(Baltimore.California, mapping = aes(as.factor(year), Emissions, fill = year))
graphic.plot + geom_bar(stat = "identity")+ facet_grid(.~area) + labs(x ="Year", y = "Emissions", title = "Motor PM2.5 Emission in CA and MD")

dev.off()
#Answer: It appears that california experienced greater change over time in motor
#vehicle emissions
