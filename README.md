LatencyPoster
=============

The repository contains R and RMarkdown scripts for my SRCLD 2013 poster.

## Workflow for generating reports

1. Use the scripts in `R` to (re-)generate data-sets. Save these into `data`.
2. Work in the `.Rmd` files in the `report` directory to edit a report's R code and body text. Use the reference handles in the `refs.bib` for inline and parenthetical citations.
3. Run `generate_report.r` to knit the code and text in the `.Rmd` file together into a Markdown file. This intermediate `.md` file is converted by Pandoc into other file types.

### Notes

* The `.csl` file in `report/backend` determines the citation formatting rules. In this case, we're using APA formatting.
* The `_config.txt` files control the options that are fed into pandoc. 

### Links

* [Using Pandoc from `knitr`](http://yihui.name/knitr/demo/pandoc/)
* [Pandoc commands](http://johnmacfarlane.net/pandoc/README.html)
