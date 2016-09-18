#!/bin/bash


# Mac OS X: pandoc required homebrew and `brew install pandoc`
## http://pandoc.org/MANUAL.html
## --toc only outputs it in the html if you specify -s or --standalone (standalone)
## standard --toc-depth=3
pandoc --standalone --toc --toc-depth=5 Network-Protocol-Security.rst -o Network-Protocol-Security.html

# Mac OS X: rst2html.py required homebrew and `brew install docutils`
rst2html.py 
open Network-Protocol-Security.html
