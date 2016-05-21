library(data.table)
library(dplyr)
file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp.dir <- tempdir()
setwd(temp.dir)
download.file(file.url, basename(file.url))
con <- unzip(zipfile = grep(pattern = ".zip", x = list.files(temp.dir), value = TRUE))
#Reads the train and test data provided in the file
activity.labels <- fread("./UCI HAR Dataset/activity_labels.txt")
features <- fread("./UCI HAR Dataset/features.txt")

x_train <- fread("./UCI HAR Dataset/train/X_train.txt")
y_train <- fread("./UCI HAR Dataset/train/y_train.txt")
subject_train <- fread("./UCI HAR Dataset/train/subject_train.txt")

x_test <- fread("./UCI HAR Dataset/test/X_test.txt")
y_test <- fread("./UCI HAR Dataset/test/y_test.txt")
subject_test <- fread("./UCI HAR Dataset/test/subject_test.txt")
unlink(temp.dir, recursive = TRUE)

#Merges the train and test data together 
column.name <- c(as.character(features$V2), "activity", "subject")
test <- cbind(x_test, y_test, subject_test)
colnames(test) <- column.name
train <- cbind(x_train, y_train, subject_train)
colnames(train) <- column.name
one.data <- rbind(test, train)
######Working data 
working.data <- one.data

#Cleanup the environment
rm(test, train, x_train, y_train, x_test, y_test)
rm(subject_test, subject_train)
rm(con, file.url, temp.dir)

#Extract mean and standard deviation
column.select <- grep(pattern = "-[Mm]ean\\(\\)|-[Ss]td\\(\\)",x = column.name)
column.list <- c(column.select, 562, 563)
working.data <- subset(x = working.data, select = column.list)
rm(column.select, column.list)

#Descriptive activity names to name the activities
activity.labels <- as.data.frame(activity.labels)
for(i in 1:nrow(working.data)) {
  row <- working.data$activity[i]
  label <- activity.labels[row, 2]
  working.data$activity[i] <- label
}
rm(activity.labels)

#Use appropriate label for the data
list.of.labels <- names(working.data)
list.of.labels <- gsub(pattern = "\\(\\)", replacement = "", x = list.of.labels)
list.of.labels <- gsub(pattern = "^[Ff]", replacement = "Frequency.", x = list.of.labels)
list.of.labels <- gsub(pattern = "^[Tt]", replacement = "Time.", x = list.of.labels)
list.of.labels <- gsub(pattern = "Acc", replacement = ".Acceleration.", x = list.of.labels)
list.of.labels <- gsub(pattern = "Mag", replacement = "Magnitude", x = list.of.labels)
list.of.labels <- gsub(pattern = "BodyBody", replacement = "Body", x = list.of.labels)
list.of.labels <- gsub(pattern = "-", replacement = ".", x = list.of.labels)
list.of.labels <- gsub(pattern = "\\.\\.", replacement = ".", x = list.of.labels)
colnames(working.data) <- list.of.labels

#Independent tidy dataset with the average of variable
working.data.melt <- melt(working.data, id.vars = c("activity", "subject"))
working.data.dcast <- dcast(working.data.melt, activity + subject ~ variable, mean)

#Sending out the csv file for analysis!
write.csv(working.data.dcast, file = "UCI.tidy.csv")
