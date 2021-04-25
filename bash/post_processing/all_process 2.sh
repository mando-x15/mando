#!/bin/bash
# ALL_PROCESS - Main GRASPI post processing script.
#
# Description: This function runs GraSPI on a single .PLT file
#
# Input:
#          ARG1 = <input plt file>
#
# Usage:
#         `bash all_process <dataCH...plt>`
#
#
##
# Written By: 
# Date: 10/25/17
#
##############################################################

#set -o errexit
#set -o errtrace
#set -o nounset
#set -o xtrace
export LC_ALL=C

## --------------------- USER INPUT ----------------------  ##

# SET PATHS
SRC=/media/
RESULTS_DIR=$PWD/RESULTS
CONFIG=$PWD/config.txt
CDHOME=$PWD


# SET EXECUTABLES
UNIFORM_MESH_EXEC=$SRC/interpolation/generate_to_mesh/make_mesh
INTERP_EXEC=$SRC/interpolation/interp/interp
PLT_TO_ARR=$SRC/tools/plt2arr/src/plt2arr3p
GRASPI_EXEC=$SRC/src/graspi


# SET FINAL HEIGHT
ht=0.0879

# set location of uniform mesh (IF POSSIBLE! Otherwise comment this out)
UNIMESH=/media/..plt


### SET MESH PARAMETERS ### 
n_x=801
n_y=51

l_x=2
elem_per_length=750
n_nodes=$((n_x*n_y))


## ---------------------    END    ----------------------  ##


# Set global variables
readonly PLT_FILE=$1
readonly FNAME=`echo ${PLT_FILE} | sed 's/\.plt//'`

curr_folder=${PWD}

## --------------------- FUNCTIONS ----------------------  ##

# MESH GENERATION (if necessary)
generate_uniform_mesh () {
  local ht_local=`echo "${ht} - 0.000001" | bc -l`

	# if mesh file is provided or not
  # if zero length // does not exist
  if [[ -z $UNIMESH ]]; then

    # generate uniform mesh: `mesh_uniform.plt` 
    #   Usage: make_mesh <Lx> <Ly> <elem_per_length>
    ${UNIFORM_MESH_EXEC} ${l_x} ${ht_local} ${elem_per_length}
  fi
}

# INTERPOLATION
interpolate_mesh () {
  ${INTERP_EXEC} ${PLT_FILE} $UNIMESH phi1 phi2 -o temp.plt -s $ht
}

# CONVERT TO ARRAY
#  	output: `temp.arr` 
#  	 usage: plt2arrTh <in_filename.plt> <out_filename.txt> 
#   		  : 1 if phi1>phi2 else 0
convert_to_array () {
  ${PLT_TO_ARR} temp.plt temp.arr
}



# RUN GRASPI
# 	- perform graspi analysis: 
run_graspi () {

  # pixel size is adjusted such that the thickness is 200nm
  PIXSIZE=`echo "200. /${elem_per_length} / ${ht}" | bc -l`

	# USAGE: graspi -a <file.txt> (row-major order) -s <pixelSize> (default 1) -p <{0,1}> (default 0-false) -n <{2,3}> (default 2-{D,A}, 3-{D,A,D+A}) -r path where store results (default ./) 
  ${GRASPI_EXEC} -a temp.arr -s ${PIXSIZE} -p 0 -n 2 -r ./graspi_results/ > ./graspi_results/graspi-gathered-results.log
}


# COLLECT RESULTS
collect_results () {

  # absorption
  STR="\[F ABS\] Fraction of black vertices: "
  FRAC_DONOR=`grep -e "$STR" ./graspi_results/graspi-gathered-results.log | sed -e "s/$STR//" `

  # dissociation
  STR="\[F DISS\] Weighted fraction of black vertices in 10 distance to interface: "
  FdissWLdonor=`grep -e "$STR" ./graspi_results/graspi-gathered-results.log | sed "s/$STR//" `

  # charge transport
  # 1. straight rising paths
  STR="\[F CT\] Fraction of black vertices with straight rising paths (t=1): "
  FoutTORTBLACK=`grep -e "$STR" ./graspi_results/graspi-gathered-results.log | sed -e "s/$STR//" `
  STR="\[F CT\] Fraction of white vertices with straight rising paths (t=1): "
  FoutTORTWHITE=`grep -e "$STR" ./graspi_results/graspi-gathered-results.log | sed -e "s/$STR//" `

  # 2. non island vertices
  STR="\[F CT\] Fraction of useful vertices - w\/o islands: "
  ETACTUG=`grep "${STR}" ./graspi_results/graspi-gathered-results.log | sed "s/$STR//" `

  # 3. interface with complementary paths
  STR="\[F CT\] Fraction of interface with complementary paths to bottom and top: "
  ETACTCG=`grep "${STR}" ./graspi_results/graspi-gathered-results.log | sed "s/$STR//" `

}

# PRINT RESULTS
print_results () {

  echo ${FRAC_DONOR} >> $RESULTS_DIR/abs.txt
  echo ${FdissWLdonor} >> $RESULTS_DIR/diss.txt
  echo "${FoutTORTBLACK}  ${FoutTORTWHITE}" >> $RESULTS_DIR/st_paths.txt
  echo ${ETACTCG} >> $RESULTS_DIR/interface_comp_paths.txt

	lp=`echo | grep "subPatterningLambda" ${CONFIG} | cut -d' ' -f3`
	ke=`echo | grep "ke" ${CONFIG} | cut -d' ' -f3`
  curr_ht=`echo ${PLT_FILE} | grep -Po dataCH2_.*\.plt | sed 's/dataCH2_//' | sed 's/\.plt//'`

  ## make curr_ht to be a float instead of final
  if [ "$curr_ht" == "final" ]; then
    curr_ht=0.08
  fi

  echo "${lp}  ${ke}  ${curr_ht}  ${PLT_FILE}" >> $RESULTS_DIR/all_jobs.txt


  #### cost function values: ##########
  CF1=`echo "${FRAC_DONOR} * ${FdissWLdonor} * ${ETACTCG}" | bc -l`

  # eta_ct=$([  $FoutTORTBLACK -le $FoutTORTWHITE ] && echo "$FoutTORTBLACK" || echo "$FoutTORTWHITE" )

  num1=$FoutTORTBLACK
  num2=$FoutTORTWHITE

  eta_ct=$num1
  if (( $(echo "$num1 > $num2" | bc -l ) )); then
	  eta_ct=$num2
  fi

  # eta_ct=`echo $((${FoutTORTBLACK}>${FoutTORTWHITE}?${FoutTORTBLACK}:${FoutTORTWHITE}))`
  CF2=`echo "${FRAC_DONOR} * ${FdissWLdonor} * ${eta_ct}" | bc -l`

	# Rounding
	CF1=`printf "%.5f\n" $CF1`
	CF2=`printf "%.5f\n" $CF2`

	# PRINT TO ALL_CF
  echo "$lp  $ke  $curr_ht  $CF1  $CF2" >> $RESULTS_DIR/all_cf.txt
}


# SET FILE STRUCTURE
set_file_structure () {

	mkdir -p $RESULTS_DIR
  mkdir -p ${FNAME}
  cp ${PLT_FILE} ${FNAME}/
  mkdir -p $FNAME/graspi_results
}


# CLEAN UP
cleanup () {
  rm -rf mesh_uniform.plt
  rm -f ${PLT_FILE}
  rm -f temp.arr
  rm -f temp.plt
}


## --------------------- MAIN ----------------------  ##

main () {

	set_file_structure

  cd ${FNAME}
  generate_uniform_mesh
  interpolate_mesh
  convert_to_array
  run_graspi
  collect_results
  print_results
  
  cleanup
 
  cd ${CDHOME}
}


main "$@"



