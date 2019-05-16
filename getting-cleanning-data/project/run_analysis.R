library("data.table")
library("dplyr")
library("dataMaid")

### Get and Clean Data Project

## Helper functions:

#' Merges the data for subjects, labels, and measurments in a data set.
#' The resulting dataframe is contructed in the following format:
#' subject, label, <measurments...>
#' @param dataSet either "test" or "train"
#' @return a dataset with measurments
putDataTogether <- function(dataSet)
{
    if(dataSet != "test" && dataSet != "train") {
        return(NULL)
    }
    dataPath <- "UCI HAR Dataset"
    myFile.x <- file.path(dataPath, dataSet, paste("X_", dataSet, ".txt", 
                                                   sep = ""))
    myFile.labels <- file.path(dataPath, dataSet, paste("y_", dataSet, ".txt",
                                                        sep = ""))
    myFile.subjects <- file.path(dataPath, dataSet, paste("subject_", dataSet,
                                                          ".txt", sep= ""))
    myData.x <- fread(myFile.x)
    myData.labels <- fread(myFile.labels)
    myData.subjects <- fread(myFile.subjects)
    return(res <- cbind(myData.subjects, myData.labels, myData.x))
}

#' Looks at the features.txt file to determine which are the
#' mean and std related columns.
#'
#' @return a dataframe of feature column indexes and names to keep
getKeepColumns <- function()
{
    myFile.columns <- file.path("UCI HAR Dataset", "features.txt")
    myData.columns <- fread(myFile.columns)
    indexes <- sapply(myData.columns[,2], function(x) {
        grep("mean\\(|std\\(", x)
    })
    
    namesAndIndexes <- myData.columns[indexes, ]
    namesAndIndexes <- namesAndIndexes %>%
        rename(index = V1, variableName = V2)
}    

#' Loads the activity labels dataframe (id to label)
#' @return a dataframe of activity id to activity label
getActivityLabels <- function()
{
    myFile.activities <- file.path("UCI HAR Dataset", "activity_labels.txt")
    myData.activities <- fread(myFile.activities)
}

#' Returns a subset of columns in allDF, as indicated by the indexes in 
#' keepColumns
#'
#' @param allDF is the whole dataframe
#' @param keepColumns is a dataframe with indexes to the columns to keep
#'
#' @return a new dataframe with only the columns indicated by keepColumns, 
#'         plus the first two columns.
shedColumns <- function(allDF, keepColumns)
{
    # allDF includes subject and activity columns, so we need
    # to add two to the keepColumns to align for that.
    shifted <- keepColumns$index + 2
    shifted <- c(1,2,shifted)
    smalerDF <- allDF[, ..shifted]
}

## Driver

# Download data for the project
dataUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
dataZip <- "dataSet.zip"
download.file(dataUrl, dataZip, method="curl")

testDF <- putDataTogether("test")
trainDF <- putDataTogether("train")
keepColumns <- getKeepColumns()
testDF <- shedColumns(testDF, keepColumns)
trainDF <- shedColumns(trainDF, keepColumns)

# join the test and train data sets
wholeDF <- rbind(testDF, trainDF)
rm(testDF)
rm(trainDF)

# set the proper column names
colnames(wholeDF) <- c("subject", "activity", keepColumns$variableName)
summarizedDF <- wholeDF %>% 
    group_by(subject, activity) %>%
    summarize_all(mean)

# change the activity number to the activity label
activityLabels <- getActivityLabels()
summarizedDF$activity <- sapply(summarizedDF$activity, function(x) {
    activityLabels[[x,2]]
})

write.table(summarizedDF, file = "tidyData.txt", row.name=FALSE)