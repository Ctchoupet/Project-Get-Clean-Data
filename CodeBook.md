CodeBook

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. the data on this project is based on Human Activity Recognition Using Smartphones Data Set.

This code book describes the variables, the data, and any transformations or work performed to clean up the data.



Source Data Information

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. 
Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. 
Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 
The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). 
The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. 
rom each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

The original data source and full data description can be found at the following URL:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip



Files included in the original dataset

 'README.txt'

- 'features_info.txt': Shows information about the variables used on the feature vector.

- 'features.txt': List of all features.

- 'activity_labels.txt': Links the class labels with their activity name.

- 'train/X_train.txt': Training set.

- 'train/y_train.txt': Training labels.

- 'test/X_test.txt': Test set.

- 'test/y_test.txt': Test labels.

The following files are available for the train and test data. Their descriptions are equivalent. 

- 'train/subject_train.txt': Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30. 

- 'train/Inertial Signals/total_acc_x_train.txt': The acceleration signal from the smartphone accelerometer X axis in standard gravity units 'g'. Every row shows a 128 element vector. The same description applies for the 'total_acc_x_train.txt' and 'total_acc_z_train.txt' files for the Y and Z axis. 

- 'train/Inertial Signals/body_acc_x_train.txt': The body acceleration signal obtained by subtracting the gravity from the total acceleration. 

- 'train/Inertial Signals/body_gyro_x_train.txt': The angular velocity vector measured by the gyroscope for each window sample. The units are radians/second. 



Details about files included in the original dataset:

features.txt contains 561 rows and 2 variables (columns): 1 number and 1 character to identify the feature
activity_labels.txt contains 6 rows and 2 variables (columns): 1 number and 1 character to identify the activity
X_test.txt contains 2947 rows and 561 variables (columns). Variables of this data set is the list of features in features.txt
y_test.txt contains 2947 rows and 1 variable (column). The numeric variable is the activity identifier.
X-train.txt contains 7352 rows and 561 variables. Variables of this data set is the list of features in features.txt
y_train.txt contains 7352 rows and 1 variable. The numeric variable is the activity identifier.
subject_train.txt contains 7352 rows and 1 variable. The numeric variable is the subject identifier.






Requirements, Functions and Transformations of run_analysis.R

Requirements

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement.
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names.
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


Functions:

1. Download the data set at the above URL and unzip it.
2. Load and merge in R 'test' and 'train' data set, one data set result of this merging.
3. Extracts only the measurements on the mean and standard deviation for each measurement, resulting in 86 measurements.
4. Change the variable name in the data frame in order to improve the clarity.
5. Include the activity name variable in the merged data frame
6. Update the appropriate label with descriptible variable names
7. Create a second data set with the average of each measurement for each subject and each activity
8. Write the new data frame in a text file. The file contains the average of each variable name for each subject and each activity. The data set has 180 observations and 86 columns.



Transformations:

1. Files download -

The following files are downloaded and loaded in R-

- 'features.txt' is transformed in 'features'

- 'activity_labels.txt' is transformed in 'activitylabels'

- 'train/X_train.txt' is transformed in 'xtrain'

- 'train/y_train.txt' is transformed in 'ytrain'

- 'test/X_test.txt' is transformed in 'xtest'

- 'test/y_test.txt' is transformed in 'ytest'

- 'train/subject_train.txt' is transformed in 'subjecttrain'

- 'test/subject_test.txt' is transformed in 'subjecttest'

2./4. Row bound - Columns bound - Update  of variable names

'features' column names are updated to include "featurenumber" and "featurename"
'activitylabels' column names are updated to include "activitynumber" and "activityname"
'subjecttrain' and 'subjecttest' data sets are rows bound to create one subject data set.The data set has 10,299 observations and is stored in the object 'datasubject', the column name is renamed to "subject"
'ytest' and 'ytrain' data sets are rows bound to create one activity data set. The data set has 10,299 observations and is stored in the object 'dataactivity',the column name is renamed to "activitynumber"
'xtrain' and 'xtest' data sets are rows bound to create one data. The data st has 10,299 observations and 561 variable names and is stored in the object 'datatraining_and_test', column names are renamed to variable names included in 'features'
'datasubject' and 'datatraining_and_test' data sets are columns bound to create 1 data set. the data set has 10,299 observations and 2 variables and is stored in the object 'datasubject_and_activity'
'datasubject_and_activity' and 'datatraining_and_test' data sets are columns bound to create 1 data set. the data set has 10,299 observations and 563 variables and is stored in the object 'alldata'

3. Extract of measurement with mean and std

grep function is used to extract the measurements and 86 variables are returned and stored in the variable 'featuresmean_and_std'
'featuresmean_and_std' variables are updated to include "subject" and "activitynumber" providing 88 variables which are subseted from the merged data 'alldata' and stored in object 'alldata2'

featuresmean_and_std <- grep(".*mean.*|.*std.*", features$featurename, ignore.case=TRUE, value=TRUE)
featuresmean_and_std <- union(c("subject","activitynumber"), featuresmean_and_std)
alldata2<- subset(alldata,select=featuresmean_and_std) 

5. Include the activity name variable in the merged data frame
#Insertion of the activity name in the table
alldata2 <- merge(activitylabels, alldata2 , by.x= "activitynumber", by.y = "activitynumber", all=TRUE)

6. Update the appropriate label with descriptible variable names
#Extraction of columns names
names(alldata2)
# from the result of the command above, we can do the following changes:
# Acc can be replaced with Accelerometer
# Gyro can be replaced with Gyroscope
# Mag can be replaced with Magnitude
# leading t can be replaced with Time
# leading f can be replaced with Frequency
# BodyBody can be replaced with Body

names(alldata2)<-gsub("^t", "time", names(alldata2))
names(alldata2)<-gsub("^f", "frequency", names(alldata2))
names(alldata2)<-gsub("Acc", "Accelerometer", names(alldata2))
names(alldata2)<-gsub("Gyro", "Gyroscope", names(alldata2))
names(alldata2)<-gsub("Mag", "Magnitude", names(alldata2))
names(alldata2)<-gsub("BodyBody", "Body", names(alldata2))

7. Create a second data set with the average of each measurement for each subject and each activity
8. Write the new data frame in a text file. The file contains the average of each variable name for each subject and each activity. The data set has 180 observations and 88 columns.

second_data <- aggregate(. ~subject + activitynumber, alldata2, mean)
second_data <- arrange(second_data, subject, activitynumber)
write.table(second_data, "second_data.txt", row.names = FALSE)

