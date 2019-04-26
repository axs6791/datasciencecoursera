#' R Programming Week 2 Assignment

#' Part 3

#' Computes the correclation between sulfate and nitrate for monitor that pass
#' a given threashold of complete salmples
#'
#' @param directory a string containing a directory containing pollutant data 
#'                  files.
#' @param threashold is the minimum number of complete measurments requiered to 
#'                   compute the threashold
#' @return a dataframe of the from id, nobs
corr <- function(directory, threashold=0)
{
    completePerFile = complete(directory)
    res = c()
    for (row in 1:nrow(completePerFile)) {
        if(completePerFile[row, "nobs"] >= threashold) {
            datafile.name <- sprintf("%s/%03d.csv", directory, 
                                     completePerFile[row, "id"])
            filedata <- read.csv(datafile.name, header=TRUE)
            cmpl_data <- complete.cases(filedata)
            val <- cor(filedata[["sulfate"]], filedata[["nitrate"]],use="pairwise.complete.obs")
            res <- append(res, val)
        }
    }
    res
}