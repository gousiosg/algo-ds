is_slides_output = function() {
  knitr::opts_knit$get("rmarkdown.pandoc.to") =="revealjs"
}

is_html_output = function() {
  knitr::opts_knit$get("rmarkdown.pandoc.to") =="html"
}

is_latex_output = function() {
  knitr::opts_knit$get("rmarkdown.pandoc.to") =="latex"
}
