#!/bin/bash

TITLE="Matthew Burke"
AUTHOR="Matthew Burke"

OUT_FILE="./cv.tex"

#Add preamble

cat preamble-cv.tex > cv.tex

# Convert markdown to tex
pandoc -f markdown -t latex \
contact-details.markdown \
education-cv.markdown \
talks-and-presentations.markdown \
teaching.markdown >> cv.tex

#Add end document
echo "\end{document}" >> cv.tex

#Change the tables to be fixed width
##First for the contact details table which needs to be wider
sed -i.bak "s:begin{longtable}\[c\]{@{}lll@{}}:begin{longtable}{p{7cm}ll}:" cv.tex
##Nextfor the other tables whic all need to line up with each other
sed -i.bak "s:begin{longtable}\[c\]{@{}ll@{}}:begin{longtable}{p{2cm}p{12cm}}:" cv.tex

#Compile latex
pdflatex cv.tex

#Remove aux files
rm cv.aux cv.out cv.log


