The dataset includes the following files (under "UCI HAR Dataset" directory):
- 'README.txt'
- 'features_info.txt': Shows information about the variables used on the feature vector.
- 'features.txt': List of all features.
- 'activity_labels.txt': Links the class labels with their activity name.
- 'train/X_train.txt': Training set.
- 'train/y_train.txt': Training labels.
- 'test/X_test.txt': Test set.
- 'test/y_test.txt': Test labels.

Variables :
- temp : temp file used to download and unzip the dataset
- feature_labels, activity_labels, x_train, y_train, subject_train, x_test, y_test, subject_test : contain the data from the downloaded files
  Data are loaded with data.read() function with columns names setting as follow :
    - feature_labels : id, label
    - activity_labels : activity.id, activity.label
- x_data, y_data, subject_data : merge of corresponding test and train data (done with rbind() function)
- all_data : 
  - merge of all data (x, y and subject) (done with cbid() function)
  - with only feature column which contains mean or std measurement 
  - with activity.label column added and set thanks to a join with activity_labels table 
  - with feature columns names modified as follow :
    - t -> time
    - BodyBody -> Body
    - Acc -> Accelerometer
    - Gyro -> Gyroscope
    - f -> frequency
    - Mag -> Magnitude
- avg_data : from all_data, average of each variable for each activity and each subject, ordered by subject and activity
  file avg_data.txt as output file of avg_data thanks to a call to write.table function
