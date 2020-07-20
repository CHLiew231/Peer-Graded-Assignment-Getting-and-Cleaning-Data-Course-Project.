# CodeBook

This codebook describes the variables and data for the Finaltidydata set.

## Variables Description

**Variables downloaded from the project course**  

features - features.txt file  

activities - activity_labels.txt file  

subject_test - subject_test.txt file  

X_test - X_test.txt file  

y_test - y_test.txt file  

subject_train - subject_train.txt file  

X_train - X_train.txt file  

y_train - y_train.txt file

**Variables after processing**  

combx - created by merging X_test and X_train  

comby - created by merging y_test and y_train  

combsubject - created by merging subject_test and subject_train  

merge_data - created by merging combsubject, combx and comby  

TidyData - created by selecting columns of subject, code and measurements that contain mean and standard deviation. The data set is then label with descriptive variable names  

FinaltidyData - created by summarising TidyData with the average of each variable for each activity and each subject.

