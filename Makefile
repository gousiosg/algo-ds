##
# Copyright 2017 - onwards Georgios Gousios <gousiosg@gmail.com>
#
##

R=Rscript -e

.PHONY: all html pdf before

CONTENT_DIRS := assignments lectures
REQ_FILES := ieee.csl _output.yaml bibliography.bib theme.css utils.R footer.Rmd header.Rmd
JUPYTER_SRC := assignments

DEPS:=$(foreach dir,$(CONTENT_DIRS), $(foreach file, $(REQ_FILES), $(dir)/$(file)))
INPUTS = $(shell find . -type f -name '*.Rmd' | egrep -v "header|footer")
JUPYTER_INPUTS = $(shell find $(JUPYTER_SRC) -type f -name '*.ipynb'|grep -v "ipynb_checkpoints")
OUTPUTS_HTML = $(INPUTS:.Rmd=.html) $(JUPYTER_INPUTS:.ipynb=.html)
OUTPUTS_PDF = $(INPUTS:.Rmd=.pdf) $(JUPYTER_INPUTS:.ipynb=.pdf)
OUTPUTS_SLIDES = $(INPUTS:.Rmd=.reveal.html)

%.pdf: %.ipynb
	cd $(shell dirname $<) && \
	jupyter nbconvert --to pdf $(shell basename $<)

%.html: %.ipynb
	cd $(shell dirname $<) && \
	jupyter nbconvert --to html --output=$(shell basename $@) $(shell basename $<)

%.html: %.Rmd  $(DEPS)
	$(R) "library(rmarkdown); render('$<', output_file=gsub(pattern = '.Rmd', '.html', basename('$<')), output_format = html_document())"

%.pdf: %.Rmd $(DEPS)
	$(eval TMP := $(shell mktemp))
	grep -v "\. \. \." < $< > $(TMP)
	$(eval NEWTMP := $(shell dirname $<)/$(shell basename $(TMP)).Rmd)
	mv $(TMP) $(NEWTMP)
	$R "library(rmarkdown); render('$(NEWTMP)', output_file= gsub(pattern = '.Rmd', '.pdf', basename('$<')),  output_format = pdf_document())"
	rm $(NEWTMP)

%.reveal.html: %.Rmd  $(DEPS)
	$R "library(rmarkdown); render('$<', output_file=gsub(pattern = '.Rmd', '.reveal.html', basename('$<')), output_format = revealjs::revealjs_presentation())"

%/_output.yaml : _output.yaml
	cp _output.yaml $@

%/ieee.csl: ieee.csl
	cp ieee.csl $@

%/bibliography.bib: bibliography.bib
	cp bibliography.bib $@

%/theme.css: theme.css
	cp theme.css $@

%/utils.R: utils.R
	cp utils.R $@

%/header.Rmd: header.Rmd
	cp header.Rmd $@

%/footer.Rmd: footer.Rmd
	cp footer.Rmd $@

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
