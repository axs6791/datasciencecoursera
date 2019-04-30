library("datasets")

#' best.
#'
#' @param state
#' @param outcome
#'
#' @return
best <- function(state, outcome) {
    ## Read outcome data
    outcome_data <- read.csv("outcome-of-care-measures.csv",
                             colClasses = "character")

    # possible outcomes
    outcome.types<- c("heart attack", "heart failure", "pneumonia")

    ## Check that state and outcome are valid
    if(!(state %in% state.abb)) {
        message(paste("Error in best(", state, ", ", outcome,
                      ") : invalid state)", sep="" ))
        #print("bad state")
        return()
    }
    else if (!(outcome %in% outcome.types)) {
        message(paste("Error in best(", state, ", ", outcome,
                      ") : invalid outcome)", sep="" ))
        #print("bad outcome")
        return()
    }

    ## Return hospital name in that state with lowest 30-day death
    ## rate
    print("Its ok")
}
