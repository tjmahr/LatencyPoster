# Workflow for generating reports

1. Work in the `report.Rmd` file to edit the report's R code and body text. Use the reference handles in the `refs.bib` for inline and parenthetical citations.
2. Run `generate_report.r` to knit the code and text in the `.Rmd` file together into a Markdown file. This intermediate `.md` file is converted by Pandoc into `.docx` and `.html` files.

## Notes

* The `.csl` file in `backend` determines the citation formatting rules. In this case, we're using APA formatting.
* The `backend/pandoc_config.txt` file controls the options that are fed into the pandoc commands. 

## Links

* [Using Pandoc from `knitr`](http://yihui.name/knitr/demo/pandoc/)
* [Pandoc commands](http://johnmacfarlane.net/pandoc/README.html)

