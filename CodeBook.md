## Getting and Cleaning Data Course Project - Code Book
This codebook describes the process, code, and output file associated with the Getting and Leaning Data Course (https://www.coursera.org/learn/data-cleaning/home/welcome).  
## The Process:
- The support documents were downloaded by my local machine from the following website: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
-  These files were unzipped into a root folder containing:"UCI HAR Dataset".  This root folder is considered the root for the script as well. 
-  An R script file titled "run_Analysis.R" was created in the root folder
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

