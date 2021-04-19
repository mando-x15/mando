#!/bin/bash

# paths
UTIL="/util"

# path to exe
COMMAND="/ternary_CH"

# petsc args
ARGS1="-ksp_type bcgs -snes_ksp_ew -snes_ksp_ew_rtol0 1e-3 -snes_ksp_ew_rtolmax 1e-4"
ARGS2="-pc_type asm -ksp_grmres_restart 50 -sub_ksp_type preonly -sub_pc_type lu -pc_asm_overlap 2"
ARGS3="-ksp_type preonly -pc_type lu -pc_factor_mat_solver_package mumps -snes_atol 1e-10 -pc_factor_levels 5"

# clean up before run
$UTIL/CLEAN.sh

# run
mpirun -np 8 $COMMAND $ARGS1 >> OUT.LOG 2>&1


