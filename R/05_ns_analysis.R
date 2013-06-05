





load("data/results.RData")
results <- TrimTooFast(results, cutoff = 250)



FindCutoffByGroup <- function(results, group = NULL) {
  ddply(results, group, mutate, Cutoff = ComputeUpperBound(Latency),
        Drop = ifelse(Latency > Cutoff, "Drop", "Keep"))
}

ApplyCutoff <- function(results) {
  results$Latency[results$Drop == "Drop"] <- NA
  results
}

TrimByGroup <- function(results, group) {
  r <- FindCutoffByGroup(results, group)
  ApplyCutoff(r)
}


r_subject <- TrimByGroup(results, "Subject")








r_target <- FindCutoffByGroup(results, "TargetWord")
qplot(data = r_target, x = Latency, fill = Drop)
r_target <- ApplyCutoff(r_target)


r_version <- FindCutoffByGroup(results, "Version")
qplot(data = r_version, x = Latency, fill = Drop)

r_subject <- FindCutoffByGroup(results, "Subject")
qplot(data = r_subject, x = Latency, fill = Drop)
r_subject <- ApplyCutoff(r_subject)

r_all <- FindCutoffByGroup(results)
r_all <- ApplyCutoff(r_all)


r3 <- ddply(results, "Subject", mutate, Average = Average(Latency), Cutoff = ComputeUpperBound(Latency), Drop = ifelse(Latency > Cutoff, "Drop", "Keep"))

qplot(data = r3, x = Latency, fill = Drop) + facet_wrap(~Subject,)



r2 <- ddply(results, "Version", mutate, Average = Average(Latency), Cutoff = ComputeUpperBound(Latency))
r2$Drop <- with(r2, ifelse(Latency > Cutoff, "Drop", "Keep"))
qplot(data = r2, x = Latency, fill = Drop) + facet_wrap(~Version, ncol = 1)



qplot(data = r, x = Latency, fill = Drop)

qplot(data = r, x = Latency) + facet_wrap(~TargetWord, ncol = 2) + geom_vline(aes(xintercept = Cutoff), color = "red")


ddply(results, "Subject", summarize, Average = Average(Latency), 
      Cutoff = ComputeUpperBound(Latency), Count(which(Latency > Cutoff)), Count(Latency))











rw <- subset(results, Condition == "real")
ns <- subset(results, Condition == "nonsense")

v1 <- subset(results, Version == "CS1")
v2 <- subset(results, Version == "CS2")

t.test(rw$Latency, ns$Latency)
t.test(v1$Latency, v2$Latency)

PrintDescriptives(rw)
PrintDescriptives(ns)


ddply(results, ~ Condition + Version, summarize, Latency = mean(Latency, na.rm = TRUE))
ddply(results, ~ Condition + Version, summarize, 
      Real_Latency = length(which(!is.na(Latency))),
      NA_Latency = length(which(is.na(Latency))),
      Percent = NA_Latency / (NA_Latency + Real_Latency))

ComputeUpperBound <- function(x) mean(x, na.rm = T) + (2 * sd(x, na.rm = T))
DropAboveUpperBound <- function(df) {
  cutoff <- ComputeUpperBound(df$Latency)
  df$Latency[df$Latency > cutoff] <- NA
  df
}

# Pooling both experiments together
ComputeUpperBound(results$Latency)
# Separating the two experiments
by(results$Latency, results$Version, ComputeUpperBound)

cs1 <- subset(results, Version == "CS1")
cs1 <- DropAboveUpperBound(cs1)
cs2 <- subset(results, Version == "CS2")
cs2 <- DropAboveUpperBound(cs2)
results <- rbind(cs1, cs2)

qplot(data = results, x = Latency) + facet_grid(~ Version)
PrintDescriptives(results)

means <- aggregate(Latency ~ Subject + Version + Condition, data = results, Average)






names(results)
plotter <- ddply(r_subject, Subject ~ Condition + Version, summarize, EVT = unique(EVT), Latency = Average(Latency))
plotter <- ddply(results, Subject ~ Condition + Version, summarize, EVT = unique(EVT), Latency = Average(Latency))


qplot(data = r_subject, x = EVT, y = Latency, color = Condition) + geom_smooth(method = "lm") + facet_grid(~Version)

qplot(data = plotter, x = EVT, y = Latency, color = Condition) + geom_smooth(method = "lm") + facet_grid(~Version)

r_all <- TrimByGroup(results, NULL)
aggregate <- ddply(r_all, "Subject", summarize, EVT = unique(EVT), Latency = Average(Latency))
condition_aggregate <- ddply(r_all, Subject ~ Condition, summarize, EVT = unique(EVT), Latency = Average(Latency))
version_aggregate <- ddply(r_all, Subject ~ Version, summarize, EVT = unique(EVT), Latency = Average(Latency))

qplot(data = aggregate, x = EVT, y = Latency) + geom_smooth(method = "lm")
qplot(data = condition_aggregate, x = EVT, y = Latency, color = Condition) + geom_smooth(method = "lm")
qplot(data = version_aggregate, x = EVT, y = Latency, color = Version) + geom_smooth(method = "lm")



lmer(Latency ~ EVT + (1|Subject), r_subject)
lmer(Latency ~ EVT + Age + (1|Subject), r_subject)
lmer(Latency ~ EVT + Age + Condition * Version + (1|Subject), r_subject)

lmer(Latency ~ PPVT + (1|Subject), r_subject)
lmer(Latency ~ PPVT + EVT + Age + (1|Subject), r_subject)















qplot(data = r_subject, x = EVT, y = Latency) + geom_smooth(method = "lm")
Anova(m, test.statistic="F", type = 3)
m <- lm(Latency ~ Version , means)
summary(m)


  
  ddply(results, Subject ~ Condition + Version, summarize, Latency = Count(Latency))
  

results$Condition <- factor(results$Condition) 
aggregate()



qplot(data = results, x = EVT, y = Latency, color = Condition) + geom_smooth(method = "lm") + facet_grid(~ Version)

?geom_point