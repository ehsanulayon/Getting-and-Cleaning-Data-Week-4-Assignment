#Loading libraries
library("data.table")
library("dplyr")

#Downloading file
dir <- getwd() 
link <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(link, file.path(dir, "Files.zip"))
unzip(zipfile = "Files.zip")

#Reading train and test data
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

#Reading features
variable_names <- read.table("UCI HAR Dataset/features.txt")

#Reading activity labels
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt")

# 1. Merges the training and the test sets to create one data set.
X_merged <- rbind(X_train, X_test)
y_merged <- rbind(y_train, y_test)
subject_merged <- rbind(subject_train, subject_test)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
sel_var <- variable_names[grep("mean\\(\\)|std\\(\\)", variable_names[,2]),]
X_merged <- X_merged[,sel_var[,1]]

# 3. Uses descriptive activity names to name the activities in the data set.
colnames(y_merged) = "activity"
y_merged$activitylabel <- factor(y_merged$activity, labels = as.character(activity_labels[,2]))
activitylabel <- y_merged[,-1]

# 4. Appropriately labels the data set with descriptive variable names.
colnames(X_merged) <- variable_names[sel_var[,1],2]

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
colnames(subject_merged) <- "subject"
total <- cbind(X_merged, activitylabel, subject_merged)
total_mean <- total %>% group_by(activitylabel, subject) %>% summarize_each(funs(mean))
write.table(total_mean, file = "UCI HAR Dataset/tidydata.txt", row.names = FALSE, col.names = TRUE)