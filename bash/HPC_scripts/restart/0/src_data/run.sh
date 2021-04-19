#!/bin/bash
#SBATCH -A TG-CTS110007        # specify charge
#SBATCH -J allp-0
#SBATCH -o allp-0
#SBATCH -p normal
#SBATCH -n 32 
#SBATCH -t 4:00:00

ARGs="-snes_rtol 1e-8 -ksp_rtol 1e-4"

ibrun /home1/02143/spfeife/PACKAGES/CahnHilliardEq/v1.1Beta2/CODE/binary_CH $ARGS
