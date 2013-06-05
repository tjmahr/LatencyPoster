library(xlsx)
library(ascii)
library(stringr)

library(reshape2)
library(plyr)
library(lubridate)
library(ggplot2)

library(lme4)
library(psych)
library(lmSupport)
library(retimes)


#### Functions for handling LWL data ------------------------------------------

source('L:/scripts/LookingWhileListeningBeta.r', chdir = TRUE)

LoadAllMPData <- function(subject_paths) {
  sessions <- lapply(subject_paths, LoadAndReduceData)
  trials <- Reduce(c, sessions)
  trial_frame <- ldply(trials, MakeLongTrial)
  
  # Make subjects a factor
  trial_frame$Gender <- str_extract(trial_frame$Subject, "^[MF]")
  trial_frame$Subject <- str_extract(trial_frame$Subject, "^[0-9]{3}")
  trial_frame$Subject <- factor(trial_frame$Subject)
  trial_frame
}

# Convert a Trial object and its attributes into a long dataframe.
MakeLongTrial <- function(trial, columns = c("GazeByImageAOI", "XMean.Target")) {
  trial$Subject <- trial %@% "Subject"
  trial$Dialect <- trial %@% "Dialect"
  trial$Condition <- trial %@% "StimType"
  trial$TrialNo <- trial %@% "TrialNo"
  trial$Block <- trial %@% "Block"
  trial$DateTime <- trial %@% "DateTime"
  trial$WordGroup <- trial %@% "WordGroup"
  trial$TargetWord <- trial %@% "Target"

  id_vars <- c("Subject", "Dialect", "Block", "TrialNo", "Time", "Condition", 
               "WordGroup", "TargetWord", "DateTime", columns)
  trial_frame <- melt(trial, id.vars = id_vars, measure.vars = NULL)
  trial_frame
}

ListFoldersInGazeDir <- function(gaze_dir, select) {
  subjects <- list.files(gaze_dir, pattern = "^[0-9]{3}[CLP]")
  short_names <- str_extract(subjects, pattern = "^[0-9]{3}[CLP]")
  subjects <- subjects[short_names %in% selected]
  paste0(gaze_dir, "/", subjects)
}




#### Functions for computing latencies  ---------------------------------------

# Higher-order function that can set the onset_window and target_name parameters
# for the CalculateLatency function. Useful for making a separate functions to
# handle looks to target and look to distractor.
MakeLatencyCalculator <- function(window, target) {
  function(trial) {
    CalculateLatency(trial, onset_window = window, target_name = target)
  }
}

CalculateLatency <- function(trial, onset_window, target_name) {
  onset_time <- CheckLatencyOnset(trial, onset_window, target_name)
  first_look <- FindFirstLook(trial, onset_window, target_name)
  
  # The response latency is the time between the onset and the first look to
  # target. A latency calculation therefore requires a valid onset and a valid
  # first look to target.
  if(is.na(onset_time) | is.na(first_look)) {
    latency <- NA
  } else {
    latency <- first_look - onset_time
  }
  
  # Extract non-redundant info about trial and combine with latency info
  info <- unique(subset(trial, select = -c(Time, XMeanTarget, GazeByImageAOI)))
  cbind(info, Latency = latency, Onset = onset_time, FirstLook = first_look)
}

CheckLatencyOnset <- function(trial, onset_window, target_name) {
  # An invalid onset contains a look to the target or contains all NA values. 
  window <- GetLooksWithinWindow(trial, onset_window)
  if(window$GazeByImageAOI %contains% target_name) {
    onset_time <- NA
  } else if(IsAllNA(window$GazeByImageAOI)) {
    onset_time <- NA
  } else {
    valid_looks <- subset(window, !is.na(GazeByImageAOI))
    onset_time <- valid_looks[1, "Time"]
  }
  onset_time  
}

FindFirstLook <- function(trial, onset_window, target_name) {
  # If there are no looks to target, there can be no first look to target.
  window <- GetLooksAfterWindow(trial, onset_window)
  if(window$GazeByImageAOI %lacks% target_name) {
    first_look <- NA
  } else {
    valid_looks <- subset(window, GazeByImageAOI == target_name)
    first_look <- valid_looks[1, "Time"]
  }
  first_look  
}




#### Helper functions ---------------------------------------------------------

DefineOnsetWindow <- function(starting_time, window_duration) {
  structure(list(Start = starting_time, Duration = window_duration), 
            class = c("OnsetWindow", "list"))
}

GetLooksWithinWindow <- function(trial, window) {
  start <- window$Start
  end <- window$Start + window$Duration
  subset(trial, start <= Time & Time <= end)
}

GetLooksAfterWindow <- function(trial, window) {
  start <- window$Start + window$Duration
  end <- max(trial$Time)
  subset(trial, start <= Time & Time <= end)
}

`%contains%` <- function(x, y) any(y %in% x)
`%lacks%` <- function(x, y) !any(y %in% x)
IsAllNA <- function(x) all(is.na(x))

Count <- function(x) length(x[!is.na(x)])
Average <- function(x) mean(x, na.rm = TRUE)


#### Analysis munging functions -----------------------------------------------

DetermineVisitNumber <- function(subject_frame) {
  times <- sort(unique(subject_frame$DateTime))
  visits <- data.frame(Visit = 1:length(times), DateTime = times)
  merge(subject_frame, visits, by = "DateTime")  
}


RenumberTrials <- function(subject_frame) {
  offset <- ifelse(unique(subject_frame$Group == "CS2a"), 36, 38)
  trials <- subject_frame$TrialNo
  numbers <- ifelse(offset < trials, -offset, 0)
  subject_frame$Trial <- trials + numbers
  subject_frame
}

