#' R Programming Week 2 Assignment

#' Part 2

#' Creates a dataframe of ids to nobs, complete obserations.
#'
#' @param directory a string containing a directory containing pollutant data files.
#' @param id a collection of integers that represent the data files to load.
#' @return a dataframe of the from id, nobs
complete <- function(directory, id=1:332)
{
    res = data.frame(id=integer(), nobs=integer())
    for(fileid in id) {
        datafile.name <- sprintf("%s%03d.csv", directory, fileid)
        filedata <- read.csv(datafile.name, header=TRUE)
        cmpl_data <- complete.cases(filedata)
        res<-rbind(res, c(fileid, nrow(filedata[cmpl_data,])))
    }
    colnames(res)<-c("id", "nobs")
    res
}