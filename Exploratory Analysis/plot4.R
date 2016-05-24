library(data.table)
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl, basename(fileUrl))
unzip(zipfile = grep(pattern = ".zip" ,x = list.files(getwd()), value = TRUE))
data <- read.table(file = "household_power_consumption.txt", sep = ";", header = TRUE, stringsAsFactors = FALSE)
data[, 1] <- as.Date(data$Date, format = "%d/%m/%Y")

#Only going to observe the days from 2007/02/01 to 2007/02/02
dataSubset <- subset(x = data, subset = (Date == "2007-02-01" | Date == "2007-02-02"))
working.data <- dataSubset

png(filename = "plot4.png", width = 480, height = 480)
#Plot 4
par(mfrow=c(2,2))
date <- strptime(paste(working.data$Date, working.data$Time), format = "%Y-%m-%d %H:%M:%S")
plot(date, as.numeric(working.data$Global_active_power), type = "l", ylab = "Global Active Power (kilowatts)")
plot(date, as.numeric(working.data$Voltage), type = "l", ylab = "Voltage", xlab = "datetime")

plot(date, as.numeric(working.data$Sub_metering_1), type = "l", ylab = "Energy sub metering")
lines(date, as.numeric(working.data$Sub_metering_2), col = "red")
lines(date, as.numeric(working.data$Sub_metering_3), col = "blue")
legend(x = "topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = 1, bty ="n")

plot(date, as.numeric(working.data$Global_reactive_power), type = "l", ylab = "Global_reactive_power", xlab = "datetime")

dev.off()