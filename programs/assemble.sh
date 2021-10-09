#!/bin/bash
filename="${1%.*}"
customasm ${filename}.asm -f binary -o ${filename}.bin && 
customasm ${filename}.asm -f annotatedbin -o ${filename}.annotated.txt
python split_binary.py ${filename}.bin
