#Codebook for Final Exam in Cleaning and Tidying Data from Courera

##Variables
###Initial Variables from data set
I am not sure whether we are expected to copy all of the information given in the features_info.txt file to here. If we do it will make this file unreadable. So I have added that file to my repository.

###Created Variables 
columnnames - a data frame containing 3 columns:
	1. V1 - Integer - imported from the features.txt file
	2. V2 - Character - also imported from the features.txt file
	3. new - Character - created from pasting the contents of V1 and V2 and used to name the columns in the tables used for analysis.

trainsample - a data table created from importing the columns from 3 data files supplied: X_train.txt, y_train.txt and subject_train.txt. Has 563 variables and 7352 observations. The column created by y_train took the column name "activity" and the subject_train took the column name "subject".

testsample - a data table created from importing the columns from 3 data files supplied: X_test.txt, y_test.txt and subject_test.txt. Has 563 variables and 2947 observations. The column created by y_test took the column name "activity" and the subject_test took the column name "subject".

mergedsamples - a data table created from merging trainsample and testsample. Has an additional column added for a unique identifier for each row, mergedsamples$ID.

columnnamesmean - an integer list of the column numbers that represent variables that measure the mean of the data.

columnnamesstd - an integer list of the column numbers that represent variables that measure the std of the data.

meancolumns - a data table created from selecting only the columns from the full set of data that relate to variables calculating the mean.

stdcolumns - a data table created from selecting only the columns from the full set of data that relate to variables calculating the std.

finaltable - a data table created by merging meancolumns and stdcolumns. The column for the "activity" was factorized as "NA","WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING"

