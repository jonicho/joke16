#!/bin/bash
filename="${1%.*}"
customasm $1 -f binary -o ${filename}.bin && 
customasm $1 -f annotatedbin -o ${filename}.annotated.txt
python split_binary.py ${filename}.bin
