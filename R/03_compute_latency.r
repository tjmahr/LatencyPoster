source('R/01_functions.r', chdir = TRUE)
load("data/rw_ns_data.RData")

# Add a visit number column, based on the date-time of the Session
rw_ns_data <- ddply(rw_ns_data, ~ Subject, DetermineVisitNumber)
# Correct the trial numbering
rw_ns_data <- ddply(rw_ns_data, ~ Subject, RenumberTrials)
# Drop datetime and keeper status (participant matching already accounted for
# keeper status)
rw_ns_data <- subset(rw_ns_data, select = -c(DateTime, Keeper))




#### Add reaction time data ---------------------------------------------------

# Split: by condition
rw_data <- subset(rw_ns_data, Condition == "real") 
ns_data <- subset(rw_ns_data, Condition == "nonsense") 

# Apply: compute latencies
onset_window <- DefineOnsetWindow(starting_time = 0, window_duration = 50)
CalculateRealLatency <- MakeLatencyCalculator(onset_window, "Target")
CalculateNonsenseLatency <- MakeLatencyCalculator(onset_window, "Distractor")

rw_results <- ddply(rw_data, ~ Subject + TrialNo, CalculateRealLatency)
ns_results <- ddply(ns_data, ~ Subject + TrialNo, CalculateNonsenseLatency)

# Combine
results <- rbind(rw_results, ns_results)
results$Version <- factor(ifelse(results$Group == "CS1", "CS1", "CS2"))
results$Condition <- factor(results$Condition)
str(results)

save(results, file = "data/results.Rdata")
