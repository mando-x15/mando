#!/bin/bash

CDMAIN=$PWD


for n in Bi*; do

echo $n
cd $n

Bi=${n#"Bi_"}


#remove files
rm -f *.jpg *.plt 
rm -f energy.txt h_profile.txt OUT phi_lambda.txt ts_adpt.txt content.txt


#	# prepare tmp file, change m1 m2 m3 X1 X2 X3 && 
	sed -e 's/5.0 5.0 1.0  1.0  0.5   0.5/93 77 1  0.342  0.718   0.774/' -e 's/0.000004/0.00000325/g' < inputdata.data > tmp.data

rm -f inputdata.data

mv tmp.data inputdata.data

cd $CDMAIN

done
