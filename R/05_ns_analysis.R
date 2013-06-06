




source('R/01_functions.r', chdir = TRUE)

load("data/results.RData")
results <- TrimTooFast(results, cutoff = 250)








model1 <- lm(Latency ~ Version + EVT + Age, subject_means)
eps<-residuals(model1)
eps2<-eps^2
leps2<-log(eps2)
model2<-lm(leps2~subject_means$Version+subject_means$EVT+subject_means$Age)
leps2hat<-fitted(model2)
eps2hat<-exp(leps2hat)
sqrtvar<-sqrt(eps2hat)
# 
# vartransdata<-cbind(subject_means$Version,subject_means$EVT,subject_means$Age,subject_means$Latency)
# names(vartransdata)<-c("transversion","transevt",transage","translatency")
# ##This should work. If you get a message about mismatched dimensions or unequal numbers of rows or columns, use the commented code below, which will definitely work.
# vartransdata<-vartransdata/sqrtvar
# ##vartransdata$transversion<-vartransdata$transversion/sqrtvar
# 
# ##vartransdata$transevt<-vartransdata$transevt/sqrtvar
# 
# ##vartransdata$transage<-vartransdata$transage/sqrtvar
# 
# ##vartransdata$translatency<-vartransdata$translatency/sqrtvar
# 
# model3<-lm(translatency~transversion+transevt+transage,data=vartransdata)
# 
# summary(model3)
# 
# 






TrimByGroup <- function(results, group) {
  r <- FindCutoffByGroup(results, group)
  ApplyCutoff(r)
}

FindCutoffByGroup <- function(results, group = NULL) {
  ddply(results, group, mutate, Cutoff = ComputeUpperBound(Latency),
        Drop = ifelse(Latency > Cutoff, "Drop", "Keep"))
}

ApplyCutoff <- function(results) {
  results$Latency[results$Drop == "Drop"] <- NA
  results
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


qplot(data = plotter, x = EVT, y = Latency, color = Condition) + geom_smooth(method = "lm") + facet_grid(~Version) + labs(title = "Aggregated times, trimmed within subject") + theme_bw()

qplot(data = plotter, x = EVT, y = Latency, color = Condition) + geom_smooth(method = "lm") + facet_grid(~Version)

r_all <- TrimByGroup(results, NULL)
aggregate <- ddply(r_all, "Subject", summarize, EVT = unique(EVT), Latency = Average(Latency))
condition_aggregate <- ddply(r_all, Subject ~ Condition, summarize, EVT = unique(EVT), Latency = Average(Latency))
version_aggregate <- ddply(r_all, Subject ~ Version, summarize, EVT = unique(EVT), Latency = Average(Latency))

qplot(data = aggregate, x = EVT, y = Latency) + geom_smooth(method = "lm")
qplot(data = condition_aggregate, x = EVT, y = Latency, color = Condition) + geom_smooth(method = "lm")
qplot(data = version_aggregate, x = EVT, y = Latency, color = Version) + geom_smooth(method = "lm")



lmer(Latency ~ EVT + (1|Subject), r_subject)
lmer(Latency ~ EVT + Age + Condition + (1|Subject), r_subject)
lmer(Latency ~ EVT + Age + Condition * Version + (1|Subject), r_subject)

lmer(Latency ~ PPVT + (1|Subject), r_subject)
lmer(Latency ~ PPVT + EVT + Age + (1|Subject), r_subject)

cs1_means <- subset(means, Version == "CS1")
cs2_means <- subset(means, Version == "CS2")


means <- aggregate(Latency ~ Subject + Version, data = r_subject, Average)
v_splits <- dlply(means, "Version", summarize, Latency = Latency)
t.test(v_splits$CS1, v_splits$CS2) 
summary(lm(Latency ~ Version, means))

means <- aggregate(Latency ~ Subject + Condition, data = r_subject, Average)
c_splits <- dlply(means, "Condition", summarize, Latency = Latency)
t.test(c_splits[[1]], c_splits[[2]]) 
summary(lm(Latency ~ Condition, means))


plotter <- ddply(r_subject, Subject ~ Condition + Version, summarize, EVT = unique(EVT), Latency = Average(Latency))

means <- aggregate(Latency ~ Subject + EVT + Age, data = r_subject, Average)

m <- lm(Latency ~ EVT + Age, means)
summary(m)






qplot(data = r_subject, x = EVT, y = Latency) + geom_smooth(method = "lm")
Anova(m, test.statistic="F", type = 3)
m <- lm(Latency ~ Version , means)
summary(m)


  
  ddply(results, Subject ~ Condition + Version, summarize, Latency = Count(Latency))
  

results$Condition <- factor(results$Condition) 
aggregate()



qplot(data = results, x = EVT, y = Latency, color = Condition) + geom_smooth(method = "lm") + facet_grid(~ Version)

?geom_point