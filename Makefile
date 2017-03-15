##
# Copyright 2017 - onwards Georgios Gousios <gousiosg@gmail.com>
#
##

R=Rscript -e

.PHONY: all html pdf

INPUTS = $(wildcard *.Rmd)
OUTPUTS_HTML = $(INPUTS:.Rmd=.html)
OUTPUTS_PDF = $(INPUTS:.Rmd=.pdf)
OUTPUTS_SLIDES = $(INPUTS:.Rmd=.reveal.html)

%.html: %.Rmd
	$R "library(rmarkdown); render('$<', output_format = html_document())"

%.pdf: %.Rmd
	$R "library(rmarkdown); render('$<', output_format = pdf_document())"

%.reveal.html: %.Rmd
	$R "library(rmarkdown); render('$<', output_format = revealjs::revealjs_presentation())"

all: html

html: $(INPUTS) $(OUTPUTS_HTML)
pdf: $(INPUTS) $(OUTPUTS_PDF)
slides: $(INPUTS) $(OUTPUTS_SLIDES)

clean:
	- rm *~
	- rm $(OUTPUTS_PDF)
	- rm $(OUTPUTS_HTML)
