library("datasets")

#' Gets the hospital with the lowest mortality rate for a
#' given state and condition
#'
#' @param state is the two letter abbreviation of a U.S. state. i.e. NY or MD
#' @param outcome one of three valid conditions: heart attack, heart failure, or pneumonia.
#'
#' @return The name of the hospital with the least mortality rate in a given state and outcome.
best <- function(state, outcome) {
    ## Read outcome data
    outcome.data <- read.csv("outcome-of-care-measures.csv",
                             colClasses = "character")

    outcome.types<- c("heart attack", "heart failure", "pneumonia")
    mortality_column <- 0

    ## Check that state and outcome are valid
    # validate state
    if(!(state %in% state.abb)) {
        message(paste("Error in best(", state, ", ", outcome,
                      ") : invalid state)", sep="" ))
        stop()
    }
    # validate condition, and set column number
    if (outcome == "heart attack") {
        mortality_column <- 11
    } else if(outcome == "heart failure") {
        mortality_column <- 17
    } else if(outcome == "pneumonia") {
        mortality_column <- 23
    } else {
        message(paste("Error in best(", state, ", ", outcome,
                      ") : invalid outcome)", sep="" ))
        stop()
    }

    ## Return hospital name in that state with lowest 30-day death
    ## rate
    per_state <- subset(outcome.data, State == state)
    per_state[,mortality_column] <- as.numeric(per_state[, mortality_column])
    ordered_per_state <- per_state[order(per_state[,mortality_column],
                                         per_state[,2]),]
    #ordered_per_state[,c(2,mortality_column)]
    ordered_per_state$Hospital.Name[1]
}
