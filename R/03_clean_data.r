source('01_functions.r', chdir = TRUE)
load("data/rw_data.RData")
load("data/ns_data.RData")
# Add a visit number column, based on the date-time of the Session
rw_data <- ddply(rw_data, ~ Subject, DetermineVisitNumber)

# Correct the trial numbering
rw_data <- ddply(rw_data, ~ Subject, RenumberTrials)

save(clean, file = "data/clean.RData")



# Compute latencies
onset_window <- DefineOnsetWindow(starting_time = 0, window_duration = 50)
CalculateRealLatency <- MakeLatencyCalculator(onset_window, "Target")
results <- ddply(clean, ~ Subject + TrialNo, CalculateRealLatency)

# Combine two versions of Cross-sectional2 into same grouping factor
results$Version <- factor(ifelse(results$Group == "CS1", "CS1", "CS2"))

save(results, file="data/results.Rdata")
