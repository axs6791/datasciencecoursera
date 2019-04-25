#' R Programming Week 2 Assignment

#' Part 1

#' Computes means of a given polutant, over the given files defined by id indexed files
#' that live in directory
#'
#' @param directory a string containing a directory containing pollutant data files.
#' @param pollutant a string: either \emph{'nitrate'} or \empth{'sulfate'}.
#' @param id a coolection of integers that represent the data files to load.
#' @return a double representation of the mean. NA if there are any bad arguments.
pollutandmean <- function(directory, pollutant, id=1:332)
{
    if(pollutant != "nitrate" && pollutant != "sulfate") {
        return(NA)
    }
    
    datafile.data <- vector()
    for(fileid in id) {
        datafile.name <- sprintf("%s%03d.csv", directory, fileid)
        filedata <- read.csv(datafile.name, header=TRUE)
        pd <- filedata[pollutant]
        pd <- pd[!is.na(pd)]
        datafile.data <- c(datafile.data, pd)
    }
    mean(datafile.data)
}
    