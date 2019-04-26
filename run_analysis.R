## run_analysis.R
# This code will run through the process of working with the:
# Human Activity Recognition Using Smartphones Dataset- Version 1.0



library(tidyverse) # required for my tidy operations
bp<-('./UCI HAR Dataset') # set base path
#load data from root
#This load will read the deliminated text file with " " as the deliminator, the columnm are then named
activity_lables<-read_delim(paste(bp,'/activity_labels.txt',sep=""),' ',col_names=c("ActivityNum","ActivityName"))
#This load will read the deliminated text file with " " as the deliminator, the columsn are then named
feature_lables<-read_delim(paste(bp,'/features.txt',sep=""),' ',col_names=c("ActivityNum","Feature Name"))
#load test Data
bp<-('./UCI HAR Dataset/test/')# set base path
test_Subject_Num<-read_delim(paste(bp,'subject_test.txt',sep=""),' ',col_names=c("Subject Num"))
test_Activity_Num<-read_delim(paste(bp,'y_test.txt',sep=""),' ',col_names=c("ActivityNum"))
test_Data<-read_delim(paste(bp,'X_test.txt',sep=""),' ',col_names=feature_lables$`Feature Name`,col_types = cols(.default = "d"),trim_ws=TRUE)

#load training Data
bp<-('./UCI HAR Dataset/train/')# set base path
train_Subject_Num<-read_delim(paste(bp,'subject_train.txt',sep=""),' ',col_names=c("Subject Num"))
train_Activity_Num<-read_delim(paste(bp,'y_train.txt',sep=""),' ',col_names=c("ActivityNum"))
train_Data<-read_delim(paste(bp,'X_train.txt',sep=""),' ',col_names=feature_lables$`Feature Name`,col_types = cols(.default = "d"),trim_ws=TRUE)

# Map ActivityName to ActivityNumber 
test_Activity_Name<-left_join(test_Activity_Num,activity_lables,by=c('ActivityNum'='ActivityNum'))
train_Activity_Name<-left_join(train_Activity_Num,activity_lables,by=c('ActivityNum'='ActivityNum'))

#downselect data to only contain the mean() and std() data
test_Data<-select(test_Data,contains('mean()'),contains('std()'))
train_Data<-select(train_Data,contains('mean()'),contains('std()'))



# Merge Data including adding a lable for the type of data
test_Data<-mutate(test_Data,'SubjectNumber'=test_Subject_Num$`Subject Num`,'ActivityNumber'=test_Activity_Name$`ActivityNum`,'ActivityName'=test_Activity_Name$`ActivityName`,'Data Type'='Test')
train_Data<-mutate(train_Data,'SubjectNumber'=train_Subject_Num$`Subject Num`,'ActivityNumber'=train_Activity_Name$`ActivityNum`,'ActivityName'=train_Activity_Name$`ActivityName`,'Data Type'='Train')

# Reorder data to bring new columns to the left
test_Data<-select(test_Data,'SubjectNumber', 'ActivityName','ActivityNumber','Data Type',everything())
train_Data<-select(train_Data,'SubjectNumber', 'ActivityName','ActivityNumber','Data Type',everything())

# Create combined data set of test and training data
combinedData<-rbind(test_Data,train_Data)

# Cleaning up memory to optomize performance
rm('test_Data','train_Data','activity_lables','feature_lables','test_Activity_Name','test_Activity_Num','test_Subject_Num','train_Activity_Name','train_Activity_Num','train_Subject_Num')

#save combined data to a RDS file
saveRDS(combinedData, file = "Step4combinedData.rds")

# Begin step 5 by grouping data
groupedData<-combinedData %>% group_by(ActivityName)
subset=select(groupedData,'tBodyAcc-mean()-X':'fBodyBodyGyroJerkMag-std()')
ActivityMean<-subset %>%summarise_all(mean)
ActivityMean<-rename(ActivityMean,AverageOf=ActivityName)
ActivityMean<-mutate(ActivityMean,AverageCategory='Activity')

groupedData<-combinedData %>% group_by(SubjectNumber)
subset=select(groupedData,'tBodyAcc-mean()-X':'fBodyBodyGyroJerkMag-std()')
SubjectMean<-subset %>%summarise_all(mean)
SubjectMean<-rename(SubjectMean,AverageOf=SubjectNumber)
SubjectMean<-mutate(SubjectMean,AverageCategory='Subject')

AverageData<-rbind(ActivityMean,SubjectMean)
AverageData<-(select(AverageData,'AverageCategory',everything()))
saveRDS(AverageData, file = "Step5AverageData.rds")

# Resave Ouput as more difficut file type required for submission
write.table(combinedData,"Step4CombinedData.txt",row.name=FALSE)
write.table(AverageData,"Step5AverageData.txt",row.name=FALSE)

