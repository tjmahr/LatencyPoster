# Note: Only the final, renumbered data-set is version-controlled. 




#### Load and reduce the real word trials from both versions ------------------
source('R/01_functions.r', chdir = TRUE)

# Load only matched subjects
matching_path <- "data/Latency_AgeMatch.csv"
matching_info <- read.csv(matching_path)
selected <- as.character(matching_info$Part)

task_dir <- "L:/DataAnalysis/Mispronunciation/"
setwd(task_dir)

# Cross-sectional 1 
paths <- ListFoldersInGazeDir("CrossSectional1_UW", select = selected)
cs1 <- LoadAllMPData(paths)
cs1$Group <- "CS1"

# Cross-sectional 2 
pilot_paths <- ListFoldersInGazeDir("Archive_CrossSectional2_Pilot", selected)
new_paths <- ListFoldersInGazeDir("CrossSectional2_UW", selected)

# Remove pilot that were tested again after piloting
doubles <- intersect(str_extract(pilot_paths, "[0-9]{3}C"), 
                     str_extract(new_paths, "[0-9]{3}C"))
is_double <- function(x) str_extract(x, "[0-9]{3}C") %in% doubles
pilot_paths <- Filter(Negate(is_double), pilot_paths)

cs2a <- LoadAllMPData(pilot_paths)
cs2b <- LoadAllMPData(new_paths)
cs2a$Group <- "CS2a"
cs2b$Group <- "CS2b"
cs2 <- rbind(cs2a, cs2b)




#### Combine, tweak and save --------------------------------------------------

all_the_data <- rbind(cs1, cs2)

names(all_the_data)[which(names(all_the_data) == "XMeanToTarget")] <- "XMeanTarget"
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
mp_trials <- subset(all_the_data, Condition == "MP")

write.csv(trials, file = "data/trials.csv", row.names = FALSE)
save(trials, file = "data/trials.RData") 




#### Merge the participant info with Trial data -------------------------------

info_path <- "L:/participantinfo/ParticipantCrossSectionalDataSummary.xls"
subject_info <- read.xlsx(info_path, sheetName = "Participant Summary")

# We want age, vocab scores, and whether they were excluded
selected_columns <- c("ParticipantID", "age_1", "EVT_raw",  "EVT_standard", 
                      "PPVT_raw", "PPVT_standard", "keeper")
subject_info <- subject_info[selected_columns]
names(subject_info) <- c("Subject", "Age", "EVT", "EVT_Standard", "PPVT", 
                         "PPVT_Standard", "Keeper")
subject_info$Subject <- factor(str_extract(subject_info$Subject, "^[0-9]{3}"))




#### Get the scores for the BRIEF ---------------------------------------------

brief_path <- "L:/participantinfo/ParentQuestionnaireDataBase/BriefPCrossSectional.xlsx"

# Values to take from the BRIEF sheet
brief_base <- c(Inhibit = "Inhibit", Shift = "Shift", WorkingMemory = "WorkingMemory",
                EmotionalControl = "EmotionalControl", PlanOrganize = "PlanOrganize")
brief_suffix <- c(TScore = "_T", Percentile = "_percentile")

brief <- paste0(brief_base, 5 %copies_of% brief_suffix)
names(brief) <- paste0(names(brief_base), 5 %copies_of% names(brief_suffix))
brief <- brief[order(names(brief))]
brief <- c(Subject = "Participant_ID", brief)

brief_scores <- read.xlsx(file = brief_path, sheetIndex = 1)
brief_scores <- SelectRename(brief_scores, brief)
brief_scores$Subject <- factor(str_extract(brief_scores$Subject, "^[0-9]{3}"))

subject_info <- merge(subject_info, brief_scores, by = "Subject")




#### Finalize output ----------------------------------------------------------
rw_ns_data <- merge(trials, subject_info, by = "Subject")
mp_data <- merge(mp_trials, subject_info, by = "Subject")

# Renumber participant IDs
rw_ns_data$Subject <- factor(as.numeric(rw_ns_data$Subject))
mp_data$Subject <- factor(as.numeric(mp_data$Subject))



write.csv(rw_ns_data, file = "data/rw_ns_data.csv", row.names = FALSE)
save(rw_ns_data, file = "data/rw_ns_data.RData")
save(mp_data, file = "data/mp_data.RData")
