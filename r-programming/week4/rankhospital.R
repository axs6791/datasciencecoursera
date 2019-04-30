library("datasets")

#' Gets a range of hospitals with the lowest mortality rate for a
#' given state and condition
#'
#' @param state is the two letter abbreviation of a U.S. state. i.e. NY or MD.
#' @param outcome one of three valid conditions: heart attack, heart failure, or pneumonia.
#' @param num the result(s) to return. Acceptable values are "best", "worst", or a value.
#'
#' @return The name of the hospital with the least mortality rate in a given state and outcome.
rankhospital <- function(state, outcome, num = "best") {
    ## Read outcome data
    outcome.data <- read.csv("outcome-of-care-measures.csv",
                             colClasses = "character")
    mortality_column <- 0

    ## Check that state and outcome are valid
    # validate state
    if(!(state %in% state.abb)) {
        stop()
    }
    # validate outcome and set mortality_column
    if (outcome == "heart attack") {
        mortality_column <- 11
    } else if(outcome == "heart failure") {
        mortality_column <- 17
    } else if(outcome == "pneumonia") {
        mortality_column <- 23
    } else {
        stop()
    }

    ## Return hospital name in that state with lowest 30-day death
    ## rate
    per_state <- subset(outcome.data, State == state)
    per_state[,mortality_column] <- as.numeric(per_state[, mortality_column])
    # remove NA values from the appropriate mortality rate column
    per_state <- per_state[!is.na(per_state[,mortality_column]),]
    ordered_per_state <- per_state[order(per_state[,mortality_column],
                                         per_state[,2]),]

    # validate num
    res_range = 0
    if(num == "best") {
       res_range <- 1
    } else if (num == "worst") {
       res_range <- nrow(ordered_per_state)
    } else {
       res_range <- as.numeric(num)
    }
    ordered_per_state[res_range, 2]
    #ordered_per_state$Hospital.Name[1]
}
