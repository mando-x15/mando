#!/bin/bash
COMMAND="/home/spfeife/PACKAGES/CahnHilliardEq/v1.1Beta/CODE/binary_CH"

#non-linear solver
ARGS="-snes_atol 1e-10"
mpirun -np 2 $COMMAND $ARGS >>OUT.LOG 2>&1


