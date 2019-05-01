library("datasets")

#' Creates a dataset of hospitals at the given rank (num) to the mortality rate for the given outcome
#'
#' @param outcome one of three valid conditions: heart attack, heart failure, or pneumonia.
#' @param num the result(s) to return. Acceptable values are "best", "worst", or a value.
#'
#' @return The name of the hospital with the least mortality rate in a given state and outcome.
rankall <- function(outcome, num = "best") {
    ## Read outcome data
    outcome.data <- read.csv("outcome-of-care-measures.csv",
                             colClasses = "character")
    mortality_column <- 0

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
    outcome.data[,mortality_column] <- as.numeric(outcome.data[, mortality_column])
    # remove NA values from the appropriate mortality rate column
    outcome.data <- outcome.data[!is.na(outcome.data[,mortality_column]),]
    by_state <- split(outcome.data, outcome.data$State)

    # validate num
    res_index = 0
    if(num == "best") {
        res_index <- 1
    } else if (num == "worst") {
        res_index <- nrow(ordered_per_state)
    } else {
        res_index <- as.numeric(num)
    }

    res <- data.frame(row.names = c("hospital", "state"))
    lapply(by_state, function(state_records) {
        ordered_per_state <- state_records[order(state_records[,mortality_column],
                                                 state_records[,2]),]

        res <<- rbind(res, data.frame(hospital=ordered_per_state[res_index, 2],
                                     state=state_records[1, 7]))
    })
    res
}
