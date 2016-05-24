data <- read.csv("./PM25data/data/avgpm25.csv", colClasses = c("numeric", "character", "factor", "numeric", "numeric"))
summary(data$pm25)

boxplot(data$pm25, col = "blue")
hist(data$pm25, col = "green")
rug(data$pm25)
abline(v = 12, lwd = 2, col = "red")
abline(v = median(data$pm25), lwd = 2, col = "MAGENTA")

table(data$region)
barplot(table(data$region), col = "wheat", main = "Region")

boxplot(pm25 ~ region, data = data, col = "red")
abline(h = 12, lwd = 3, col = "green")

#Two graphs in a row 
#Bottom left top right
par(mfrow = c(2, 1), mar = c(4, 4, 2, 1))
hist(x = subset(data, region == "east")$pm25, col = "green")
hist(x = subset(data, region == "west")$pm25, col = "green")

with(data, plot(latitude, pm25, col = region))
abline(h = 12, lty = 2, lwd = 2)

par(mfrow = c(1, 2), mar = c(5, 4, 2, 1))
with(data = subset(x = data, subset = region == "west"), plot(latitude, pm25, main = "WEST"))
with(data = subset(x = data, subset = region == "east"), plot(latitude, pm25, main = "EAST"))

airquality <- transform(airquality, Month = factor(Month))
class(airquality$Month)
boxplot
boxplot(Ozone ~ Month, airquality)
