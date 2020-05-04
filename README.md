# Getting and Cleaning Data Assignment
This repo contains the necessary files of the assignment for week 4 of Getting and Cleaning Data Coursera course.

### Data description
The variables in the data X are sensor signals measured with waist-mounted smartphone from 30 subjects. The variable in the data Y indicates activity type the subjects performed during recording.

### Code explaination
The code combined train dataset and test dataset,  and extracted partial variables to create another dataset with the averages of each variable for each activity.

### New dataset
The new generated dataset contains variables calculated based on the mean and standard deviation. Each row of the dataset is an average of each activity type for all subjects.

#### Instruction of this assignment is as following - 
To create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.
>I've used rbind command to combine train and test data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.
>I've used grep command to get column indexes for variable name containing "mean()" or "std()".

3. Uses descriptive activity names to name the activities in the data set
>I've converted activity labels to characters and added a new column as factor.

4. Appropriately labels the data set with descriptive variable names.
>I've given the selected descriptive names to variable columns.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
>I've used pipeline command to create a new tidy dataset with group_by command and summarize_each from dplyr package.

