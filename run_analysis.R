Instructions

The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set.
Review criteriamoins 
The submitted data set is tidy.
The Github repo contains the required scripts.
GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.
The README that explains the analysis files is clear and understandable.
The work submitted for this project is the work of the student who submitted it.
Getting and Cleaning Data Course Projectmoins 
The purpose of this project is to demonstrate your ability to collect, work with, and clean a data set. The goal is to prepare tidy data that can be used for later analysis. You will be graded by your peers on a series of yes/no questions related to the project. You will be required to submit: 1) a tidy data set as described below, 2) a link to a Github repository with your script for performing the analysis, and 3) a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md. You should also include a README.md in the repo with your scripts. This repo explains how all of the scripts work and how they are connected.

One of the most exciting areas in all of data science right now is wearable computing - see for example this article . Companies like Fitbit, Nike, and Jawbone Up are racing to develop the most advanced algorithms to attract new users. The data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:

http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

You should create one R script called run_analysis.R that does the following.

Merges the training and the test sets to create one data set.
Extracts only the measurements on the mean and standard deviation for each measurement.
Uses descriptive activity names to name the activities in the data set
Appropriately labels the data set with descriptive variable names.
From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Good luck!



#A-Load Data

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "C:/Users/Ramon/Desktop/Coursera/Data Sciences/Getting and Cleaning Data/PROJECT/data.zip", method = "libcurl")

#Unzip the file
unzip(zipfile="C:/Users/Ramon/Desktop/Coursera/Data Sciences/Getting and Cleaning Data/PROJECT/data.zip",exdir="C:/Users/Ramon/Desktop/Coursera/Data Sciences/Getting and Cleaning Data/PROJECT/data")

#B-Files we will be loading in R
#test/subject_test
#test/X_test
#test/y_test
#train/subject_train
#train/X_train
#train/y_train
#activity_labels
#features

#C-Packages we will need in the project
library(data.table)
library(dplyr)
library(tidyr)
library(Hmisc)
library(doBy)

#D-Read files in R
#test subject file
subjecttest <- tbl_df(read.table("C:/Users/Ramon/Desktop/Coursera/Data Sciences/Getting and Cleaning Data/PROJECT/data/UCI HAR Dataset/test/subject_test.txt"))
#test data file
xtest <- tbl_df(read.table("C:/Users/Ramon/Desktop/Coursera/Data Sciences/Getting and Cleaning Data/PROJECT/data/UCI HAR Dataset/test/X_test.txt"))
# test activity file
ytest <- tbl_df(read.table("C:/Users/Ramon/Desktop/Coursera/Data Sciences/Getting and Cleaning Data/PROJECT/data/UCI HAR Dataset/test/y_test.txt"))
# training subject file
subjecttrain <- tbl_df(read.table("C:/Users/Ramon/Desktop/Coursera/Data Sciences/Getting and Cleaning Data/PROJECT/data/UCI HAR Dataset/train/subject_train.txt"))
#Training data file
xtrain <- tbl_df(read.table("C:/Users/Ramon/Desktop/Coursera/Data Sciences/Getting and Cleaning Data/PROJECT/data/UCI HAR Dataset/train/X_train.txt"))
# training activity file
ytrain <- tbl_df(read.table("C:/Users/Ramon/Desktop/Coursera/Data Sciences/Getting and Cleaning Data/PROJECT/data/UCI HAR Dataset/train/y_train.txt"))
#activity labels file
activitylabels <- tbl_df(read.table("C:/Users/Ramon/Desktop/Coursera/Data Sciences/Getting and Cleaning Data/PROJECT/data/UCI HAR Dataset/activity_labels.txt"))

# feature file
features <- tbl_df(read.table("C:/Users/Ramon/Desktop/Coursera/Data Sciences/Getting and Cleaning Data/PROJECT/data/UCI HAR Dataset/features.txt"))

# 1.  Merges the training and the test sets to create one data set.
#rename activitylabels and featuures columns
colnames(features) <- c("featurenumber", "featurename")
colnames(activitylabels) <- c("activitynumber", "activityname")
#combine training and test data, rename columns.
datasubject <- rbind(subjecttrain, subjecttest)
colnames(datasubject) <- c("subject")
#combine training and test data, rename columns.
dataactivity <- rbind(ytrain, ytest)
colnames(dataactivity) <- c("activitynumber")
#combine training and test data, rename columns.
datatraining_and_test <- rbind(xtrain, xtest)
colnames(datatraining_and_test) <- features$featurename
#Merge data

datasubject_and_activity <- cbind(datasubject, dataactivity)
alldata <- cbind(datasubject_and_activity, datatraining_and_test)



#2. Extracts only the measurements on the mean and standard deviation for each measurement.

# Measurements that match mean or std
#featuresmean_and_std <- grep(".*mean.*|.*std.*", features$featurename, ignore.case=TRUE)
# columns that contain mean or std
#datatraining_and_test_subset<- subset(datatraining_and_test,select=featuresmean_and_std)
#new data set with only colums that contain mean and std
#alldata2 <- cbind(datasubject_and_activity, datatraining_and_test_subset)

featuresmean_and_std <- grep(".*mean.*|.*std.*", features$featurename, ignore.case=TRUE, value=TRUE)
featuresmean_and_std <- union(c("subject","activitynumber"), featuresmean_and_std)
alldata2<- subset(alldata,select=featuresmean_and_std) 

#3 Uses descriptive activity names to name the activities in the data set

#Insertion of the activity name in the table
alldata2 <- merge(activitylabels, alldata2 , by.x= "activitynumber", by.y = "activitynumber", all=TRUE)

#4. Appropriately labels the data set with descriptive variable names.
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

# 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


#second_data <- summarize(second_data, subject, activitynumber)

second_data <- aggregate(. ~subject + activitynumber, alldata2, mean)
second_data <- arrange(second_data, subject, activitynumber)