# Coursera: Getting And Cleaning Data Course Project

This is the course project for the Getting and Cleaning Data Coursera course.

The R script, `run_analysis.R`, does the following:

**1. Merge the training and test sets to create one data set**
  1. Load the plyr library to be able to use the ddply() function
  2. Clean up the workspace
  3. Load training data set
  4. Load test data set
  5. Merge the training and test data sets into [all_data] data frame

**2. Extract only the measurements on the mean and standard deviation for each measurement**
  1. Load the features data set
  2. Extract the mean and std variables using grep function into the [featuresWanted] integer vector
  3. Create a character vector named [featuresWanted.names] to store the names of the variables in the [featuresWanted] vector
  4. Subset the [all_data] dataframe based on variables stored in the [featuresWanted] vector
  5. Label the variables correctly in the [all_data] dataframe using the [featuresWanted.names] character vector

**3. Use descriptive activity names to name the activities in the data set**
  1. Load the [activities_labels] data set [activities] dataframe
  2. Label the variables correctly
  3. Merge the [all_data] and [activities] datasets on [activityID] into [all_data_With_activity] dataframe
  4. Drop variable [activityID] since it is no longer needed
  5. Reorder variables based on need

**4. Appropriately label the data set with descriptive variable names**
  1. Create a character vector named [colNames] to store the variable labels from the [all_data_With_activity] dataframe
  2. Initiate a for loop to loop through the [colNames] vector and update values appropriately using gsub() function
  3. Rename the variable labels in [all_data_With_activity] dataframe using the updated [colNames] vector

**5. Creates a tidy dataset that consists of the average (mean) value of each variable for each subject and activity pair**
  1. Create a new dataset named [tidyDataSet] using the ddply() function on the [all_data_With_activity] dataframe which calculates mean of variables 3 through 81
  2. Output the [tidyDataSet] into a text file named [tidyDataSet.txt] using the write.table() function with row.name = FALSE and tab as a separator

The tidy data set is stored in the file 'tidyDataSet.txt'.
