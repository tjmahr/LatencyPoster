

# Compute latencies
onset_window <- DefineOnsetWindow(starting_time = 0, window_duration = 50)
CalculateRealLatency <- MakeLatencyCalculator(onset_window, "Target")

# Combine two versions of Cross-sectional2 into same grouping factor
results <- ddply(rw_data, ~ Subject + TrialNo, CalculateRealLatency)

results <- ddply(rw_data, ~ Subject + TrialNo, CalculateRealLatency)







results$Version <- factor(ifelse(results$Group == "CS1", "CS1", "CS2"))

# Renumber trials
unique(clean$TrialNo - clean$Trial)

by(clean$Trial, INDICES = clean[c("Group", "Block")], max)



qplot(data = results, x = Latency) + scale_x_continuous(breaks = (0:5 * 500)) + 
  facet_grid(Version ~ .)










qplot(data = results, x = Latency) 
  labs(title = "latencies for real words in CS2 (606 of 948 trials)")

qplot(data = results, x = Latency) + scale_x_continuous(breaks = (0:5 * 500)) + 
  labs(title = "latencies for real words in CS1 (397 of 1224 trials)")


latencies_1 <- read.csv("CS1_realword_trials.csv", row.names = NULL)
latencies_1 <- subset(latencies_1, select = -X)
latencies_1$Group <- "CS1"

trial_frame$Group <- "CS2"

all_the_data <- rbind(latencies_1, trial_frame)

all_the_data$Subject <- factor(str_extract(all_the_data$Subject, "^[0-9]{3}"))

results <- ddply(all_the_data, ~ Subject + TrialNo, CalculatorealLatency)

qplot(data = results, x = Latency) + scale_x_continuous(breaks = (0:5 * 500)) + facet_grid(Group ~ .)

results$Group <- ifelse(results$Group == "CS1", -.5, .5)

library(lme4)
m <- lmer(Latency ~ Group + (1 |Subject), data = results)
summary(m)

Anova(m, type = 3, test = "F")

