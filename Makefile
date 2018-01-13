##
# Copyright 2017 - onwards Georgios Gousios <gousiosg@gmail.com>
#
##

R=Rscript -e

.PHONY: all html pdf book

EXAM_DIRS := exams
CONTENT_DIRS := assignments lectures
REQ_FILES := ieee.csl bibliography.bib theme.css footer.Rmd header.Rmd
JUPYTER_SRC := assignments

EXAM_INPUTS := $(shell find exams -type f -name '*.Rmd')

DEPS := $(foreach dir,$(CONTENT_DIRS) $(EXAM_DIRS), $(foreach file, $(REQ_FILES), $(dir)/$(file)))

EXAM_INPUTS = $(shell find $(EXAM_DIRS) -type f -name '*.Rmd' | egrep -v "header|footer")
INPUTS = $(shell find $(CONTENT_DIRS) -type f -name '*.Rmd' | egrep -v "header|footer") index.Rmd
JUPYTER_INPUTS = $(shell find $(JUPYTER_SRC) -type f -name '*.ipynb'|grep -v "ipynb_checkpoints")

OUTPUTS_HTML = $(INPUTS:.Rmd=.html) $(JUPYTER_INPUTS:.ipynb=.html)
OUTPUTS_PDF = $(INPUTS:.Rmd=.pdf) $(JUPYTER_INPUTS:.ipynb=.pdf)
OUTPUTS_SLIDES = $(INPUTS:.Rmd=.reveal.html)
OUTPUTS_EXAMS = $(EXAM_INPUTS:.Rmd=.pdf)

%.pdf: %.ipynb
	cd $(shell dirname $<) && \
	jupyter nbconvert --to pdf $(shell basename $<)

%.html: %.ipynb
	cd $(shell dirname $<) && \
	jupyter nbconvert --to html --output=$(shell basename $@) $(shell basename $<)

%.html: %.Rmd  $(DEPS)
	$(R) "library(rmarkdown); render('$<', output_file=gsub(pattern = '.Rmd', '.html', basename('$<')), output_format = 'html_document')"

%.pdf: %.Rmd $(DEPS)
	$(eval TMP := $(shell mktemp))
	grep -v "\. \. \." < $< > $(TMP)
	$(eval NEWTMP := $(shell dirname $<)/$(shell basename $(TMP)).Rmd)
	mv $(TMP) $(NEWTMP)
	$R "library(rmarkdown); render('$(NEWTMP)', output_file= gsub(pattern = '.Rmd', '.pdf', basename('$<')),  output_format = 'pdf_document')"
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

all: html slides pdf book

html: $(DEPS) $(INPUTS) $(OUTPUTS_HTML)
pdf: $(DEPS) $(INPUTS) $(OUTPUTS_PDF)
slides: $(DEPS) $(INPUTS) $(OUTPUTS_SLIDES)
exams: $(DEPS) $(EXAM_INPUTS) $(OUTPUTS_EXAMS)

BOOK_SRC := $(shell find lectures -type f -name '*.Rmd' | egrep -v "header|footer")
BOOK_DEST := $(foreach file, $(BOOK_SRC), book/$(shell basename $(file)))
BOOK_DEPS := book/ieee.csl book/bibliography.bib
BOOK_OUTPUT := book/_book book/images

book/%.Rmd: lectures/%.Rmd
	bin/slides2book $< > $@

book: book/book.Rmd $(BOOK_SRC) $(BOOK_DEST) $(BOOK_DEPS)
	cd book && Rscript book.R

book/book.pdf: book/book.Rmd $(BOOK_SRC) $(BOOK_DEST) $(BOOK_DEPS)
	cd book && Rscript book.R pdf

clean:
	- rm *~
	- rm $(OUTPUTS_PDF)
	- rm $(OUTPUTS_HTML)
	- rm $(OUTPUTS_SLIDES)
	- rm $(DEPS)
	- rm $(BOOK_DEST) $(BOOK_DEPS)
	- rm -R $(BOOK_OUTPUT)
