# Getting and Cleaning Data - Week 4 Assignment

The idea behind this document is to give an overview of the transformations,
filters and other actions done to the dataset in order to obtain a new tidy
dataset.

## Dataset Description *

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

* This text was taken from the original description of the dataset

#### Download locations

* [Data ](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip)
* [Data Description ](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

## What were the tasks?

1. Merge the training and test sets to create one data set
1. Extract the measurements on the mean and standard deviation
1. Use descriptive activity names to name the activities in the data set
1. Label the data set with descriptive variable names
1. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject

## What does the code do?

This will not specify the implementation, it will simply give a general description of the process, if you want a detailed description, refer to the run_analysis.R file which contains line by line comments.

## Variables
The __raw__ data will be stored in the following variables:

  Variable Name    |          File
:-----------------:|:-----------------------:
names.features     |features.txt
labels.activity    |activity_labels.txt
train.subject      |train/subject_train.txt
train.activity     |train/y_train.txt
train.features     |train/X_train.txt
test.subject       |test/subject_test.txt
test.activity      |test/y_test.txt
test.features      |test/X_test.txt

After the initial data loading then the training and test data are vertically
merged in the following variables:

Variable Name |        Variables Merged
:------------:|:--------------------------------:
subject       |train.subject & test.subject
activities    |train.activity & test.activity
features      |train.features & test.features

### Column naming
* names.features has two columns named id and name
* labels.activities has two columns named id and label
* activities is a single column named activity
* subject is a single column named subject
* features has 561 columns and their names are stored in names.features

## Filtering columns
All columns that don't contain the strings mean() or std() are removed, and
the result is stored in a variable called filtered_data, and the columns
subject and activities are appended.

As an extra the names of the columns that started with a t where changed to
time and the ones that started with an f changed to frequency so the
columns are more readable.

## Filtering rows
There is not much to do here, but just in case, I remove any row that contains a
NA or NaN.

## Activity names
The activities in features are coded with numbers, and the mapping between
id and label so I replace the numbers with the actual labels.

## Tidying up
The data is subsetted according to subject and activity, and the means of each
subset is stored in a new variable called tidydata, to improve it a bit more
the data is order first by subject and then by activity.

Finally the data is saved in the file specified in the variable outputfile.
For more information on the file variables checkout [README.md](README.md)
