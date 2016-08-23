x <- function() {
  columnnames <- read.table("features.txt", sep = " ", stringsAsFactors = FALSE)
  columnnames$new <- paste(columnnames$V1, columnnames$V2, sep="_")
  trainsample <- cbind(fread("train/X_train.txt", sep=" "), fread("train/y_train.txt"), fread("train/subject_train.txt"))
  testsample <- cbind(fread("test/X_test.txt", sep=" "), fread("test/y_test.txt"), fread("test/subject_test.txt"))
  names(trainsample) <- c(columnnames$new,"activity","subject")
  names(testsample) <- c(columnnames$new,"activity","subject")
  mergedsamples <- rbind(trainsample, testsample)
  mergedsamples$ID<-seq.int(nrow(mergedsamples))
  columnnamesmean <- grep("mean",columnnames$new)
  columnnamesstd <- grep("std",columnnames$new)
  meancolumns <- select(mergedsamples,c(columnnamesmean),562:564)
  stdcolumns <- select(mergedsamples,c(columnnamesstd),562:564)
  finaltable <- merge(meancolumns, stdcolumns, by = c("ID","activity","subject"))
  finaltable$activity <- ordered(finaltable$activity, c(0,1,2,3,4,5,6), labels=c("NA","WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"))
  finaltable$ID <- NULL
  meltedfinaltable <- melt(finaltable,c("activity","subject"))
  castmean <- cast(meltedfinaltable, activity+subject~variable, mean)
}