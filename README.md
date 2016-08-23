# Cleaning-data---Exam
Final exam for the Cleaning and Tidying Data course in Coursera

##Dependant packages
To complete this assignment, I have used the following packages, they will need to be installed:

    install.packages("dplyr")
    install.packages("data.table")
    install.packages("tidyr")
    install.packages("reshape")
    library(dplyr)
    library(data.table)
    library(tidyr)
    library(reshape)

My data is all saved in a folder on my local drive and I set my working directory to be as follows:
    setwd("~/R/Coursera/3. Cleaning and Tidying Data/Week 4/Exam data/UCI HAR Dataset")
    
I chose to put all the commands in one script which is (as requested) called run_analysis.R.

Although it is not necessary to have the column names used on the tables until a much later stage, I felt it was easier to work with them from the beginning. However, I also noticed that there are duplicate column names in the file. I overcame this by creating a new list of column names with a unique identifies at the start of the name. I took this identifier from the table that was created when I imported the features.txt file:

    columnnames <- read.table("features.txt", sep = " ", stringsAsFactors = FALSE)
    columnnames$new <- paste(columnnames$V1, columnnames$V2, sep="_")

The next stage was to import the data from each of the train and test data sets. The data had been separated into 3 files, the main file is X_, with y_ and subject_ each holding one column from the data set. I was concerned that there was no identifying column to allocate each reading in the y_ and subject_ with the correct row of data in the X_ file, so I assumed that the order given was correct:

    trainsample <- cbind(fread("train/X_train.txt", sep=" "), fread("train/y_train.txt"), fread("train/subject_train.txt"))
    testsample <- cbind(fread("test/X_test.txt", sep=" "), fread("test/y_test.txt"), fread("test/subject_test.txt"))

I then added the column names to each of the new data tables:

    names(trainsample) <- c(columnnames$new,"activity","subject")
    names(testsample) <- c(columnnames$new,"activity","subject")

##Part 1
Part 1 of the assignment was "Merges the training and the test sets to create one data set.". This is accomplished as follows:

    mergedsamples <- rbind(trainsample, testsample)

##Part 2
Part 2 of the assignment, "Extracts only the measurements on the mean and standard deviation for each measurement." I chose to do in two stages, one stage for the mean and the other for the standard deviation measurements. However, this meant I needed to bind them together later. To ensure that the rows were bound correctly I assigned a unique identifier to each row of data:

    mergedsamples$ID<-seq.int(nrow(mergedsamples))

I then created a list of the column numbers representing each of the fields for mean and standard deviation separately:

    columnnamesmean <- grep("mean",columnnames$new)
    columnnamesstd <- grep("std",columnnames$new)

By doing it this way, it was easy to select the relevant columns and merge them together into a final table, not forgetting to add the rows for the id, activity and subject:

    meancolumns <- select(mergedsamples,c(columnnamesmean),562:564)
    stdcolumns <- select(mergedsamples,c(columnnamesstd),562:564)
    finaltable <- merge(meancolumns, stdcolumns, by = c("ID","activity","subject"))

##Part 3
Part 3, to "Uses descriptive activity names to name the activities in the data set", I allocated as follows:

    finaltable$activity <- ordered(finaltable$activity, c(0,1,2,3,4,5,6), labels=c("NA","WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))

##Part 4
Part 4 of the assignment requested "Appropriately labels the data set with descriptive variable names.".  As I had been using the descriptive names give in the features.txt file from the beginning, no further action was needed here.


