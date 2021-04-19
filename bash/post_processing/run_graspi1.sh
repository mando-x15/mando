#!/bin/bash
# RUN_GRASPI - Run script for GRASPI
#
# Description: Loops over ke & lp files and calls all_process.sh
#
# Note:
#       This script loops over ke* and then loops over lp_*
#
##
# Written By: Balaji Pokuri & Spencer Pfeifer
# Date: 10/25/17
#
##############################################################

# Set paths
SRC=/media/spfeife/ext4/LOCAL/graspi
GRASPI=$SRC/all_process.sh
BLUE='\033[0;34m'
CYAN='\033[0;36m'

# Clean up any previous files
clean_up () {
rm -rf results
 for k in dataCH*; do

	 if [ -d $k ]; then
	   rm -rf $k
   fi
 done
}

# Run graspi
run_graspi () {
 for k in *.plt; do
 	echo "$(tput bold) $k $(tput sgr0)"; 
 	bash $GRASPI $k; 
 done	
}



# MAIN LOOP
main () {

  # Loop over ke
  for i in ke-0*; do

		# print to screen
		echo ' '
    echo -e "${CYAN}$(tput bold)$i $(tput sgr0)"
    cd $i

      # Loop over lp_ 
      for j in lp_*; do  

				# print to screen
				echo ' '
   		  echo -e "${BLUE}$(tput bold) $j $(tput sgr0)\n"
    		cd $j
        
        # clean
        clean_up
        
        # run 
	   		run_graspi

        cd ..
      done
      
    cd ..
  done  
}

time main "$@"


