load("data/mp_real_trials.RData")

#### Grab the participant info and merge with Trial data ----------------------

info_path <- "L:/Participant Info/ParticipantCrossSectionalDataSummary.xls"
subject_info <- read.xlsx(info_path, sheetName = "Participant Summary")

# We want age, vocab scores, and whether they were excluded
selected_columns <- c("ParticipantID", "age_1", "EVT_raw", "PPVT_raw", "keeper")
subject_info <- subject_info[selected_columns]
names(subject_info) <- c("Subject", "Age", "EVT", "PPVT", "Keeper")
subject_info$Subject <- factor(str_extract(subject_info$Subject, "^[0-9]{3}"))

rw_data <- merge(real_trials, subject_info, by = "Subject")

# Renumber participant IDs
rw_data$Subject <- factor(as.numeric(real_data$Subject))

write.csv(rw_data, file = "data/rw_data.csv", row.names = FALSE)
save(rw_data, file = "data/rw_data.RData")

