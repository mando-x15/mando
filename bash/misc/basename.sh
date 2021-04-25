#!/bin/bash

# `basename NAME [SUFFIX]`

# will print NAME (removing any leading directory components).  Will also remove any SUFFIX supplied, such ash .jpg

j=/home/sp.jpg

echo $j

p=`basename $j .jpg`

echo $p


