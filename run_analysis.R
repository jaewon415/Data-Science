file.url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
tempfile <- tempfile()
downloaded <- download.file(file.url, tempfile)
