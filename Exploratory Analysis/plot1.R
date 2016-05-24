library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, basename(fileUrl))
unzip(zipfile = grep(pattern = ".zip" ,x = list.files(getwd()), value = TRUE))
data <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
data[, 1] <- as.Date(data$Date, format = "%d/%m/%Y")

#Only going to observe the days from 2007/02/01 to 2007/02/02
dataSubset <- subset(x = data, subset = (Date == "2007-02-01" | Date == "2007-02-02"))
working.data <- dataSubset

png(filename = "plot1.png", width = 480, height = 480)
#First Plot 
hist(as.numeric(working.data$Global_active_power), col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")
dev.off()
