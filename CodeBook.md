### Code book

The run_analysis.R script gives the instructions do to the following instructions
(as per course project description page) :

(As per comments, it assumed that you got the data from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
and unzipped the folder "UCI HAR Dataset" into your working directory).

1. merge the training and the test sets to create one data set.
2. extract only the measurements on the mean and standard deviation for each measurement. 
3. uses descriptive activity names to name the activities in the data set.
4. appropriately labels the data set with descriptive variable names. 
5. from the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The resulting data_frame from the 5th step is available as the get-data-035-course-project.txt file.
You can also export this data frame by uncommenting the last line of the run_analysis.R and run it
or run the run_analysis.R and use the mean_std_by_subject_activity data frame to export it as desired.

The run_analysis.R script also contains the steps as well as additional comments to explain how the steps
have ben implemented.
