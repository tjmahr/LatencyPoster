
library(knitr)
setwd("report")

knit(input="report.Rmd", output="report-mid.md")

# Output formatted files
pandoc_config <- 'backend/pandoc_config.txt'
pandoc('report-mid.md', config=pandoc_config, format='html5')
pandoc('report-mid.md', config=pandoc_config, format='docx')
pandoc('report-mid.md', config=pandoc_config, format='markdown_github')

knit(input="exploring.Rmd", output="exploring-mid.md")
explore_config <- "backend/pandoc_config-explore.txt"
pandoc('exploring-mid.md', config=explore_config, format = "html5")
pandoc('exploring-mid.md', config=explore_config, format = "markdown_github")



