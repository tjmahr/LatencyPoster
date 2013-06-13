# This script generates the final version of the presentation's report.
library(knitr) 

setwd("report")

# Knit the reports
knit(input="report.Rmd", output="report-mid.md")

# Set the pandoc configurations
report_config <- 'backend/pandoc_config.txt'

# Output formatted files
pandoc('report-mid.md', config=report_config, format='html5')
pandoc('report-mid.md', config=report_config, format='docx')
pandoc('report-mid.md', config=report_config, format='markdown_github')


