#!/bin/bash
CDMAIN=$PWD
#for f in ke-0.1.png; do	
	#FILENAME=$f
	#echo $FILENAME
	
	# imagemagik command
	#convert -resize 570x570+260+120 $FILENAME c$FILENAME
	#convert example.png -resize x100 example.png
	
	# use 'identify' package from imagemagik, to return the dimensions of the image
	# note: the "$( )" syntax stores the entire output into a variable
	#OUTPUT="$(identify -format '%w %h' ke-10.png)"
	
	# call variable output using "${ }" syntax
	# looks like: <width> <height> = 1600 158
	#echo "${OUTPUT}"
	
	# now split output at the space using the cut command.
	# Syntax: -f1: return first field. -f2: return 2nd field
	# Syntax: -d ' ': delimiter - in this case a space ' '
	#var1=$(echo $OUTPUT | cut -f1 -d ' ' )
	#var2=$(echo $OUTPUT | cut -f2 -d ' ' )
	
	#echo $var1
	#echo $var2
	
	# now, use the double parenthesis "$(( ))" syntax to convert variables to numbers and divide width by 2.
	#var3="$((var1/2))"
	
	#convert -crop $var3'x'$var1'+0 $FILENAME c$FILENAME
	# takes cut out of center, use 'west' for left side cut
	convert k0.png -gravity center -crop 50%x100% scaled.png
	
	#convert out.png -resize '250' scaled.png
#done

 




