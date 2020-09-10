This code book illustrates the details of run_analysis.R from data collection, wrangling, to a tidy data set. All associated variables, the data, and any transformations performed will be discussed, in following order:
 
 1. Download data set from source to directory, then unzip:
    link: <https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip>
  
 2. Load and read files in table format:
    - features: list of all 561 measurement features with time and domain variables (561 rows, 2 cols)
    ** Note: Refer "features.txt" for detailed list of measurements
    - activities: activity labels and the corresponding names (6 rows, 2 cols)
    - subject_test: identifies the subject from a group of 30 that perform list of activities, split in a test set (2947 rows, 1 col)
    - subject_train: identifies the subject from a group of 30 that perform list of activities, split in a train set (7352 rows, 1 col)
    - x_test: test set and corresponding measurement features (2947 rows, 561 cols)
    - x_train: training set and corresponding measurement features (7352 rows, 561 cols)
    - y_test: activity labels in a test set (2947 rows, 1 col)
    - y_train: activity labels in a training set (7352 rows, 1 col)
  
  3. Merge to one big data frame -> (merged):
    - X: merge x_test and x_train with rbind() (10299 rows, 561 cols)
    - X_sub: subsets/keeps only measurements of mean and std (10299 rows, 86 cols)
    - y: merge y_test and y_train with rbind() (10299 rows, 1 col)
    - subject: Merge subject_test and subject_train with rbind() (10299 rows, 1 col)
    - merged: merge with cbind() in the order of: subject, y, X_sub (10299 rows, 88 cols)
    
  4. Assign activity labels with descriptive names:
    - Replace all observations under "labels" column to  corresponding activity name (e.g: for labels 1, replace to "WALKING")
  
  5. Update variable names for readability:
    - Rename "labels" to "Activity"
    - All variable names with non-alphabet characters are removed
    - All names with "mean" or "Mean" changed to "_Mean"
    - All names with "std" changed to "_Std"
    - All names with "BodyBody" simplified to "Body"
    - All names starts with "t" changed to "Time"
    - All names starts with "f" changed to "Freq"
    - All names with "anglet" changed to "AngleTime"
    - All names with "angle" changed to "Angle"
    - All names with "gravity" changed to "Gravity"
    
  6. Update variable type (with dplyr):
    - "subject": from integer to factor 
    - "Activity": to factor with levels (2nd column of activity_labels.txt)
    
  7. From data frame, create another independent data set with average of each measurements by each subject and Activity (with dplyr):
    - Creates summary data "tidydata" (180 rows, 88 cols)
    - Export data with write.table() as "tidy_dataset.txt" file
    
    
** Variable names in tidy_dataset.txt:
* Unique Labels
[1] "subject"     : Refers to subject ID                         
[2] "Activity"    : Refers to Activity Name performed by subject

* The rests are measurement variables
[3] "TimeBodyAcc_MeanX"                     
[4] "TimeBodyAcc_MeanY"                     
[5] "TimeBodyAcc_MeanZ"                     
[6] "TimeBodyAcc_StdX"                      
[7] "TimeBodyAcc_StdY"                      
[8] "TimeBodyAcc_StdZ"                      
[9] "TimeGravityAcc_MeanX"                  
[10] "TimeGravityAcc_MeanY"                  
[11] "TimeGravityAcc_MeanZ"                  
[12] "TimeGravityAcc_StdX"                   
[13] "TimeGravityAcc_StdY"                   
[14] "TimeGravityAcc_StdZ"                   
[15] "TimeBodyAccJerk_MeanX"                 
[16] "TimeBodyAccJerk_MeanY"                 
[17] "TimeBodyAccJerk_MeanZ"                 
[18] "TimeBodyAccJerk_StdX"                  
[19] "TimeBodyAccJerk_StdY"                  
[20] "TimeBodyAccJerk_StdZ"                  
[21] "TimeBodyGyro_MeanX"                    
[22] "TimeBodyGyro_MeanY"                    
[23] "TimeBodyGyro_MeanZ"                    
[24] "TimeBodyGyro_StdX"                     
[25] "TimeBodyGyro_StdY"                     
[26] "TimeBodyGyro_StdZ"                     
[27] "TimeBodyGyroJerk_MeanX"                
[28] "TimeBodyGyroJerk_MeanY"                
[29] "TimeBodyGyroJerk_MeanZ"                
[30] "TimeBodyGyroJerk_StdX"                 
[31] "TimeBodyGyroJerk_StdY"                 
[32] "TimeBodyGyroJerk_StdZ"                 
[33] "TimeBodyAccMag_Mean"                   
[34] "TimeBodyAccMag_Std"                    
[35] "TimeGravityAccMag_Mean"                
[36] "TimeGravityAccMag_Std"                 
[37] "TimeBodyAccJerkMag_Mean"               
[38] "TimeBodyAccJerkMag_Std"                
[39] "TimeBodyGyroMag_Mean"                  
[40] "TimeBodyGyroMag_Std"                   
[41] "TimeBodyGyroJerkMag_Mean"              
[42] "TimeBodyGyroJerkMag_Std"               
[43] "FreqBodyAcc_MeanX"                     
[44] "FreqBodyAcc_MeanY"                     
[45] "FreqBodyAcc_MeanZ"                     
[46] "FreqBodyAcc_StdX"                      
[47] "FreqBodyAcc_StdY"                      
[48] "FreqBodyAcc_StdZ"                      
[49] "FreqBodyAcc_MeanFreqX"                 
[50] "FreqBodyAcc_MeanFreqY"                 
[51] "FreqBodyAcc_MeanFreqZ"                 
[52] "FreqBodyAccJerk_MeanX"                 
[53] "FreqBodyAccJerk_MeanY"                 
[54] "FreqBodyAccJerk_MeanZ"                 
[55] "FreqBodyAccJerk_StdX"                  
[56] "FreqBodyAccJerk_StdY"                  
[57] "FreqBodyAccJerk_StdZ"                  
[58] "FreqBodyAccJerk_MeanFreqX"             
[59] "FreqBodyAccJerk_MeanFreqY"             
[60] "FreqBodyAccJerk_MeanFreqZ"             
[61] "FreqBodyGyro_MeanX"                    
[62] "FreqBodyGyro_MeanY"                    
[63] "FreqBodyGyro_MeanZ"                    
[64] "FreqBodyGyro_StdX"                     
[65] "FreqBodyGyro_StdY"                     
[66] "FreqBodyGyro_StdZ"                     
[67] "FreqBodyGyro_MeanFreqX"                
[68] "FreqBodyGyro_MeanFreqY"                
[69] "FreqBodyGyro_MeanFreqZ"                
[70] "FreqBodyAccMag_Mean"                   
[71] "FreqBodyAccMag_Std"                    
[72] "FreqBodyAccMag_MeanFreq"               
[73] "FreqBodyAccJerkMag_Mean"               
[74] "FreqBodyAccJerkMag_Std"                
[75] "FreqBodyAccJerkMag_MeanFreq"           
[76] "FreqBodyGyroMag_Mean"                  
[77] "FreqBodyGyroMag_Std"                   
[78] "FreqBodyGyroMag_MeanFreq"              
[79] "FreqBodyGyroJerkMag_Mean"              
[80] "FreqBodyGyroJerkMag_Std"               
[81] "FreqBodyGyroJerkMag_MeanFreq"          
[82] "AngleTimeBodyAcc_MeanGravity"          
[83] "AngleTimeBodyAccJerk_MeanGravity_Mean" 
[84] "AngleTimeBodyGyro_MeanGravity_Mean"    
[85] "AngleTimeBodyGyroJerk_MeanGravity_Mean"
[86] "AngleXGravity_Mean"                    
[87] "AngleYGravity_Mean"                    
[88] "AngleZGravity_Mean"    
  
  