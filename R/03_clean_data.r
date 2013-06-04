source('01_functions.r', chdir = TRUE)
load("data/rw_data.RData")

# Add a visit number column, based on the date-time of the Session
rw_data <- ddply(rw_data, ~ Subject, DetermineVisitNumber)

# Correct the trial numbering
rw_data <- ddply(rw_data, ~ Subject, RenumberTrials)

save(clean, file = "data/clean.RData")