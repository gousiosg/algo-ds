#!/usr/bin/env Rscript

library(bookdown)

args = commandArgs(trailingOnly=TRUE)

if (length(args) > 0 && args[1] == "pdf") {
  bookdown::render_book("book.Rmd", "bookdown::pdf_book")
} else {
  bookdown::render_book("book.Rmd", "bookdown::gitbook")
}
