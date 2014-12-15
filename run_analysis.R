  library(plyr)  
  
  ##################################################################
  # 1. Merges the training and the test sets to create one data set.
  ##################################################################
  
  # download zip file
  temp <- tempfile()
  download.file("http://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", temp)
  
  # unzip file
  unzip(zipfile=temp, exdir="./")

  #remove temp file
  #rm("temp")
  
  ##########
  #load data

  #feature labels
  feature_labels <- read.table("UCI HAR Dataset/features.txt", stringsAsFactors = FALSE, col.names = c("id", "label"))

  #activity labels
  activity_labels<-read.table("UCI HAR Dataset/activity_labels.txt", stringsAsFactors = FALSE, col.names = c("activity.id", "activity.label"))
  
  #train and test data
  xtrain<-read.table("UCI HAR Dataset/train/X_train.txt", col.names = feature_labels$label, stringsAsFactors = FALSE)
  ytrain<-read.table("UCI HAR Dataset/train/y_train.txt", stringsAsFactors = FALSE, col.names = "activity.id")
  subject_train<-read.table("UCI HAR Dataset/train/subject_train.txt", stringsAsFactors = FALSE, col.names = "subject")

  xtest <- read.table("UCI HAR Dataset/test/X_test.txt", col.names = feature_labels$label, stringsAsFactors = FALSE)
  ytest <- read.table("UCI HAR Dataset/test/y_test.txt", stringsAsFactors = FALSE, col.names = "activity.id")
  subject_test<-read.table("UCI HAR Dataset/test/subject_test.txt", stringsAsFactors = FALSE, col.names = "subject")

  #merge train and test data
  x_data <- rbind(xtrain, xtest)
  y_data <- rbind(ytrain, ytest)
  subject_data <- rbind(subject_train, subject_test)
  
  #merge x, y and subject
  all_data <- cbind(x_data, y_data, subject_data)
  
  ##################################################################
  # 2. Extracts only the measurements on the mean and standard deviation for each measurement  
  ##################################################################
  
  all_data <- all_data[, c(grepl("(mean|std)\\(\\)", feature_labels$label), TRUE, TRUE)]

  ##################################################################
  # 3. Uses descriptive activity names to name the activities in the data set
  ##################################################################
  
  all_data <- merge(all_data, activity_labels, by = "activity.id", sort = FALSE)
  
  
  ##################################################################
  # 4. Appropriately labels the data set with descriptive variable names
  ##################################################################
  names(all_data)<-gsub("^t", "time", names(all_data))
  names(all_data)<-gsub("BodyBody", "Body", names(all_data))
  names(all_data)<-gsub("Acc", "Accelerometer", names(all_data))
  names(all_data)<-gsub("Gyro", "Gyroscope", names(all_data))
  names(all_data)<-gsub("^f", "frequency", names(all_data))
  names(all_data)<-gsub("Mag", "Magnitude", names(all_data))
  
  ##################################################################
  # 5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
  ##################################################################
  avg_data <- aggregate(. ~subject + activity.label, all_data, mean)
  avg_data <- avg_data[order(avg_data$subject, avg_data$activity.label), ]
  write.table(avg_data, file = "./avg_data.txt", row.name=FALSE)
  
  