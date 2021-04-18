#!/bin/bash

SOURCE=./PDF
DESTINATION=./PNG

all_target_images=( $(ls $SOURCE) )

for PDF in "${all_target_images[@]}"; do
	PDF_NAME="$SOURCE/$PDF"

	MAP_NAME=`basename $PDF .pdf`
	PNG_NAME="$DESTINATION/${MAP_NAME}.png"

	# ImageMagic
	#convert -density 300 -depth 8 -quality 85 PDF

	# SIPS
	sips -s format png $PDF_NAME --out $PNG_NAME
done
