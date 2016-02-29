## Load the libraries to use
library(data.table)
library(dplyr)

## Auxiliary file variables
datafolder <- file.path("data")
datazip    <- file.path(datafolder, "data.zip")
datafiles  <- file.path(datafolder, "UCI HAR Dataset")
outputfile <- file.path("tidydata.txt")

#url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"

## Auxiliary function to load the data
get.data <- function(name, folder) {
  read.table(file.path(datafiles, folder, paste0(name, folder, ".txt")))
}

## Create a folder for the data
if (!dir.exists(datafolder)) {
  dir.create(datafolder)
} 

## Download file
#if (!file.exists(datazip)) {
# download.file(url, datazip, method = "curl")
#}

## Extract file contents
#unzip(datazip, exdir = datafolder)

## Read data
names.features  <- get.data("features", "")
labels.activity <- get.data("activity_labels", "")
train.subject   <- get.data("subject_", "train")
train.activity  <- get.data("y_", "train")
train.features  <- get.data("X_", "train")
test.subject    <- get.data("subject_", "test")
test.activity   <- get.data("y_", "test")
test.features   <- get.data("X_", "test")

## Merge the rows of training and test sets
subject    <- rbind(train.subject,  test.subject)
activities <- rbind(train.activity, test.activity)
features   <- rbind(train.features, test.features)


## Put some names to the table columns
names(names.features)  <- c("id", "name")
names(labels.activity) <- c("id", "label")
colnames(activities)   <- "activity"
colnames(subject)      <- "subject"

#to lower case the feature column
names.features$name <- tolower(names.features$name)

#add the mean and std column
mean_std_columns <- grep('-mean\\(|-std\\(', names.features$name)

filtered_dataset <- features[, mean_std_columns]

#Significant column names
names.features$name <- gsub("^t", "time", names.features$name)
names.features$name <- gsub("^f", "frequency", names.features$name)
names(filtered_dataset) <- names.features$name[mean_std_columns]


#Put significant names to the activities
activities$activity = labels.activity[activities$activity, 2]

## Merge the columns of the sets
filtered_dataset <- cbind(filtered_dataset, activities, subject)

## Tidy data
# Make sure there are no NA o NaNs
filtered_dataset <- filtered_dataset[complete.cases(filtered_dataset),]
# Create the factor that will be used to partition the data
filtered_dataset$subject <- as.factor(filtered_dataset$subject)
# Convert into a datatable
filtered_dataset <- data.table(filtered_dataset)

# Split into subsets according to the factors, and calculate the means
tidydata <- aggregate(. ~subject + activity, filtered_dataset, mean)
# Order the data according to subject and activity
tidydata <- tidydata[order(tidydata$subject, tidydata$activity),]

# Write the table to the disk
write.table(x = tidydata, file = outputfile, row.names = FALSE)

