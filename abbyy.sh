#!/bin/bash

source="/Users/Z/Desktop/temp"
dest="/Users/Z/Desktop/abby_ocr"
final="/Users/Z/Desktop/abby_ocr_text"
ext=".txt"

cd $source
for file in *.pdf
	do
		fraw=$(basename "$file")
		fname="${fraw%.*}"
		echo "${file}"
		mv "${file}" "$dest"
		counter=0
		until [ -e "$final/$fname$ext" ]
			do
				if [ $counter -eq 20 ]
					then
						exit 1
					else
						sleep 30s
						counter=$((counter+1))
				fi
			done
		#rm "$dest/$file"
		#echo "$fname"
		#echo "$file"
		#echo "$final/$fname$ext"
	done
	sleep 10s
echo "done"
