getwd()

library(dplyr)

## Download data set
# Check if directory exists
if(!file.exists("Data")){dir.create("Data")}

fname = "UCI HAR Dataset.rar"
# Check if zip file exists
if(!file.exists(fname)){
  url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
  zfile <- paste("./Data/",fname,sep="")
  download.file(url,destfile=zfile,method="curl")
}

# Check if file unzipped 
if(!file.exists("UCI HAR Dataset")){
  unzip(zfile,exdir="./Data")
}

## Load and read file
features <- read.table("./Data/UCI HAR Dataset/features.txt", col.names=c("n","functions"))  
dim(features)
activities <- read.table("./Data/UCI HAR Dataset/activity_labels.txt", col.names=c("labels","activity"))
dim(activities)
subject_test <- read.table("./Data/UCI HAR Dataset/test/subject_test.txt", col.names="subject")
dim(subject_test)
subject_train <- read.table("./Data/UCI HAR Dataset/train/subject_train.txt", col.names="subject")
dim(subject_train)
x_test <- read.table("./Data/UCI HAR Dataset/test/X_test.txt",col.names = features$functions)
dim(x_test)
y_test <- read.table("./Data/UCI HAR Dataset/test/y_test.txt",col.names="labels")
dim(y_test)
x_train <- read.table("./Data/UCI HAR Dataset/train/X_train.txt",col.names = features$functions)
dim(x_train)
y_train <- read.table("./Data/UCI HAR Dataset/train/y_train.txt",col.names="labels")
dim(y_train)

## Merge training data and test data into one
## Extract columns only with measurements of mean and std
X <- rbind(x_train,x_test)
col_X <- colnames(X) # preview original column names
col_mean_std <- col_X[grep("[Mm]ean|std",col_X)] # column only
X_sub <- X[grep("[Mm]ean|std",colnames(X))] # subset columns with measurements on mean and std

y <- rbind(y_train,y_test)
subject <- rbind(subject_train,subject_test) # merge by row
merged <- cbind(subject,y,X_sub) # merge by column


## Assign activity names in the data set for each label
merged[merged$labels == 1,2] <- activities$activity[1] 
merged[merged$labels == 2,2] <- activities$activity[2]
merged[merged$labels == 3,2] <- activities$activity[3]
merged[merged$labels == 4,2] <- activities$activity[4]
merged[merged$labels == 5,2] <- activities$activity[5]
merged[merged$labels == 6,2] <- activities$activity[6]

str(merged)
View(merged)# checkpoint

## Rename variable with descriptive names
colnames(merged)[2] <- "Activity"
names(merged) <- gsub("[^a-zA-Z]","",names(merged)) # removes non-alphabet characters
names(merged) <- gsub("mean|Mean","_Mean",names(merged))
names(merged) <- gsub("std","_Std",names(merged))
names(merged) <- gsub("BodyBody","Body",names(merged))
names(merged) <- gsub("^t","Time",names(merged))
names(merged) <- gsub("^f","Freq",names(merged))
names(merged) <- gsub("anglet","AngleTime",names(merged))
names(merged) <- gsub("angle","Angle",names(merged))
names(merged) <- gsub("gravity","Gravity",names(merged))

## Convert data type
merged <- merged %>%
  mutate_at("subject",as.factor) %>%
  mutate(Activity = factor(Activity, levels=activities[,2]))

## Create an independent tidy data set with average of each variable, group by subject and activity
tidydata <- merged %>%
  group_by(subject,Activity) %>%
  summarise_all(mean) 

View(tidydata)  
str(tidydata) # Checkpoint

## Export tidy data file
write.table(tidydata,"./tidy_dataset.txt",row.names=FALSE)