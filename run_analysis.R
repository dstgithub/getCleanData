##### Clean Data 2014 #####
### project ###


# download. 
# make sure the directory has existed
url3p = "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url3p, destfile = "./quiz3/phone.zip", method = "curl")
list.files("./quiz3")

dataDownloaded = date()
dataDownloaded

### unzip the zip file without R

### read file
# train.s.df = read.table("quiz3/UCI HAR Dataset/train/subject_train.txt", sep="")
# head(train.s.df)

#  V1
# 1  1
# 2  1
# 3  1
# 4  1
# 5  1
# 6  1

# dim(train.s.df)
# [1] 7352    1

## training data
train.df = read.table("quiz3/UCI HAR Dataset/train/X_train.txt", sep="")
dim(train.df)
# [1] 7352  561

train.df[, 562] = read.table("quiz3/UCI HAR Dataset/train/Y_train.txt", sep="")

train.df[, 563] = read.table("quiz3/UCI HAR Dataset/train/subject_train.txt", sep="")

## testing data
testing.df = read.table("quiz3/UCI HAR Dataset/test/X_test.txt", sep="")
dim(testing.df)
# [1]  2947  561

testing.df[, 562] = read.table("quiz3/UCI HAR Dataset/test/Y_test.txt", sep="")

testing.df[, 563] = read.table("quiz3/UCI HAR Dataset/test/subject_test.txt", sep="")

## labels
labels = read.table("quiz3/UCI HAR Dataset/activity_labels.txt", sep="")

## Read features; modify some of the  names 
features = read.table("quiz3/UCI HAR Dataset/features.txt", sep="")
features[,2] = gsub('-mean', 'Mean', features[,2])
features[,2] = gsub('-std', 'Std', features[,2])
features[,2] = gsub('[-()]', '', features[,2])

### Merge training and testing data sets
all.df = rbind(train.df, testing.df)


### Extract only the data on mean and std. dev.
mean_std_cols <- grep(".*Mean.*|.*Std.*", features[,2])

# subset of the features table
features <- features[mean_std_cols,]

# add the last two columns (subject and activity)
mean_std_cols <- c(mean_std_cols, 562, 563)

# remove the rest columns from all.df
all.df <- all.df[,mean_std_cols]

# add the column names (features) to all.df
colnames(all.df) <- c(features$V2, "Activity", "Subject")
colnames(all.df) <- tolower(colnames(all.df))

### replace category numbers of labels in all.df to descriptive activity names from label$V2
i = 1
for (activityLabel in labels$V2) {
  all.df$activity <- gsub(i, activityLabel, all.df$activity)
  i <- i + 1
}


all.df$activity <- as.factor(all.df$activity)
all.df$subject <- as.factor(all.df$subject)


### create a tidy data with means
tidyData.df = aggregate(all.df, by=list(activity = all.df$activity, subject=all.df$subject), mean)

# output
write.table(quiz3/tidyData.df, "tidyData.df.txt", sep="\t")
