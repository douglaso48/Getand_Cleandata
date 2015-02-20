#setwd("~/R/assignment")
run_analysis <- function(){ 

library(downloader)
library(dplyr)
library(reshape2)


##obtain the file and unzip

##download("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip" , dest="dataset.zip", mode="wb") 
##unzip ("dataset.zip")
##obtain the explanatory web page
##download("http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones", dest="read_me.html")

#create helper functions to tidy the variable names

legal<- function(original, changed, x, ...) {
        for(i in 1:length(original))
                x <- gsub(original[i], changed[i], x, ...)
        x
}

final<- function(original, changed, y, ...) {
        for(i in 1:length(original))
                y <- sub(original[i], changed[i], y, ...)
        y
}

#deal with the test and train sets individually, then combine

#dealing first with the test set

test_values<- read.table("UCI HAR Dataset/test/X_test.txt", quote="\"", stringsAsFactors=FALSE)
test_activities<- read.table("UCI HAR Dataset/test/y_test.txt", quote="\"", stringsAsFactors=FALSE)
test_testers<- read.table("UCI HAR Dataset/test/subject_test.txt", quote="\"", stringsAsFactors=FALSE)
test_signals<- read.table("UCI HAR Dataset/features.txt", quote="\"", stringsAsFactors=FALSE)
activity_labels <- read.table("UCI HAR Dataset/activity_labels.txt", quote="\"", stringsAsFactors=FALSE)

# resetting the test labels from numerical to character (lower case)

test_activities[,1]<-sapply(test_activities[,1], switch,  "1" = "walking", "2"="walking_upstairs", "3"="walking_downstairs", "4"="sitting", "5"="standing", "6"="laying")


#cleaning up the variable names and labels by making them legal in R, removing the typos and setting to lower case.

test_signals[,2]<- tolower(test_signals[,2])

from <- c("-", "\\(","\\)",",","bodybody")
to <- c( "_", "","","_", "body")

test_signals[,2]<- legal(from, to, test_signals[,2])


#setting the column names for the sets to be joined.
colnames(test_values)<- test_signals[,2]
colnames(test_testers)<- "tester"
colnames(test_activities)<- "activity"


#subsetting to those containing mean or standard deviation

test_values<- test_values[,grepl(".*mean.*|.*std.*", names(test_values))]

# removing non-compliant tests
test_values<- test_values[,!grepl(".freq.*|.*angle.*", names(test_values))]

# expanding "t" & "f" to a fuller form (done at this stage to avoid identification issues)
a<- c("^t", "f")
b<- c("time", "frequency")

colnames(test_values)<- final(a,b, colnames(test_values))

#joining the column names, row names, test names and data together

test_set<- cbind(test_testers,test_activities,test_values)


#dealing with the training set in the same way

train_values<- read.table("UCI HAR Dataset/train/X_train.txt", quote="\"", stringsAsFactors=FALSE)
train_activities<- read.table("UCI HAR Dataset/train/y_train.txt", quote="\"", stringsAsFactors=FALSE)
train_testers<- read.table("UCI HAR Dataset/train/subject_train.txt", quote="\"", stringsAsFactors=FALSE)
train_signals<- read.table("UCI HAR Dataset/features.txt", quote="\"", stringsAsFactors=FALSE)

# resetting the train labels from numerical to character (lower case)

train_activities[,1]<-sapply(train_activities[,1], switch,  "1" = "walking", "2"="walking_upstairs", "3"="walking_downstairs", "4"="sitting", "5"="standing", "6"="laying")

#cleaning up the variable names and labels by making them legal in R, removing the typos and setting to lower case.

train_signals[,2]<- tolower(train_signals[,2])

train_signals[,2]<- legal(from, to, train_signals[,2])


#setting the column names for the sets to be joined.
colnames(train_values)<- train_signals[,2]
colnames(train_testers)<- "tester"
colnames(train_activities)<- "activity"


#subsetting to those containing mean or standard deviation

train_values<- train_values[,grepl(".*mean.*|.*std.*", names(train_values))]

# removing non-compliant tests
train_values<- train_values[!grepl(".freq.*|.*angle.*", names(train_values))]

#resetting the "t" & "f", reusing test code
colnames(train_values)<- final(a,b, colnames(train_values))

#joining the column names, row names, test names and data together
train_set<- cbind(train_testers, train_activities, train_values)

#joining the test and train sets.
output<- rbind(test_set,train_set)

#calculate the means (this produces the wide form)
output<- output %>% group_by(tester,activity) %>% summarise_each(funs(mean))


#reshaping to narrow form

tidy<-melt(output, id=c("tester", "activity")) 
colnames(tidy)<- c("tester", "activity", "signal", "value")

#creating an index
tidy$var<-tidy$signal

#reducing the index names to mean & std
d<- c(".*mean.*", ".*std.*")
e<- c("mean", "std")
tidy$var<- legal(d,e, tidy$var)

#removing the words mean & standard from "test" column to allow collapse
m<- c("_mean", "_std")
p<- c("","")
tidy$signal<- legal(m,p, tidy$signal )

#recasting mean & std into columns
tidy<- dcast(tidy, ...~var)

#writing the output txt
write.table(tidy, file = "tidyset.txt", row.names = FALSE)
}