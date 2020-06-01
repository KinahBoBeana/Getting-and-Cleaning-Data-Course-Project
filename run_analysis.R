#Checking if folder from zip already exists

file <- "Coursera_Data_Cleaning.zip"

if(!file.exists("UCI HAR Dataset")){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" 
        download.file(fileURL, file, method="curl")
        unzip(file)
}

#Create 8 dataframes containing the data we need to merge

activities <- read.table("./UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))
features <- read.table("./UCI HAR Dataset/features.txt", col.names = c("n", "functions"))
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = "code")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
x_test <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names = features$functions)
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = "code")

#merge all the data frames together to form one dataset

x <- rbind(x_train, x_test)
y <- rbind(y_train, y_test)
subject <- rbind(subject_train, subject_test)
merged_data <- cbind(subject, y, x)

library(dplyr)

#Extracting the mean and standard deviation
CleanData <- merged_data %>% select(subject, code, contains("mean"), contains("std"))

#Assigning descriptive names to the activities in the data set

CleanData$code <- activities[CleanData$code, 2]

#Labels the data set with descriptive variable names

names(CleanData)[2] = "activity"
names(CleanData) <- gsub("Acc", "Accelerometer", names(CleanData))
names(CleanData) <- gsub("Gyro", "Gyroscope", names(CleanData))
names(CleanData) <- gsub("BodyBody", "Body", names(CleanData))
names(CleanData) <- gsub("Mag", "Magnitude", names(CleanData))
names(CleanData) <- gsub("^t", "Time", names(CleanData))
names(CleanData) <- gsub("^f", "Frequency", names(CleanData))
names(CleanData) <- gsub("tBody", "TimeBody", names(CleanData))
names(CleanData) <- gsub("-mean()", "Mean", names(CleanData), ignore.case = T)
names(CleanData) <- gsub("-std()", "STD", names(CleanData), ignore.case = T)
names(CleanData) <- gsub("-freq()", "Frequency", names(CleanData), ignore.case = T)
names(CleanData) <- gsub("angle", "Angle", names(CleanData))
names(CleanData) <- gsub("gravity", "Gravity", names(CleanData))

#Create a second data set from the data set we've already created, with the average of each variable for each activity
# and each subject

FinalData <- CleanData %>% group_by(subject, activity) %>%
        summarise_all(funs(mean))
write.table(FinalData, "FinalData.txt", row.names = F)
