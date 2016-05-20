file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
temp.dir <- tempdir()
setwd(temp.dir)
downloaded <- download.file(file.url, basename(file.url))
unzip <- unzip(zipfile = downloaded)
read.table(file = "/UCI HAR Dataset/activity_labels.txt")

downloaded <- download.file(file.url, temp.dir(tempfile()))
tempfile <- tempfile()
downloaded <- download.file(file.url, tempfile)

