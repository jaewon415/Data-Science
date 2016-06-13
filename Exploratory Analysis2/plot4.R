#Question 4.Across the United States, how have emissions from coal 
#combustion-related sources changed from 1999–2008?

library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

coal.combustion.index <- grep("Fuel Comb.*Coal", SCC$EI.Sector, ignore.case = TRUE)
SCC.Number <- unique(SCC[coal.combustion.index, ]$SCC)

NEI.with.cc <- NEI[NEI$SCC %in% SCC.Number, ]
png("plot4.png")
graphic.plot <- ggplot(NEI.with.cc, mapping = aes(factor(year), Emissions, fill = year))
graphic.plot + geom_bar(stat = "identity") + labs(x = "Year", y = "PM2.5 Emission (tons)",title = "Coal-Combustion-Related PM2.5 IN USA")
dev.off()

#Answer: It looks like the emission fro mthe coal combustion related sources 
#decreased from 1999 to 2008. But we should note that the emission was bit more higher 
#in 2005 than 2002.

