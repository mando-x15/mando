#!/bin/bash

# Run and time program, direct output of time into tmr.tmp
(time ( $@ 2>&1 )) 2>tmr.tmp

# Process tmr.tmp and print human-friendly result
t=`tail -n 3 tmr.tmp | head -n 1 | tr ms ' '`
echo $t | awk '{printf "Time: %.3f s\n", $2*60+$3}'

# Clean up
rm -f tmr.tmp

