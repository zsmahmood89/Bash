#!/bin/bash

#Argument defaults
ARG1=${1:-7}
ARG2=${2:-5}

#Initialize 
source="/Users/Z/Desktop/temp"
dest="/Users/Z/Desktop/abby_ocr"
final="/Users/Z/Desktop/abby_ocr_text"
ext=".txt"
iterations=0

#CODE
killtime=$((ARG1 * 4))
maxiterations=$((ARG2))
pdfcount=`ls -1 *.pdf 2>/dev/null | wc -l` #count of pdf files in input dir
cd $source

while [ $pdfcount != 0 ]
	do
		iterations=$((iterations+1))
		echo "Iteration $iterations"
		for file in *.pdf
			do
				fraw=$(basename "$file")
				fname="${fraw%.*}"
				scp "${file}" "$dest"
				counter=0
				err=0
				until [ -e "$final/$fname$ext" ]
					do
						if [ $counter -eq $killtime ]
							then
								err=1
								break
							else
								sleep 15s
								counter=$((counter+1))
						fi
					done
				if [ $err == 0 ]
					then
						echo "${file}"
						rm "$dest/${file}"
					else
						echo "Ret ${file}"
				fi
				sleep 3s
			done

		pdfcount=`ls -1 *.pdf 2>/dev/null | wc -l`
		if [ $iterations -eq $maxit ]
			then
				echo "WARNING: Max iterations reached, remaining PDFs were not completed"
				exit 1
		fi
	done
	
echo "All your PDFs are belong to us"
echo "Complete"
