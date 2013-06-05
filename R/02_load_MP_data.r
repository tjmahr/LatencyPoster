# Note: Only the final, renumbered data-set is version-controlled. 




#### Load and reduce the real word trials from both versions ------------------
source('R/01_functions.r', chdir = TRUE)

# Load only matched subjects
matching_path <- "data/Latency_AgeMatch.xlsx"
matching_info <- read.xlsx(matching_path, sheetName = "Long")
selected <- as.character(matching_info$Subjects)

task_dir <- "L:/DataAnalysis/Mispronunciation/"
setwd(task_dir)

# Cross-sectional 1 
paths <- ListFoldersInGazeDir("CrossSectional1_UW", select = selected)
cs1 <- LoadAllMPData(paths)
cs1$Group <- "CS1"

# Cross-sectional 2 
pilot_paths <- ListFoldersInGazeDir("Archive_CrossSectional2_Pilot", selected)
new_paths <- ListFoldersInGazeDir("CrossSectional2_UW", selected)
cs2a <- LoadAllMPData(pilot_paths)
cs2b <- LoadAllMPData(new_paths)
cs2a$Group <- "CS2a"
cs2b$Group <- "CS2b"
cs2 <- rbind(cs2a, cs2b)




#### Combine, tweak and save --------------------------------------------------

all_the_data <- rbind(cs1, cs2)

names(all_the_data)[which(names(all_the_data) == "XMean.Target")] <- "XMeanTarget"
all_the_data$XMeanTarget <- round(all_the_data$XMeanTarget, 3)

# Code categorical variables as factors
all_the_data <- within(all_the_data, {
  Subject <- factor(str_extract(Subject, "^[0-9]{3}"))
  Gender <- factor(Gender)
  Group <- factor(Group)
  WordGroup <- factor(WordGroup)
  Dialect <- factor(Dialect)
  Condition <- factor(Condition)
  TargetWord <- factor(TargetWord)
})

setwd("L:/WorkingFolders/TMahr/GitRepos/LatencyPoster/")
write.csv(all_the_data, file = "data/mp_trials.csv", row.names = FALSE)
save(all_the_data, file = "data/mp_trials.RData") 

# Grab the real and nonsense trials. Save them.
trials <- subset(all_the_data, Condition == "real" | Condition == "nonsense")

write.csv(trials, file = "data/trials.csv", row.names = FALSE)
save(trials, file = "data/trials.RData") 




#### Merge the participant info with Trial data -------------------------------

info_path <- "L:/Participant Info/ParticipantCrossSectionalDataSummary.xls"
subject_info <- read.xlsx(info_path, sheetName = "Participant Summary")

# We want age, vocab scores, and whether they were excluded
selected_columns <- c("ParticipantID", "age_1", "EVT_raw", "PPVT_raw", "keeper")
subject_info <- subject_info[selected_columns]
names(subject_info) <- c("Subject", "Age", "EVT", "PPVT", "Keeper")
subject_info$Subject <- factor(str_extract(subject_info$Subject, "^[0-9]{3}"))
rw_ns_data <- merge(trials, subject_info, by = "Subject")

# Renumber participant IDs
rw_ns_data$Subject <- factor(as.numeric(rw_ns_data$Subject))

write.csv(rw_ns_data, file = "data/rw_ns_data.csv", row.names = FALSE)
save(rw_ns_data, file = "data/rw_ns_data.RData")
