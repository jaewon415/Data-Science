library(data.table)
file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp.dir <- tempdir()
setwd(temp.dir)
file.create("random")
download.file(file.url, "random")
con <- unzip(zipfile = grep(pattern = ".zip", x = list.files(temp.dir), value = TRUE))

activity.labels <- fread("./UCI HAR Dataset/activity_labels.txt")
features <- fread("./UCI HAR Dataset/features.txt")

x_train <- fread("./UCI HAR Dataset/train/X_train.txt")
y_train <- fread("./UCI HAR Dataset/train/y_train.txt")
subject_train <- fread("./UCI HAR Dataset/train/subject_train.txt")

x_test <- fread("./UCI HAR Dataset/test/X_test.txt")
y_test <- fread("./UCI HAR Dataset/test/y_test.txt")
subject_test <- fread("./UCI HAR Dataset/test/subject_test.txt")
unlink(temp.dir)
