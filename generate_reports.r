library(knitr)
library(ascii)
library(ggplot2)

setwd("report")

# Knit the reports
knit(input="report.Rmd", output="report-mid.md")
knit(input="exploring.Rmd", output="exploring-mid.md")

# Set the pandoc configurations
report_config <- 'backend/pandoc_config.txt'
explore_config <- "backend/pandoc_config-explore.txt"

# Output formatted files
pandoc('report-mid.md', config=report_config, format='html5')
pandoc('report-mid.md', config=report_config, format='docx')
pandoc('report-mid.md', config=report_config, format='markdown_github')

pandoc('exploring-mid.md', config=explore_config, format = "html5")
pandoc('exploring-mid.md', config=explore_config, format = "markdown_github")
