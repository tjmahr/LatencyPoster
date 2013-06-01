source('01_functions.r', chdir = TRUE)
load("data/rw_data.RData")

clean <- ddply(rw_data, ~ Subject, DetermineVisitNumber)
clean <- ddply(rw_data, ~ Subject, RenumberTrials)

