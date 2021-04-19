#!/bin/bash

#Check if the script is used correctly
if [ -z "$1" ]; then 
    echo "Usage: maketests typeOfMachine"
    exit
fi

MachineType=$1
if [ "$MachineType" != "cystorm" ]; then
	if [ "$MachineType" != "linux" ]; then
	echo "Usage: maketests typeOfMachine"
	echo "You are trying to run this script for the following type of machine:" $MachineType
	echo "Whereas this script works only for the following typesOfMachine: cystorm or linux."		
	exit	
	fi
fi

##############################################################################
############# You need to set appropriatly this data #########################

#set the path to program you want to execute
if [ "$MachineType" == "linux" ]; then 
	PATHtoCOMMAND=$HOME/MINE/PROJECTS/MESC/Morphology/CHeq/CODE/binary_system_substrate_2.0.1/binary_CH
fi
if [ "$MachineType" == "cystorm" ]; then 
	PATHtoCOMMAND=/home/owodo/MINE/programs/binary_system_substrate_2.0.2-test/binary_CH
fi	

#and argument you want to run this program with 
ARGS="-ksp_type preonly -pc_type lu -pc_factor_mat_solver_package mumps -snes_atol 1e-10"
#ARGS="-snes_atol 1e-12"


#The content of table Parameters is for your information 
#and to determine the number of parameters (utilized later in the for-loop at the end!!! )
Parameters=( "testname" "NofCystormNodes" "Walltime" "L" "NofEl" "time" "epsilon2" "phi" )
NofPar=${#Parameters[@]}

#Change NofTests if you add new tests!!!!! 
NofTests=4
#The most important table !!!!!!
tests=(	"pn6-1"  4 "24:00:00" 1.0 60 100.0 0.000509 0.5 \
	"pn6-2"  4 "24:00:00" 1.0 60 100.0 0.000509 0.5 \
	"pn6-3"  4 "24:00:00" 1.0 60 100.0 0.000509 0.5 \
	"pn6-4"  4 "24:00:00" 1.0 60 100.0 0.000509 0.5 )
	
#############################################################################
########## This part allows to generate in "automagical-way" scripts ;-) ####
###### If you analyze it, you will realize that there is no magic here :-) ##

#create inputdata.txt file and print input data to it
#this is a file that contains all data that you want/need
#to parametrize and read in your code
#you are responible for correct reading of this file in your code!
function make_inputdataFile {
# Lx Ly Lz
echo "10 $1 0.0" > inputdata.data
# lelemx lelemy lelemz
echo "3000 $2 0" >> inputdata.data
# mean1 var
echo "$5 0.05" >> inputdata.data
# D epsilon if_D_const if_per
echo "1.0 $4 0 2 " >> inputdata.data
# dexp duration
echo "1e-5 $3" >> inputdata.data
# m1 m2 chi12
echo "1.0 1.0 3.0" >> inputdata.data
#tol
echo "1e-3" >> inputdata.data 
# order_o_bf nsd
echo "1 2" >> inputdata.data 
# type_of_free_energy type_of_IC
echo "11 2" >> inputdata.data 
# time_scheme type_of_adaptivity
echo "2 1" >> inputdata.data 
# type_of_substrate
echo "1" >>  inputdata.data 
#h1 g
echo "0.01 0.0" >>  inputdata.data 
}


#prepare command line to executions on linux box
function make_linuxBoxScript {
echo "#!/bin/bash" > $1.sh
echo "COMMAND=\"$PATHtoCOMMAND\"" >> $1.sh
echo "ARGs=\"$ARGS\"" >> $1.sh 
# the end of this line is responsible for redirecting standard output of your executable to file (of the name: OUT)
echo "mpirun -np $2 \$COMMAND \$ARGs >> OUT 2>&1" >> $1.sh
}

#prepare pbs script for cystorm
function make_pbsScript {
TP1="(("
TP2="))"
echo "#!/bin/bash" > $1.sh
echo "# Set name for your job" >> $1.sh
echo "#PBS -N $1" >> $1.sh
echo "" >> $1.sh
echo "# Inherit local variables (important)" >> $1.sh
echo "#PBS -V" >> $1.sh
echo "#PBS -q pnormal" >> $1.sh
echo "" >> $1.sh
echo "# Set max execution time (important) hh:hm:ss">> $1.sh
echo "#PBS -l nodes=$2,walltime=$3" >> $1.sh
echo "" >> $1.sh
echo "cd \$PBS_O_WORKDIR" >> $1.sh
echo "" >> $1.sh
echo "COMMAND=\"$PATHtoCOMMAND\"" >> $1.sh
echo "ARGS=\"$ARGS\"" >> $1.sh 
echo "" >> $1.sh
echo "NCORES=8"  >> $1.sh
echo "NODES=\`cat \$PBS_NODEFILE | wc -l\`" >> $1.sh
echo "NPROC=$""$TP1 \$NCORES * \$NODES $TP2" >> $1.sh
echo "" >> $1.sh
echo "RANKFILE=\$HOME/\$PBS_JOBID.ranks" >> $1.sh
echo "rank=0" >> $1.sh
echo "for i in \`cat \$PBS_NODEFILE\`; do" >> $1.sh
echo "    for j in \`seq 0 $""$TP1 \$NCORES - 1 $TP2\`; do" >> $1.sh
echo "	echo \"rank \$rank=\$i slot=\$j\" >> \$RANKFILE" >> $1.sh
echo "	rank=$""$TP1 \$rank + 1 $TP2" >> $1.sh
echo "    done" >> $1.sh
echo "done" >> $1.sh
echo "" >> $1.sh
echo "mpirun -np \$NPROC -rf \$RANKFILE --mca btl self,sm,openib \$COMMAND \$ARGS" >> $1.sh
}


#############################################################################
##### THIS IS THE MAIN HEART OF THIS SCRIPT #################################
#### It prepares all folders, copies appropriate files and most importantly # 
#### submits all jobs to cystorm or your linux box!!!! ######################

for((i=0;i<($NofTests);i++)); do
     testNumber=$(($i*$NofPar))
     testname=${tests[$testNumber]}
     echo $testname

     rm -r $testname
     mkdir $testname
     cd $testname
     #prepare inputdat.txt file which is later read by your program
     make_inputdataFile ${tests[$(($testNumber+3))]} ${tests[$(($testNumber+4))]} ${tests[$(($testNumber+5))]} ${tests[$(($testNumber+6))]} ${tests[$(($testNumber+7))]};

     #If you need to copy some input data file with meshes etc you can do it here
     cp ../TStowrite.data .
     cp ../SubstratePattern.dat .

     if [ "$MachineType" == "linux" ]; then 
     	#prepare bashscript of a name ($1) to execute program with given number of cores($2) 
     	make_linuxBoxScript $testname ${tests[$(($testNumber+1))]}
	chmod +x $testname.sh
	#run tests (consider making this tests with screen software if tests are time consuming)
     	./$testname.sh
     fi

    if [ "$MachineType" == "cystorm" ]; then 
     	#prepare bashscript of a name ($1) to submit job to cystrom with given number of nodes($2) with set Walltime($3) 
     	make_pbsScript $testname ${tests[$(($testNumber+1))]} ${tests[$(($testNumber+2))]} ;
	#submit job to cystorm
    	qsub $testname.sh
     fi	
    cd ..

done



