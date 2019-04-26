## Getting and Cleaning Data Course Project - Code Book
This codebook describes the process, code, and output file associated with the Getting and Leaning Data Course (https://www.coursera.org/learn/data-cleaning/home/welcome).  
## The Process:
- The support documents were downloaded by my local machine from the following website: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
-  These files were unzipped into a root folder containing:"UCI HAR Dataset".  This root folder is considered the root for the script as well. 
-  An R script file titled "run_Analysis.R" was created in the root folder
# Reduced Data file descriptions
## Step4CombinedData
- Merges the training and the test sets to create one data set.
- Extracts only the measurements on the mean and standard deviation for each measurement.
- Uses descriptive activity names to name the activities in the data set
- Appropriately labels the data set with descriptive variable names.

Methods for selecting, reducing, and combining the data are described further below
The file contains the following columns:
SubjectNumber - This is the subject number associated with the row of values 
ActivityName - The usefule name for the activity loaded from activity_labels.txt
ActivityNumber - The less useful activity number used for the cross hash to Activity Name
Data Type - lables the data as coming from the test or train data
----- All below are as defined in in the features_info.txt (info contained below) ------
tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tGravityAcc-mean()-X
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z
tBodyAccJerk-mean()-X
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z
tBodyGyro-mean()-X
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z
tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyAccMag-mean()
tGravityAccMag-mean()
tBodyAccJerkMag-mean()
tBodyGyroMag-mean()
tBodyGyroJerkMag-mean()
fBodyAcc-mean()-X
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyAccMag-mean()
fBodyBodyAccJerkMag-mean()
fBodyBodyGyroMag-mean()
fBodyBodyGyroJerkMag-mean()
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z
tBodyAccJerk-std()-X
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z
tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z
tBodyGyroJerk-std()-X
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z
tBodyAccMag-std()
tGravityAccMag-std()
tBodyAccJerkMag-std()
tBodyGyroMag-std()
tBodyGyroJerkMag-std()
fBodyAcc-std()-X
fBodyAcc-std()-Y
fBodyAcc-std()-Z
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z
fBodyGyro-std()-X
fBodyGyro-std()-Y
fBodyGyro-std()-Z
fBodyAccMag-std()
fBodyBodyAccJerkMag-std()
fBodyBodyGyroMag-std()
fBodyBodyGyroJerkMag-std()

## step5AverageData.rds
- From the "step4CombinedData, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
Methods for selecting, reducing, and combining the data are described further below
The file contains the following columns:
AverageCategory - Defines if the average is grouped by the "Activity" or "Subject"
AverageOf - Specifis the "Activity" or "Subject" for the Average
----- The means of the titled columns grouped by the AverageCategory and AverageOf, origional values are are as defined in in the features_info.txt (info contained below) ------
tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tGravityAcc-mean()-X
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z
tBodyAccJerk-mean()-X
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z
tBodyGyro-mean()-X
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z
tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyAccMag-mean()
tGravityAccMag-mean()
tBodyAccJerkMag-mean()
tBodyGyroMag-mean()
tBodyGyroJerkMag-mean()
fBodyAcc-mean()-X
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyAccMag-mean()
fBodyBodyAccJerkMag-mean()
fBodyBodyGyroMag-mean()
fBodyBodyGyroJerkMag-mean()
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z
tBodyAccJerk-std()-X
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z
tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z
tBodyGyroJerk-std()-X
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z
tBodyAccMag-std()
tGravityAccMag-std()
tBodyAccJerkMag-std()
tBodyGyroMag-std()
tBodyGyroJerkMag-std()
fBodyAcc-std()-X
fBodyAcc-std()-Y
fBodyAcc-std()-Z
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z
fBodyGyro-std()-X
fBodyGyro-std()-Y
fBodyGyro-std()-Z
fBodyAccMag-std()
fBodyBodyAccJerkMag-std()
fBodyBodyGyroMag-std()
fBodyBodyGyroJerkMag-std()
fBodyBodyGyroMag-std()
fBodyBodyGyroJerkMag-std()


## run_analysis.R
The processing scrip of this function reads in several downloaded files, processes the data and saves the required processed files.   This section will cover the step by step code process
### Setup the Workspace
- The "tidyverse" package is added to the library as it is required for many of the specific data processing operations
### Load the source data
- The "bp" variable is set as the base path string to allow easier loading of data
- the "activity_lables" variable is populated by loading the "activity_labels.txt" file.  The read_delim function is used and passed the string path with a paste command utilzing the earlier defined "bp" variable.  This read function is also passed the column names "ActivityNum" and "ActivityName"
- the "feature_lables" variable is populated by loading the "features.txt" file.  The read_delim function is used and passed the string path with a paste command utilzing the earlier defined "bp" variable.  This read function is also passed the column names "ActivityNum" and "FeatureName"
- the "bp" variable is changed to move into the "test" folder
- the "test_Subject_Num" variable is populated by loading the "subject_test.txt" file.  The read_delim function is used and passed the string path with a paste command utilzing the earlier defined "bp" variable.  This read function is also passed the column name "Subject Num"
- the "test_Activity_Num" variable is populated by loading the "Y_test.txt" file.  The read_delim function is used and passed the string path with a paste command utilzing the earlier defined "bp" variable.  This read function is also passed the column name "ActivityNum"
- the "test_data" variable is populated by loading the "X_test.txt" file.  The read_delim function is used and passed the string path with a paste command utilzing the earlier defined "bp" variable.  This read function is also passed the column names from the "Feature Name" column of the "feature_lables" file.  The data is also parsed with a default column type of double and true to the "trim_ws" parameter to remove the additional white space.  Note: This helps the data to correctly parse in as a double vice NaN. 

- the "bp" variable is changed to move into the "train" folder
- the "train_Subject_Num" variable is populated by loading the "subject_train.txt" file.  The read_delim function is used and passed the string path with a paste command utilzing the earlier defined "bp" variable.  This read function is also passed the column name "Subject Num"
- the "train_Activity_Num" variable is populated by loading the "y_train.txt" file.  The read_delim function is used and passed the string path with a paste command utilzing the earlier defined "bp" variable.  This read function is also passed the column name "ActivityNum"
- the "train_data" variable is populated by loading the "X_train.txt" file.  The read_delim function is used and passed the string path with a paste command utilzing the earlier defined "bp" variable.  This read function is also passed the column names from the "Feature Name" column of the "feature_lables" file.  The data is also parsed with a default column type of double and true to the "trim_ws" parameter to remove the additional white space.  Note: This helps the data to correctly parse in as a double vice NaN. 
### Map the activityname to the Activity Number
- Create the "test_Activity_Name" variable  by performing a left join between the test_Activity_Num and activity_lables variables. 
- Create the "train_Activity_Name" variable  by performing a left join between the train_Activity_Num and activity_lables variables. 
### Downselect the data to only the columns containing "mean()" and "std()" is the column name
- Create "test_Data" by utlizing select on the "test_Data" variable and contains "mean()" or "std()". 
- Create "train_Data" by utlizing select on the "train_Data" variable and contains "mean()" or "std()".
### Merge the data
- "test_Data" is created from "test_data" adding the column 'SubjectNumber' from test_Subject_Num,`Subject Num` column, 'ActivityNumber' from test_Activity_Name `ActivityNum` column,'ActivityName' from test_Activity_Name, `ActivityName` column, and adding 'Data Type' column populated with 'Test'.  This will fill to the length.
- "train_Data" is created from "train_data" adding the column 'SubjectNumber' from train_Subject_Num,`Subject Num` column, 'ActivityNumber' from train_Activity_Name `ActivityNum` column,'ActivityName' from train_Activity_Name, `ActivityName` column, and adding 'Data Type' column populated with 'Train'.  This will fill to the length.
### reorder columns for readablilty
- 'SubjectNumber', 'ActivityName','ActivityNumber', and 'Data Type' are moved to the left of the "test_data" variable
- 'SubjectNumber', 'ActivityName','ActivityNumber', and 'Data Type' are moved to the left of the "train_data" variable
### Combine data
- "combinedData" variable is created with rbind from the "test_Data" and "train_Data" variables. 
### Save Ouput
- "combinedData" variable is saved as an RDS file type to "Step4combinedData.rds"

### Begin Step 5 Section of Code
### Generate the Average for each Activity
- create "groupedData" vaiable from by grouping "combinedData" by "ActivityName"
- create "subset" the "groupedData" by selecting columns in the range from 'tBodyAcc-mean()-X' to 'fBodyBodyGyroJerkMag-std()'
- Create "ActivityMean" by summarizing all of the subset with the mean function
- rename the "ActivityName" column of the "ActivityMean" variable to "AverageOf"
- Add the "AverageCategory" column to the "ActivityMean" variable and filling length with "Activity"
### Generate the Average for each Subject
- create "groupedData" vaiable from by grouping "combinedData" by "SubjectNumber"
- create "subset" the "groupedData" by selecting columns in the range from 'tBodyAcc-mean()-X' to 'fBodyBodyGyroJerkMag-std()'
- Create "SubjectMean" by summarizing all of the subset with the mean function
- rename the "SubjectNumber" column of the "SubjectMean" variable to "AverageOf"
- Add the "AverageCategory" column to the "SubjectMean" variable and filling length with "Subject"

## Combine Data Set
- Create "AverageData" using rbind on "AverageMean" and "SubjectMean"
- refine "AverageData" to move "AverageCategory" to the left of all other columns
### Save Ouput
- "AverageData" variable is saved as an RDS file type to "Step5AverageData.rds"

## Read in .rds data files
The combineddata file was saved as an RDS file.  
To load this file into R, utilize the `readRDS('Step4combinedData.rds')` command

The AverageData file was saved as an RDS file.  
To load this file into R, utilize the `readRDS('step5AverageData.rds')` command

# Support codebooks provided in the origional data set:
## README.txt

==================================================================
Human Activity Recognition Using Smartphones Dataset
Version 1.0
==================================================================
Jorge L. Reyes-Ortiz, Davide Anguita, Alessandro Ghio, Luca Oneto.
Smartlab - Non Linear Complex Systems Laboratory
DITEN - Università degli Studi di Genova.
Via Opera Pia 11A, I-16145, Genoa, Italy.
activityrecognition@smartlab.ws
www.smartlab.ws
==================================================================

The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================

- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.

The dataset includes the following files:
=========================================

- 'README.txt'

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

Notes: 
======
- Features are normalized and bounded within [-1,1].
- Each feature vector is a row on the text file.

For more information about this dataset contact: activityrecognition@smartlab.ws

License:
========
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.

## features_info.txt
Feature Selection 
=================

The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly, the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz. 

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag). 

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Note the 'f' to indicate frequency domain signals). 

These signals were used to estimate variables of the feature vector for each pattern:  
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions.

tBodyAcc-XYZ
tGravityAcc-XYZ
tBodyAccJerk-XYZ
tBodyGyro-XYZ
tBodyGyroJerk-XYZ
tBodyAccMag
tGravityAccMag
tBodyAccJerkMag
tBodyGyroMag
tBodyGyroJerkMag
fBodyAcc-XYZ
fBodyAccJerk-XYZ
fBodyGyro-XYZ
fBodyAccMag
fBodyAccJerkMag
fBodyGyroMag
fBodyGyroJerkMag

The set of variables that were estimated from these signals are: 

mean(): Mean value
std(): Standard deviation
mad(): Median absolute deviation 
max(): Largest value in array
min(): Smallest value in array
sma(): Signal magnitude area
energy(): Energy measure. Sum of the squares divided by the number of values. 
iqr(): Interquartile range 
entropy(): Signal entropy
arCoeff(): Autorregresion coefficients with Burg order equal to 4
correlation(): correlation coefficient between two signals
maxInds(): index of the frequency component with largest magnitude
meanFreq(): Weighted average of the frequency components to obtain a mean frequency
skewness(): skewness of the frequency domain signal 
kurtosis(): kurtosis of the frequency domain signal 
bandsEnergy(): Energy of a frequency interval within the 64 bins of the FFT of each window.
angle(): Angle between to vectors.

Additional vectors obtained by averaging the signals in a signal window sample. These are used on the angle() variable:

gravityMean
tBodyAccMean
tBodyAccJerkMean
tBodyGyroMean
tBodyGyroJerkMean

The complete list of variables of each feature vector is available in 'features.txt'

##
