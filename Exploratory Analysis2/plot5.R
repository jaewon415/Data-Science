#Question 5.How have emissions from motor vehicle sources changed from 
#1999–2008 in Baltimore City?

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
BaltimoreData <- subset(NEI, fips == "24510" & type == "ON-ROAD")
SCC.Index <- grep("vehicle", SCC$EI.Sector, ignore.case = TRUE)
SCC.Vehicle <- SCC[SCC.Index, ]$SCC

NEI.with.vehicle <- BaltimoreData[BaltimoreData$SCC %in% SCC.Vehicle, ]

png("plot5.png")
graphic.plot <- ggplot(NEI.with.vehicle, mapping = aes(factor(year), Emissions, fill = year))
graphic.plot + geom_bar(stat = "identity") + labs(x = "Year", y = "PM2.5 Emission (tons)",title = "Motor Vehicle PM2.5 Emission in Baltimore City")
dev.off()

#Answer: It looks like the particle matter emitted from the Motor vehicle has decreased in baltimore city from 1999 to 2008



