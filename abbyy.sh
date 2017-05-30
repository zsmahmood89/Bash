#!/bin/bash

#Initialize 
rawsource="/Users/Z/Desktop/tempsource"
tododir="/Users/Z/Desktop/temp"
rundir="/Users/Z/Desktop/abby_ocr"
textdir="/Users/Z/Desktop/abby_ocr_text"
errdir="/Users/Z/Desktop/temperrs"
ext=".txt"

#If you really want to change default values
DefMinutesPerPDF=7
DefMaxIterations=5


#Argument defaults
ARG1=${1:-$DefMinutesPerPDF}
ARG2=${2:-$DefMaxIterations}


#CODE

#Compile pdfs from rawsource and copy them in tododir
cd $rawsource
echo "Copying ALL sourcefiles to input for OCR attempts"
find *.pdf | xargs -I % cp % $tododir

#Go to input directory. Everything from here on out starts from here.
cd $tododir
killtime=$((ARG1 * 4))
maxiterations=$((ARG2))
pdfcount=`ls -1 *.pdf 2>/dev/null | wc -l` #count of pdf files in input dir

#Start the loop.
iterations=0
while [ $pdfcount != 0 ]
	do
		iterations=$((iterations+1))
		echo "Iteration $iterations"
		for file in *.pdf
			do
				fraw=$(basename "$file")
				fname="${fraw%.*}"
				echo "copying ${file}"
				scp "${file}" "$rundir"
				counter=0
				err=0
				until [ -e "$textdir/$fname$ext" ]
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
						echo "completed ${file}"
						rm "${file}"
					else
						echo "Error with ${file}"
						rm "$rundir/${file}"
						killall "FineReader"
						sleep 20s
				fi
				sleep 3s
			done

		pdfcount=`ls -1 *.pdf 2>/dev/null | wc -l`
		if [ $iterations -eq $maxit ]
			then
				echo "WARNING: Max iterations reached, remaining PDFs were not completed"
				echo "..."
				echo "Copying non-OCRed PDFs to err directory."
				find *.pdf | xargs -I % cp % $errdir
				echo "..."
				echo "If you want to try these again, delete all from SOURCE and move PDFs in errdir to SOURCE"
				exit 1
		fi
	done
	
echo "All your PDFs are belong to us"
echo "Complete"
