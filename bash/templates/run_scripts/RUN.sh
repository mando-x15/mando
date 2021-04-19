#!/bin/bash

# paths
TOOLS=~/Desktop/PhaFiC/tools

# path to exe
COMMAND=~/Desktop/PhaFiC/ternary_CH

# petsc args
ARGS0="-snes_atol 1e-10"
ARGS1="-ksp_monitor_short -snes_monitor_short"
ARGS2="-snes_ksp_ew -snes_ksp_ew_rtol0 1e-3 -snes_ksp_ew_rtolmax 1e-4 -ksp_atol 1e-9 -snes_atol 1e-9"

# clean up before run
$TOOLS/scripts/CLEAN.sh

# run
mpirun -np 4 $COMMAND $ARGS2 | tee 'OUT.LOG' 2>&1

# make figs
#./make_figs.sh

# plot energy
#gnuplot plot_energy.sh > /dev/null 2>&1
