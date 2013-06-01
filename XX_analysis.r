source('01_functions.r', chdir = TRUE)




# Set onset window parameters
onset_window <- DefineOnsetWindow(starting_time = 0, window_duration = 50)












# Locate and load participant data.
InitializeLocations("L:/DataAnalysis/Mispronunciation/", "CrossSectional2_UW", "027C44MS1")
figs_dir <- data_dir

subjects1 <- list.files(sprintf('%s/%s/', task_dir, gaze_dir), pattern = "^[0-9]{3}[CLP]")
folders1 <- paste0(gaze_dir, "/", subjects)

subjects2 <- list.files(sprintf('%s/%s/', task_dir, "Archive_CrossSectional2_Pilot"), pattern = "^[0-9]{3}[CLP]")

folders2 <- paste0("Archive_CrossSectional2_Pilot", "/", subjects2)

folders <- c(folders1, folders2)



# Get a dataframe of all the real trials
sessions <- lapply(folders, LoadAndReduceData)
trials <- Reduce(c, sessions)
real_trials <- trials[which(trials %@% "StimType" == "real")]
trial_frame <- ldply(real_trials, MakeLongTrial)

# Make subjects a factor
trial_frame$Subject <- str_extract(trial_frame$Subject, "^[0-9]{3}")
trial_frame$Subject <- factor(trial_frame$Subject)

CalculateRealLatency <- MakeLatencyCalculator(onset_window, "Target")

results <- ddply(trial_frame, ~ Subject + TrialNo, CalculateRealLatency)



















qplot(data = results, x = Latency) + scale_x_continuous(breaks = (0:5 * 500)) + 
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

