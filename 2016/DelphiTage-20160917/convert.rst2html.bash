#!/bin/bash

## http://pandoc.org/MANUAL.html
## --toc only outputs it in the html if you specify -s or --standalone (standalone)
## standard --toc-depth=3
pandoc --standalone --toc --toc-depth=5 Network-Protocol-Security.rst -o Network-Protocol-Security.html
open Network-Protocol-Security.html
