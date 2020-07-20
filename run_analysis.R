#create a new data folder and download the dataset into it

if(!file.exists("./data")){dir.create("./data")}

fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile="./data/dataset.zip", method ="curl")

## unzip the file

unzip(zipfile="./data/dataset.zip", exdir = "./data")

## read the data from the files into R

features <- read.table("./data/UCI HAR Dataset/features.txt", col.names = c("n","functions"))
activities <- read.table("./data/UCI HAR Dataset/activity_labels.txt", col.names = c("code", "activity"))

subject_test <- read.table("./data/UCI HAR Dataset/test/subject_test.txt", col.names = "subject")
X_test <- read.table ("./data/UCI HAR Dataset/test/X_test.txt",col.names = features$functions )
y_test <- read.table ("./data/UCI HAR Dataset/test/y_test.txt", col.names = "code")

subject_train <- read.table("./data/UCI HAR Dataset/train/subject_train.txt", col.names = "subject")
X_train <- read.table ("./data/UCI HAR Dataset/train/X_train.txt", col.names = features$functions)
y_train <- read.table ("./data/UCI HAR Dataset/train/y_train.txt", col.names = "code")

## 1. Merges the training and the test sets to create one data set.

combx <- rbind(X_train, X_test)
comby <- rbind(y_train, y_test)
combsubject <- rbind(subject_train,subject_test)

merge_data <- cbind (combsubject, combx,comby)

## 2. Extracts only the measurements on the mean and standard deviation for each measurement.

TidyData <- merge_data %>% select(subject, code, contains("mean"), contains("std"))

## 3. Uses descriptive activity names to name the activities in the data set

TidyData$code <- activities[TidyData$code, 2]

## 4. Appropriately labels the data set with descriptive variable names.

names(TidyData)[2] = "activity"
names(TidyData)<-gsub("^t", "Time", names(TidyData))
names(TidyData)<-gsub("^f", "Frequency", names(TidyData))
names(TidyData)<-gsub("Acc", "Accelerometer", names(TidyData))
names(TidyData)<-gsub("Gyro", "Gyroscope", names(TidyData))
names(TidyData)<-gsub("Mag", "Magnitude", names(TidyData))
names(TidyData)<-gsub("BodyBody", "Body", names(TidyData))


## 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

FinaltidyData <- TidyData %>%
  group_by(subject, activity) %>%
  summarise_all(funs(mean))
write.table(FinaltidyData, "FinaltidyData.txt", row.name=FALSE)


