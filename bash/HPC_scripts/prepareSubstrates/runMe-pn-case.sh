#!/bin/bash
#COMMAND="/home/spfeife/PROJECTS/MESC/CHeq/binary_system_substrate_2.0.1/tools/prepareSubstrates/genPattern"
COMMAND="/lustre/spfeife/Substrate/genPattern"

Nx=216
Ny=216
pNy=1
pNx=25

ARGs="$Nx $Ny $pNx $pNy"
$COMMAND $ARGs
NAME=pn$pNx
mv SubstratePattern.dat ${NAME}SubstratePattern.dat

echo $NAME
mkdir ${NAME}
cd ${NAME}
	mv ../${NAME}SubstratePattern.dat ./SubstratePattern.dat
cp SubstratePattern.dat ..
cd ..




