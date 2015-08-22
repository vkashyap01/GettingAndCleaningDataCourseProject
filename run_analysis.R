##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
## Vaibhav Kashyap
## 2014-08-10

# File Name: run_analysis.R

# This script will perform the following steps on the UCI HAR Dataset downloaded from 
# https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive activity names. 
# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

##########################################################################################################

#Load the plyr library to be able to use the ddply() function
library(plyr)

# Clean up workspace
rm(list=ls())

# Step 1: Merge the training and test data sets to create one data set
###############################################################################

x_train <- read.table("train/X_train.txt")
y_train <- read.table("train/y_train.txt")
subject_train <- read.table("train/subject_train.txt")

x_test <- read.table("test/X_test.txt")
y_test <- read.table("test/y_test.txt")
subject_test <- read.table("test/subject_test.txt")

# create 'x' data set
x_data <- rbind(x_train, x_test)

# create 'y' data set
y_data <- rbind(y_train, y_test)

# Label column name correctly
names(y_data) <- "activityID"

# create 'subject' data set
subject_data <- rbind(subject_train, subject_test)

# Label column name correctly
names(subject_data) <- "subject"

# Bind (combine) all the data in a single data set
all_data <- cbind(subject_data, y_data, x_data)

# Step 2: Extract only the measurements on the mean and standard deviation for each measurement
#####################################################################################################

features <- read.table("features.txt")
features[,2] <- as.character(features[,2])

# identify the columns with mean or std in their names
featuresWanted <- grep(".*mean.*|.*std.*", features[,2])
featuresWanted.names <- features[featuresWanted,2]

# subset the desired columns
all_data <- all_data[, c(1,2,featuresWanted+2)]

# Label the column names correctly
colnames(all_data) <- c('subject', 'activityID', featuresWanted.names)

# Step 3: Use descriptive activity names to name the activities in the data set
#####################################################################################

activities <- read.table("activity_labels.txt")

# Label the column names
colnames(activities)  = c('activityID','activity');

# update values with correct activity names
all_data_With_activity <- merge(all_data,activities,by="activityID",all.x = TRUE)

#drop activityID from list of columns
all_data_With_activity <- subset(all_data_With_activity, select=-activityID)

#reorder columns
all_data_With_activity <- all_data_With_activity[c(1,81,2:80)]

# Step 4: Appropriately label the data set with descriptive variable names
################################################################################

#Create the colNames vector to include the column names after merge
colNames  = colnames(all_data_With_activity); 

#Loop through colNames vector and fix column names based on pattern matching and replacement
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("std","StdDev",colNames[i])
  colNames[i] = gsub("mean","Mean",colNames[i])
  colNames[i] = gsub("^(t)","Time",colNames[i])
  colNames[i] = gsub("^(f)","Frequency",colNames[i])
  colNames[i] = gsub("BodyBody","Body",colNames[i])
  colNames[i] = gsub("AccMag","AccMagnitude",colNames[i])
  colNames[i] = gsub("JerkMag","JerkMagnitude",colNames[i])
  colNames[i] = gsub("GyroMag","GyroMagnitude",colNames[i])
  colNames[i] = gsub("Bodyaccjerkmag","BodyAccJerkMagnitude",colNames[i])
};

# Reassign the new descriptive column names to the all_data_With_activity set
colnames(all_data_With_activity) = colNames;

# Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject
###############################################################################################################################

# Use the ddply function to calculate the averages
tidyDataSet <- ddply(all_data_With_activity, .(subject, activity), function(x) colMeans(x[, 3:81]))

#Output 
write.table(tidyDataSet, './tidyDataSet.txt', row.name=FALSE, sep='\t')