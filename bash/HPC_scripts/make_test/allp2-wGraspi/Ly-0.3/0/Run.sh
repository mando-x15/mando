#!/bin/bash
 CDDIR="$(dirname "$PWD")"

echo "Running Graspi..." >> $CDDIR/OUT.log
echo "" >> $CDDIR/OUT.log

# make sure files are cleaned first
if [ -e data/AllEta.dat ]; then
		./clean_up.sh
fi 


rm -f src_data/dataCH_bndrCreated.plt
rm -f src_data/dataCH_init.plt


cd tools

echo "Finding time..." >> $CDDIR/OUT.log
echo "" >> $CDDIR/OUT.log
./findTime.sh

echo "Converting data..." >> $CDDIR/OUT.log
echo "" >> $CDDIR/OUT.log
./convert_data.sh

./make_tex.sh
















		




