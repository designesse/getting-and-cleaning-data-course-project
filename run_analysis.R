# Getting and Cleaning Data (getdata-035) Course Project

# Get the data at https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip.
# Put the unzipped folder "UCI HAR Dataset" into your working directory.

# Import data into variables.
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")
x_test <- read.table("UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")
x_train <- read.table("UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# 1. Merge training and test sets to create one data set.
# Make sure the package dplyr is installed to use bind_cols.
# Merge train in the order subject/activities/features data into a new train dataframe.
train_data <- bind_cols(subject_train, y_train, x_train)
# Merge test in the order subject/activities/features data into a new test dataframe.
test_data <- bind_cols(subject_test, y_test, x_test)
# Merge train and test data.
data <- rbind(train_data, test_data)

# 2. Extract only the measurements on the mean and standard deviation for each measurement.
features <- read.table("UCI HAR Dataset/features.txt")
mean_features <- features[grep("mean", as.character(features$V2)), ]
std_features <- features[grep("std", as.character(features$V2)), ]
mean_std_features <- rbind(mean_features, std_features)
mean_std_features$V1 <- as.numeric(mean_std_features$V1)
mean_std_features <- mean_std_features[order(mean_std_features$V1),]
mean_std_cols_index <- mean_std_features$V1
mean_std_cols_names <- mean_std_features$V2
# Subject and activities are first two columns in data so add 2.
mean_std_cols <- mean_std_cols_index + 2
mean_std_data <- data[,c(1,2,mean_std_cols)]

# 3. Use descriptive activity names to name the activities in the data set.
activity_labels <- c("walking", "walking_upstairs", "walking_dowstairs", "sitting", "standing", "laying")
mean_std_data[,2] <- sapply(mean_std_data[,2], function(x) activity_labels[x])

# 4. Appropriately labels the data set with descriptive variable names.
data_col_names <- c("subject", "activity", as.character(mean_std_features$V2))
colnames(mean_std_data) <- data_col_names

# 5. From the data step in 4, creates a second, independent tidy data set with the average of each 
# variable for each activity and each subject.
mean_std_by_subject_activity <- aggregate(.~subject+activity, data = mean_std_data, mean, na.rm = TRUE)
