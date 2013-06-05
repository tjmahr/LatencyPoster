source('R/01_functions.r', chdir = TRUE)
load("data/clean.RData")

# Compute latencies
onset_window <- DefineOnsetWindow(starting_time = 0, window_duration = 50)
CalculateRealLatency <- MakeLatencyCalculator(onset_window, "Target")
results <- ddply(clean, ~ Subject + TrialNo, CalculateRealLatency)

# Combine two versions of Cross-sectional2 into same grouping factor
results$Version <- factor(ifelse(results$Group == "CS1", "CS1", "CS2"))

save(results, file="data/results.Rdata")







setwd("L:/WorkingFolders/TMahr/GitRepos/LatencyPoster/")






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
m <- lmer(Latency ~ Version + EVT + Age + Trial + (Trial |Subject) + (1 | WordGroup), data = results)
summary(m)

ascii(summary(m))
asciiMixed
Anova(m, type = 3, test = "F")





qqPlot(model, labels = FALSE, sim = TRUE, main = "Quantile-Comparison Plot to Assess Normality", 
       xlab = "t Quantiles", ylab = "Studentized Residuals")
plot(density(rstudent(model)), main = "Density Plot to Assess Normality of Residuals", 
     xlab = "Studentized Residual")
zx <- seq(-4, 4, length.out = 100)
lines(zx, dnorm(zx, mean = 0, sd = sd(rstudent(model))), 
      lty = 2, col = "blue")
cat("Descriptive Statistics for Studentized Residuals\n")
describe(rstudent(model))

plot(rstudent(model) ~ fitted.values(model), main = "Studentized Residuals vs. Fitted Values",  xlab = "Fitted Values", ylab = "Studentized Residuals")
abline(h = 0, lty = 2, col = "blue")
print(spreadLevelPlot(model))

crPlots(model)





# 
# 
# 
# 
# 
# 
# *** 
#   
#   ## Scratch area for testing things out
#   
#   **Ciations**
#   
#   * @BaayenRTs recommend blah blah blah.
# * We try the inverse-normal distribution [@BaayenRTs],
# 
# **Tables?**
#   
#   Use the `ascii` package to make a captioned Pandoc table:
#   
#   ```{r, results ='asis', warning=FALSE}
# library(ascii)
# data(esoph)
# print(ascii(esoph[1:10,]), type = "pandoc")
# ```
# Table: This is a table caption.
# 
# ## References
# 
