#!/bin/bash


# Mac OS X: pandoc required homebrew and `brew install pandoc`
## http://pandoc.org/MANUAL.html
## --toc only outputs it in the html if you specify -s or --standalone (standalone)
## standard --toc-depth=3
pandoc --standalone --toc --toc-depth=5 Levels.rst -o Levels.html
pandoc --standalone --toc --toc-depth=5 Solutions.rst -o Solutions.html

# Mac OS X: rst2html.py required homebrew and `brew install docutils`
