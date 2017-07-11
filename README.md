# Bash

## abbyy.sh

This script lets you automate the use of ABBYY software on a folder of PDF documents. 

It makes use of Mac's "Automator" function, so you'll have to do that.

Basically, you need to set a folder up with Automator, so that every PDF file that goes into it is run through ABBYY and is spit out in some output folder (of your choosing).

This Bash script moves PDF files one at a time into the Automator folder, and it waits until the output file shows up in the output folder before it moves the next PDF file.

Need to update:

*rawsource* = folder from which Bash moves PDF files
*tododir* = folder where PDF files remain until they show up in output. 
*rundir* = folder with Mac Automator settings on it.
*textdir* = output folder for text files

#### *Usage*

1. Move PDFs to *rawsource*. Type "bash abbyy.sh" and let it run.

2. If it freezes or if it crashes, you need to do the following (in order)

	* DELETE all PDF files from *rawsource*
	* MOVE PDF files from *tododir* to *rawsource*
	* DELETE PDF fies from *rundir*
	* OPEN "FineReader" application. If asked to recover, select "cancel" or "no". If not, then simply close out of it.
	* re-type "bash abbyy.sh" into terminal. Repeat.
