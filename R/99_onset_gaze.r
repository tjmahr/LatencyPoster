# Quick and dirty analysis to see if vocab predict RT when the child was viewing
# the animated vs the static image at time 0

source('R/01_functions.r')

# Load the gaze data, drop most test scores.
load("data/rw_ns_data.RData")
d <- rw_ns_data
d <- d[, 1:18]
# Keep just the trials with an animated image in the center
d <- subset(d, Group != "CS1")
str(d)

# Add a visit number column, based on the date-time of the Session
d <- ddply(d, ~ Subject, DetermineVisitNumber)
# Correct the trial numbering
d <- ddply(d, ~ Subject, RenumberTrials)
# Remove some more columns
d <- subset(d, select = -DateTime)


#### Add reaction time data ---------------------------------------------------

# Split: by condition
rw_data <- subset(d, Condition == "real") 
ns_data <- subset(d, Condition == "nonsense") 

# Apply: compute latencies
onset_window <- DefineOnsetWindow(starting_time = 0, window_duration = 50)
CalculateRealLatency <- MakeLatencyCalculator(onset_window, "Target")
CalculateNonsenseLatency <- MakeLatencyCalculator(onset_window, "Distractor")

rw_results <- ddply(d, ~ Subject + TrialNo, CalculateRealLatency)
ns_results <- ddply(d, ~ Subject + TrialNo, CalculateNonsenseLatency)

# Combine
results <- rbind(rw_results, ns_results)


results <- subset(results, is.element(OnsetGaze, c("Distractor", "Target", "Fixation")))
results$OnsetGaze <- ifelse(results$OnsetGaze == "Fixation", "Fixation", "Static")

str(results)
# Compute percentage captured
original <- ddply(results, ~ OnsetGaze + Condition, summarize, 
                  Percent = 100 - CalculatePercentNA(Latency))





TrimTooFast_OnsetGaze <- function(results, cutoff = 250) {
  results$TooFast <- round(results$Latency) <= cutoff
  # How many latencies were too fast within each group
  too_fast <- dcast(results, OnsetGaze ~ TooFast, length, value.var = "TooFast")
  names(too_fast) <- sprintf(c("Version", "Num > %1.f ms", "Num <= %1.f ms", "Num NA"), cutoff)
  PrettyPrint(too_fast, digits = 0, include.rownames = FALSE)
  # Replace too-fast latencies with NA values
  results$Latency[round(results$Latency) < cutoff] <- NA  
  results$TooFast <- NULL
  results
}




# Remove too fast and too slow latencies
results <- TrimTooFast_OnsetGaze(results, cutoff = 250)
results <- TrimByGroup(results, group = ~ OnsetGaze)
trimmed <- ddply(results, ~ OnsetGaze + Condition, summarize, 
                 Percent = 100 - CalculatePercentNA(Latency))

# Mean latencies by condition x onset-gaze
means <- aggregate(Latency ~ OnsetGaze + Condition, data = results, mean_sd)
means$Condition <- ifelse(means$Condition == "real", "Correct Productions (ms)", "Nonwords (ms)")
means_table <- dcast(means, OnsetGaze ~ Condition)
means_table

# Distribution of the four latencies
qplot(data = results, x = Latency) + facet_grid(OnsetGaze ~ Condition) + 
  theme_bw() + labs(x = "Latency (ms)", y = "Count") +
  theme(text = element_text(size = 20))




# Aggregate on subject means within each condition
subject_means <- aggregate(Latency ~ Subject + Age + EVT + OnsetGaze + Condition, 
                           data = results, Average)
# Subset by experimental version
subject_means <- mutate(subject_means, Condition = ifelse(Condition == "real", "CP", "NW"))
m1 <- lm(Latency ~ EVT + Age + Condition + OnsetGaze, subject_means)
summary(m1)

# Within subjects version
m <- lmer(Latency ~ EVT + Age + Condition + OnsetGaze + (1|Subject), results)
summary(m)


ggplot(data = subject_means, aes(x = EVT, y = Latency, color = Condition)) + 
  geom_point(size = 2.5) + facet_grid( ~ OnsetGaze) +
  geom_smooth(method = "lm", level = .68) + theme_bw() + 
  labs(x = "EVT-2", y = "Mean Latency (ms)", color = "Trial Type") + 
  theme(legend.position = "bottom", text = element_text(size = 20)) + 
  scale_colour_brewer(palette="Set1")



subject_means2 <- aggregate(Latency ~ Subject + Age + EVT + OnsetGaze, 
                            data = results, Average)
m2 <- lm(Latency ~ EVT * OnsetGaze, subject_means)
summary(m2)

ggplot(data = subject_means2, aes(x = EVT, y = Latency, color = OnsetGaze)) + 
  geom_point(size = 2.5) + 
  geom_smooth(method = "lm", level = .68) + theme_bw() + 
  labs(x = "EVT-2", y = "Mean Latency (ms)") + 
  theme(text = element_text(size = 20)) + 
  scale_colour_brewer(palette="Set1")
