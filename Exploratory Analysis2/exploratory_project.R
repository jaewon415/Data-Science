#Read RDS file
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#fips: Five digit number indicating the US county (Character)
#SCC: The name of the source indicated by the digit (Character)
#Pollutant: (Character)
#Emission: Amount of PM2.5 emitted (tons), (numeric)
#type: road, on-road, point, non-point (Character)
#year: observation recorded year (integer)
head(NEI)
head(SCC)

#Question 1.Have total emissions from PM2.5 decreased in the United States 
#from 1999 to 2008? Using the base plotting system, make a plot showing 
#the total PM2.5 emission from all sources for each of the years 1999, 2002
#2005, and 2008.
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

data1999 <- subset(NEI, year == 1999)
total1999 <- sum(data1999$Emissions)

data2002 <- subset(NEI, year == 2002)
total2002 <- sum(data2002$Emissions)

data2005 <- subset(NEI, year == 2005)
total2005 <- sum(data2005$Emissions)

data2008 <- subset(NEI, year == 2008)
total2008 <- sum(data2008$Emissions)

png("plot1.png")
year.emission <- data.frame(year = c(1999, 2002, 2005, 2008), Total.Emission = c(total1999, total2002, total2005, total2008))
plot(year.emission$year, year.emission$Total.Emission, xlab = "Year", ylab = "Total Emission (tons)", main = "USA PM2.5 Total Emission")
dev.off()

#Answer: Yes, as we observe from the graph, we see that the total emission has
#decreased from 1999 to 2008




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




#Question 3.Of the four types of sources indicated by the type 
#(point, nonpoint, onroad, nonroad) variable, which of these four sources 
#have seen decreases in emissions from 1999–2008 for Baltimore City? Which 
#have seen increases in emissions from 1999–2008? Use the ggplot2 plotting 
#system to make a plot answer this question.

#install.packages("ggplot2")
library(ggplot2)
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
maryland.data <- subset(NEI, fips == "24510")

png("plot3.png")
graphic.plot <- ggplot(maryland.data, mapping = aes(factor(year), Emissions, fill = type))
graphic.plot + geom_bar(stat = "identity")+facet_grid(. ~type) + labs(x = "Year", y = "PM2.5 Emissions (tons)", title = "Four types of sources")
dev.off()

#Answer: All sources except for point illustrates the decrease in emission form
#1999 to 2008 for Baltimore City. There was increase in type "point" only in 1999 to 2005, then the 
#emission dropped.



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

