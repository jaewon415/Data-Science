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
