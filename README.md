LatencyPoster
=============

The repository contains R and RMarkdown scripts for my [SRCLD 2013](http://www.srcld.org/) poster.

The poster, as it was printed and presented, is available in [final_printed_poster.pptx](final_printed_poster.pptx?raw=true).

## Workflow for generating reports

I used R and other tools (knitr, markdown, pandoc) to generate the text, tables and figures used in the poster. I used the following workflow.

1. Use the scripts in `R` to (re-)generate data-sets. Save these into `data`.
2. Work in the `.Rmd` files in the `report` directory to edit a report's R code and body text. 
3. Gather BibTeX-format citations in `refs.bib` and use the reference handles therein for inline and parenthetical citations.
4. Run `generate_report.r` to knit the code and text in the `.Rmd` file together into a Markdown file. This intermediate `.md` file is converted by Pandoc into other file types.

### Notes

* The `.csl` file in `report/backend` determines the citation formatting rules. In this case, we're using APA formatting.
* The `_config.txt` files control the options that are fed into pandoc. 

### Links

* [Using Pandoc from `knitr`](http://yihui.name/knitr/demo/pandoc/)
* [Pandoc commands](http://johnmacfarlane.net/pandoc/README.html)
