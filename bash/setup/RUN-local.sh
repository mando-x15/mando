#!/bin/bash
COMMAND="/home/PACKAGES/CahnHilliardEq/v1.1Beta/CODE/binary_CH"


ARGS="-snes_ksp_ew -snes_ksp_ew_rtol0 1e3 -snes_ksp_ew_rtolmax 1e-4 -pc_type asm"
ARG5="-pc_type lu" # -pc_factor_mat_solver_package mumps"
ARG4="-snes_ksp_ew -snes_ksp_ew_rtol0 1e-3 -snes_ksp_ew_rtolmax 1e-4"
ARG3="-ksp_type gmres -ksp_rtol 1e-10 -pc_type asm -pc_asm_type basic"
ARG2="-ksp_monitor -ksp_converged_reason " #-ksp_monitor_true_residual  
ARG1="-snes_type tr -snes_trtol 1e-10 " # -snes_type test -snes_test_display
ARG0=""
ARGS6="-pc_factor_mat_solver_package mumps" 
ARG="-snes_monitor -snes_converged_reason " # -ksp_compute_eigenvalues_explicitly"


mpirun -np 4 $COMMAND $ARGS >>OUT.LOG 2>&1


