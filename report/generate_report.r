
library(knitr)
setwd("report")

knit(input="report.Rmd", output="report-mid.md")

# Output formatted files
pandoc_config <- 'backend/pandoc_config.txt'
pandoc('report-mid.md', config=pandoc_config, format='html5')
pandoc('report-mid.md', config=pandoc_config, format='docx')
pandoc('report-mid.md', config=pandoc_config, format='markdown_github')