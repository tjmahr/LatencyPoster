source('R/01_functions.r', chdir = TRUE)
load("data/results.RData")






DisplayPercentNA(results)
PrintDescriptives(results)





qplot(data = results, x = Latency, fill = Condition) + facet_grid(Version~Condition)

results <- FindCutoffByGroup(results, "Subject")
qplot(data = results, x = Latency, fill = Drop) + facet_wrap(TargetWord~., ncol = 4)
Com
DisplayPercentNA(results)
PrintDescriptives(results)

# Trim impossibly fast latencies. Trim slow latencies within each subject.
results <- TrimTooFast(results, cutoff = 250)
results <- TrimByGroup(results, group = ~ Version + Condition)

mean_sd <- function(x) {
  avg <- round(Average(x))
  SD <- round(sd(x, na.rm = TRUE))
  paste0(avg, " (", SD, ")")
}















rw <- subset(subject_means, Condition == "real")

m <- lmer(Latency ~ PPVT + Age + Condition * Version + (Condition|Subject), results)
Anova(m, type = 3, test = "F")


cs1_full <- subset(results, Version == "CS1")
cs2_full <- subset(results, Version == "CS2")

m <- lmer(Latency ~ EVT + Age + Condition + (Condition|Subject), cs1_full)
Anova(m, type = 3, test = "F")


m <- lmer(Latency ~ EVT + Age + Condition + (Condition|Subject), cs2_full)
Anova(m, type = 3, test = "F")



subject_means <- aggregate(Latency ~ Subject + Age + PPVT + EVT + Version + Condition, 
                           data = results, Average)

cs1 <- subset(subject_means, Version == "CS1")
cs2 <- subset(subject_means, Version == "CS2")

### put table in poster
m_x1 <- lm(Latency ~ EVT + Age + Condition, cs1)
summary(m_x1)

### put table in poster
m_x2 <- lm(Latency ~ EVT + Age + Condition, cs2)
summary(m_x2)


rw1 <- subset(subject_means, Condition == "real" & Version == "CS1")
rw2 <- subset(subject_means, Condition == "real" & Version == "CS2")
ns1 <- subset(subject_means, Condition == "nonsense" & Version == "CS1")
ns2 <- subset(subject_means, Condition == "nonsense" & Version == "CS2")

m_r1 <- lm(Latency ~ PPVT + EVT + Age, rw1)
summary(m_r1)

m_r2 <- lm(Latency ~ PPVT + EVT + Age, rw2)
summary(m_r2)

m_n1 <- lm(Latency ~ PPVT + EVT + Age, ns1)
summary(m_n1)

m_n2 <- lm(Latency ~ PPVT + EVT + Age, ns2)
summary(m_n2)

m_n2 <- lm(Latency ~ PPVT + EVT + Age, cs2)
summary(m_n2)












x <- results$Latency

Average(results$Latency) + 2 * sd(results$Latency, na.rm = TRUE)




results <- DropAboveUpperBound(results)


FindCutoffByGroup(results, "Subject")



describeBy(results$Latency, group = c(results$Version, results$Condition))




qplot(data = subject_means, x = PPVT, y = Latency, color = Condition) + facet_grid(~Version) + geom_smooth(method = "lm")

rw1 <- subset(subject_means, Condition == "real" & Version == "CS1")
rw2 <- subset(subject_means, Condition == "real" & Version == "CS2")
ns1 <- subset(subject_means, Condition == "nonsense" & Version == "CS1")
ns2 <- subset(subject_means, Condition == "nonsense" & Version == "CS2")

cs1 <- subset(subject_means, Version == "CS1")
cs2 <- subset(subject_means, Version == "CS2")





m <- lmer(Latency ~ EVT + Age + (1|Subject), r_subject)
m

# Look at CI's for each subject
ms <- lmList(Latency ~ Condition | Subject, r_subject)
plot(confint(ms))

# Look at the effect of trial
qplot(data = r_subject, x = Trial, y = Latency, color = Version) + geom_smooth(method = "lm")
qplot(data = r_subject, x = Trial, y = Latency, color = Version) + 
  geom_smooth(method = "lm") + facet_wrap(~Subject, ncol = 4)



aggregate(Latency ~ Version + Condition, data = r_subject, Average)


# Adjust latency for age
subject_means <- aggregate(Latency ~ Subject + EVT + Age + PPVT + Version, 
                           data = r_subject, Average)
subject_means$AgeC <- subject_means$Age - mean(subject_means$Age)

m <- lm(Latency ~ Age + EVT, subject_means)
summary(m)

m <- lm(Latency ~ AgeC + EVT, subject_means)
summary(m)

adjustment <- subject_means$AgeC * m$coefficients["AgeC"]
subject_means$AdjLatency <- subject_means$Latency - adjustment

qplot(data = subject_means, x = EVT, y = Latency) + geom_smooth(method = "lm")
qplot(data = subject_means, x = EVT, y = AdjLatency) + geom_smooth(method = "lm")


qplot(data = subject_means, x = Age, y = Latency) + geom_smooth(method = "lm")













# Try the Feasible GLS
model1 <- lm(Latency ~ Version + EVT + Age, subject_means)
summary(model1)

eps <- residuals(model1)
eps2 <- eps^2
subject_means$leps2 <- log(eps2)

model2 <- lm(leps2 ~  Version + EVT + Age, subject_means)
summary(model2)

leps2hat <- fitted(model2)
eps2hat <- exp(leps2hat)
sqrtvar <- sqrt(eps2hat)
 
transdata <- subject_means[c("Version", "EVT", "Age", "Latency")]
names(transdata) <- paste0("Trans", names(transdata))

transdata$TransVersion <- as.integer(transdata$TransVersion) - 1.5
transdata <- transdata / sqrtvar

model3 <- lm(TransLatency ~ TransVersion + TransEVT + TransAge, transdata)
summary(model3)



r_subject <- TrimByGroup(results, "Subject")

