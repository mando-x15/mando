#!/bin/bash
#SBATCH -A TG-CTS110007 		# Specify charge
#SBATCH -J graspi      			# Job Name
#SBATCH -o $JOB_NAME.o$JOB_ID	
#SBATCH -p development			# Queue
#SBATCH -n 9				# proc
#SBATCH -t 2:00:00			# Time

ibrun /work/02143/spfeife/GraSPI-1.3.1/testing/cluster/cluster 

