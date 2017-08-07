##
# Copyright 2017 - onwards Georgios Gousios <gousiosg@gmail.com>
#
##

R=Rscript -e

.PHONY: all html pdf before

CONTENT_DIRS := assignments lectures
REQ_FILES := ieee.csl _output.yaml bibliography.bib theme.css

DEPS:=$(foreach dir,$(CONTENT_DIRS), $(foreach file,$(REQ_FILES), $(dir)/$(file)))
INPUTS = $(shell find . -type f -name '*.Rmd')
OUTPUTS_HTML = $(INPUTS:.Rmd=.nb.html)
OUTPUTS_PDF = $(INPUTS:.Rmd=.pdf)
OUTPUTS_SLIDES = $(INPUTS:.Rmd=.reveal.html)

%.nb.html: %.Rmd
	$R "library(rmarkdown); render('$<', output_file=gsub(pattern = '.Rmd', '.nb.html', basename('$<')), output_format = html_document())"

%.pdf: %.Rmd
	$R "library(rmarkdown); render('$<', output_format = pdf_document())"

%.reveal.html: %.Rmd
	$R "library(rmarkdown); render('$<', output_file=gsub(pattern = '.Rmd', '.reveal.html', basename('$<')), output_format = revealjs::revealjs_presentation())"

%/_output.yaml : _output.yaml
	cp _output.yaml $@

%/ieee.csl: ieee.csl
	cp ieee.csl $@

%/bibliography.bib: bibliography.bib
	cp bibliography.bib $@

%/theme.css: theme.css
	cp theme.css $@

all: html slides pdf

html: $(DEPS) $(INPUTS) $(OUTPUTS_HTML)
pdf: $(DEPS) $(INPUTS) $(OUTPUTS_PDF)
slides: $(DEPS) $(INPUTS) $(OUTPUTS_SLIDES)

clean:
	- rm *~
	- rm $(OUTPUTS_PDF)
	- rm $(OUTPUTS_HTML)
	- rm $(OUTPUTS_SLIDES)
	- rm $(DEPS)
