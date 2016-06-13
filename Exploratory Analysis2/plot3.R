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
