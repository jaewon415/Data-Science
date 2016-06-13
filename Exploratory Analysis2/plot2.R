#Question 2.Have total emissions from PM2.5 decreased in the Baltimore City, 
#Maryland (fips == "24510") from 1999 to 2008? Use the base plotting system
#to make a plot answering this question.

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
maryland.data <- subset(NEI, fips == "24510")
total.emission.maryland <- aggregate(Emissions ~ year, maryland.data, sum)

png("plot2.png")
plot(total.emission.maryland$year, total.emission.maryland$Emissions, xlab = "year", ylab = "total emission (tons)", main = "Total PM2.5 Emission in Maryland")
dev.off()

#Answer: Yes, it appears that the emissions had decreased from 1999 to 2008. But
#we should make note that the year 2006 had extremely high pm 2.5 emission than that
#of year 2008.

