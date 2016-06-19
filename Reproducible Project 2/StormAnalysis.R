#setwd("C:/Users/jaewo/Desktop/Reproducible Project 2") #Set your directory
csv.url <- "https://d396qusza40orc.cloudfront.net/repdata%2Fdata%2FStormData.csv.bz2"
dest.file <- "./storm.csv.bz2"
Sys.setlocale("LC_ALL", "English")
if (!file.exists(dest.file)) {
  download.file(csv.url, destfile = dest.file)
  storm <- read.csv(bzfile("storm.csv.bz2"), sep = ",")
  unlink("storm.csv.bz2")
}
if(!any("storm" == ls())) {
  storm <- read.csv(bzfile("storm.csv.bz2"), sep = ",")
  unlink("storm.csv.bz2")
}

library("dplyr")
#Shift from original data to data required for this project.
analysis <- select(storm, EVTYPE, FATALITIES, INJURIES, PROPDMG, 
                   PROPDMGEXP, CROPDMG, CROPDMGEXP)

#HEALTH
fatality.sum <- aggregate(FATALITIES ~ EVTYPE, analysis, sum)
injury.sum <- aggregate(INJURIES ~ EVTYPE, analysis, sum)
injury.fatality.sum <- aggregate(INJURIES + FATALITIES ~ EVTYPE, analysis, sum)

fatality.sum <- fatality.sum[order(fatality.sum$FATALITIES, decreasing = TRUE), ]
injury.sum <- injury.sum[order(injury.sum$INJURIES, decreasing = TRUE), ]
injury.fatality.sum <- injury.fatality.sum[order(injury.fatality.sum$`INJURIES + FATALITIES`, decreasing = TRUE), ]

fatal.graph <- head(fatality.sum, 10)
injur.graph <- head(injury.sum, 10)
if.graph <- head(injury.fatality.sum, 10)

#Health Graph

#install.package("ggplot2")
library("ggplot2")
fatal.graph$EVTYPE <- factor(fatal.graph$EVTYPE, levels = fatal.graph$EVTYPE[order(fatal.graph$FATALITIES, decreasing = TRUE)])
fatal <- ggplot(fatal.graph, mapping = aes(EVTYPE, FATALITIES))
fatal + geom_bar(stat = "identity") + labs(x = "TYPE OF EVENT", y = "Number of Fatalities", title = "Top 10 USA SEVERE WEATHER's HUMAN FATALITIES")
fatal.rankone <- fatal.grapj[1,]

injur.graph$EVTYPE <- factor(injur.graph$EVTYPE, levels = injur.graph$EVTYPE[order(injur.graph$INJURIES, decreasing = TRUE)])
injur <- ggplot(injur.graph, mapping = aes(EVTYPE, INJURIES))
injur + geom_bar(stat = "identity") + labs(x = "TYPE OF EVENT", y = "Number of Injuries", title = "Top 10 USA SEVERE WEATHER's HUMAN INJURIES")
injury.rankone <- injur.graph[1,]

if.graph$EVTYPE <- factor(if.graph$EVTYPE, levels = if.graph$EVTYPE[order(if.graph$`INJURIES + FATALITIES`, decreasing = TRUE)])
if.gg <- ggplot(if.graph, mapping = aes(EVTYPE, `INJURIES + FATALITIES`))
if.gg + geom_bar(stat = "identity") + labs(x = "TYPE OF EVENT", y = "# FATALITY and INJURY", title = "Top 10 USA SEVERE WEATHER IMPACT ON HUMAN")
if.rankone <- if.graph[1,]

#ECONOMY
#Setting up the column solely for property damage cost
analysis$PROPDMGEXP <- tolower(analysis$PROPDMGEXP)
analysis$PROPDMGEXP[analysis$PROPDMGEXP %in% c("", "-", "?", "+")] <- 0
analysis$PROPDMGEXP[analysis$PROPDMGEXP %in% "k"] <- 3
analysis$PROPDMGEXP[analysis$PROPDMGEXP %in% "m"] <- 6
analysis$PROPDMGEXP[analysis$PROPDMGEXP %in% "b"] <- 9
analysis$PROPDMGEXP[analysis$PROPDMGEXP %in% "h"] <- 2
analysis <- transform(analysis, prop.cost = as.numeric(analysis$PROPDMG) * 
                        (10^(as.numeric(analysis$PROPDMGEXP))))

#Setting up the column solely for crop damage cost
analysis$CROPDMGEXP <- tolower(analysis$CROPDMGEXP)
analysis$CROPDMGEXP[analysis$CROPDMGEXP %in% c("", "?")] <- 0
analysis$CROPDMGEXP[analysis$CROPDMGEXP %in% "k"] <- 3
analysis$CROPDMGEXP[analysis$CROPDMGEXP %in% "m"] <- 6
analysis$CROPDMGEXP[analysis$CROPDMGEXP %in% "b"] <- 9
analysis <- transform(analysis, crop.cost = as.numeric(analysis$CROPDMG) * 
                        (10^(as.numeric(analysis$CROPDMGEXP))))

#Total Cost: Property Damage Cost Plus Crop Damage Cost
analysis <- transform(analysis, total.cost = crop.cost + prop.cost)

#ECONOMIC IMPACT
economic.crop <- aggregate(crop.cost ~ EVTYPE, analysis, sum)
economic.prop <- aggregate(prop.cost ~ EVTYPE, analysis, sum) 
economic.total <- aggregate(total.cost ~ EVTYPE, analysis, sum) 

economic.crop <- economic.crop[order(economic.crop$crop.cost, decreasing = TRUE),]
economic.prop <- economic.prop[order(economic.prop$prop.cost, decreasing = TRUE),]
economic.total <- economic.total[order(economic.total$total.cost, decreasing = TRUE),]

economic.crop <- head(economic.crop, 10)
economic.prop <- head(economic.prop, 10)
economic.total <- head(economic.total, 10)

economic.crop$EVTYPE <- factor(economic.crop$EVTYPE, levels = economic.crop$EVTYPE[order(economic.crop$crop.cost, decreasing = TRUE)])
economic.prop$EVTYPE <- factor(economic.prop$EVTYPE, levels = economic.prop$EVTYPE[order(economic.prop$prop.cost, decreasing = TRUE)])
economic.total$EVTYPE <- factor(economic.total$EVTYPE, levels = economic.total$EVTYPE[order(economic.total$total.cost, decreasing = TRUE)])

crop <- ggplot(economic.crop, mapping = aes(EVTYPE, crop.cost))
crop + geom_bar(stat = "identity") + labs(x = "TYPE OF EVENT", y = "Cost of Crop", title = "Top 10 USA SEVERE WEATHER's IMPACT ON CROP")
crop.rankone <- economic.crop[1,]

prop <- ggplot(economic.prop, mapping = aes(EVTYPE, prop.cost))
prop + geom_bar(stat = "identity") + labs(x = "TYPE OF EVENT", y = "Cost of Property", title = "Top 10 USA SEVERE WEATHER's IMPACT ON Property")
prop.rankone <- economic.prop[1,]

total <- ggplot(economic.total, mapping = aes(EVTYPE, total.cost))
total + geom_bar(stat = "identity") + labs(x = "TYPE OF EVENT", y = "Cost of ECONOMICAL DAMAGE", title = "Top 10 USA SEVERE WEATHER's IMPACT ON BOTH PROP AND CROP")
economic.damage.rankone <- economic.total[1,]
