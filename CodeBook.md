## Getting and Cleaning Data Project

Author: Vaibhav Kashyap
Date: 2014-08-22

### Description
This codebook describes the variables, the data, and any transformations or work that has been performed to clean up the Human Activity Recognition Using Smartphones Data Set.

### Source Data - Location
The source data for this project can be found here - https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

### Source Data - Description
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain.

A full description of the data used in this project can be found at [The UCI Machine Learning Repository](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones)

### Attribute Information for elements in Source Data
For each record in the dataset it is provided: 
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration. 
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

### Step 1. Merge the training and the test sets to create one data set.
After setting the source directory for the files, data located in the following files was read into the tables shown below:

- x_train.txt		---> 	x_train	(7352 observations of 561 variables)
- y_train.txt		--->	y_train	(7352 observations of 1 variable)
- subject_train.txt	--->	subject_train (7352 observations of 1 variable)
- x_test.txt		--->	x_test	(2947 observations of 561 variables)
- y_test.txt		--->	y_test	(2947 observations of 1 variable)
- subject_test.txt	--->	subject_test (2947 observations of 1 variable)

Merge to create one data set named all_data.
- x_data 		<- 	Merge x_train and x_test (10299 observations of 561 variables)
- y_data 		<- 	Merge y_train and y_test (10299 observations of 1 variable)
- subject_data 		<- 	Merge subject_train and subject_test (10299 observations of 1 variables)
- all_data		<- 	Merge subject_data, y_data and x_data (10299 observations of 563 variables)

## Step 2: Extract only the measurements on the mean and standard deviation for each measurement
- features.txt	--->	features (561 observations of 2 variables)

- featuresWanted : A logical vector containing the indices indices of the elements in features table for TRUE values for the mean and stdev columns and FALSE values for the others. 

- featuresWanted.names : A charcter vector containing the names of the elements based on the indices of the elements in the featuresWanted vector

- all_data : Table updated by subsetting the all_data table for elements that exist in the featuresWanted vector. It will lead to a table with 10299 observations of 81 variables.

## Step 3: Use descriptive activity names to name the activities in the data set
- activity_labels.txt	--->	activities (6 observations of 2 variables)

- all_data_With_activity <- Merge all_data and activities by activityID to get descriptive activity names

## Step 4: Appropriately label the data set with descriptive variable names
colNames : A charcter vector containing the names of the elements in the all_data_With_activity table

Use a for loop on the colNames vector and using the gsub function for pattern replacement, clean up the data labels.

## Step 5: Create a second, independent tidy data set with the average of each variable for each activity and each subject
tidyDataSet : Apply the ddply function on the all_data_With_activity table to calculate the mean of each variable for each activity and each subject. This will lead to creation of a table with 180 observations of 81 variables.

Output the tidyDataSet to a text file named tidyDataSet.txt.