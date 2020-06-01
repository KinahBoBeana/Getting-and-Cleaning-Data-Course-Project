The run_analysis.R script performs the data preparation and then followed by the 
5 steps required as described in the course project’s definition.

1. DOWNLOAD THE DATASET
- Zip downloaded and extracted under the folder called UCI HAR Dataset

2. CREATE 8 DATAFRAMES FROM THE FILES WITHIN UCI HAR DATASET

  - activities = ./UCI HAR Dataset/activity_labels.txt
  * 2 columns & 6 rows
  - List of activities performed
  
   - features = ./UCI HAR Dataset/features.txt
  * 2 columns & 561 rows
  - Features selected for this database
  
  - subject_train = ./UCI HAR Dataset/train/subject_train.txt
  * 1 columns & 7352rows
  - Train data for 21/30 volunteers
  
  - x_train = ./UCI HAR Dataset/train/X_train.txt
  * 561 columns & 7352 rows
  - Recorded features train data
 
  - y_train = ./UCI HAR Dataset/train/y_train.txt
  * 1 columns & 7352 rows
  - Train data for activities
  
  - subject_test = ./UCI HAR Dataset/test/subject_test.txt
  * 1 columns & 2947 rows
  - Test data for 9/30 volunteers
  
  - x_test = ./UCI HAR Dataset/test/X_test.txt
  * 561 columns & 2947 rows
  - Recorded features test data
  
  - y_test = ./UCI HAR Dataset/test/y_test.txt
  * 1 columns & 2947 rows
  - test data for activities
  
 

3. MERGES THE TRAINING AND TEST SETS TO CREATE ONE DATA SET
x <- x_train and x_test are merged using rbind()
y <- y_train nd y_test are merged using rbind()
subject <- subject_train and subject_test are merged using rbind()
merged_data <- subject, y and x are merged using cbind()

4. EXTRACTS THE MEAN AND STANDARD DEVIATION FOR EACH MEASUREMENT
CleanData <- a subset of merged_data containing subject, code and the measurements of the mean and standard deviation
for each measurement

5. USES DESCRIPTIVE ACTIVITY NAMES TO NAME THE ACTIVITIES IN THE DATA SET
code column in CleanData replaced with activity taken from second column of activities variable

6. APPROPRIATELY LABELS THE DATA SET WITH DESCRIPTIVE VARIABLE NAMES
CleanData$code <- renamed into activities
Acc <- replaced with Accelerometer
Gyro <- replaced with Gyroscope
BodyBody <- replaced with Body
Mag <- replaced with Magnitude
f <- replaced with Frequency
t <- replaced with Time

7. FROM THE PREVIOUS DATA SET, CREATES A SECOND INDEPENDENT DATA SET WITH THE AVERAGE FO EACH VAIABLE AND EACH SUBJECT
FinalData <- created by sumarizing CleanData and taking the means of each variable for each activity and each subject
* 88 columns and 180 rows
FinalData was exported into FinalData.txt
