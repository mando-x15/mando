#!/bin/bash

#Check if the script is used correctly
if [ -z "$1" ]; then 
    echo "Usage: maketests typeOfMachine"
    exit
fi

MachineType=$1
if [ "$MachineType" != "stampede" ]; then
	if [ "$MachineType" != "linux" ]; then
	echo "Usage: maketests typeOfMachine"
	echo "You are trying to run this script for the following type of machine:" $MachineType
	echo "Whereas this script works only for the following typesOfMachine: stampede or linux."		
	exit	
	fi
fi

##############################################################################
############# You need to set appropriatly this data #########################

#set the path to program you want to execute
if [ "$MachineType" == "linux" ]; then 
	PATHtoCOMMAND=/home/spfeife/PACKAGES/CahnHilliardEq/CODE/binary_CH
fi
if [ "$MachineType" == "stampede" ]; then 
	PATHtoCOMMAND=/home1/02143/spfeife/PACKAGES/CahnHilliardEq/v1.1Beta2/CODE/binary_CH
	
fi	


#ARGS="-ksp_type preonly -pc_type lu -pc_factor_mat_solver_package mumps -snes_atol 1e-10"
#ARGS="-snes_atol 1e-10"
ARGS="-snes_rtol 1e-8 -ksp_rtol 1e-4"

Parameters=( "testname" "NofNodes" "Walltime" "totalT" "h1" )
NofPar=${#Parameters[@]}

#Change NofTests if you add new tests!!!!! 
NofTests=2

tests=("0" 32 "3:00:00" 5 0.0001 \
	"1" 32 "3:00:00" 5 0.0001 )
	
#############################################################################
########## This part allows to generate in "automagical-way" scripts ;-) ####

#create inputdata.txt file and print input data to it
function make_inputdataFile {
echo "# [DESCR]:" > config.txt
echo "meanPhi = 0.5" >> config.txt
echo "varPhi = 0.05" >> config.txt
echo "D = 1" >> config.txt
echo "epsilon2 = 2.19e-05" >> config.txt
echo "ifDconst = 0" >> config.txt
echo "ifpBC = 2" >> config.txt
echo "dt = 1e-5" >> config.txt
echo "totalT = $1" >> config.txt
echo "timeScheme = 1" >> config.txt
echo "typeOfAdapt = 0" >> config.txt
echo "adptTol = 1e-2" >> config.txt
echo "typeOfFreeEnergy = 4" >> config.txt
echo "m1 = 1000" >> config.txt
echo "m2 = 1000" >> config.txt
echo "chi12 = 0.04" >> config.txt
echo "nsd = 2" >> config.txt
echo "ifBoxGrid = 1 " >> config.txt
echo "Lx = 7" >> config.txt
echo "Ly = 0.3" >> config.txt
echo "Nelemx = 1570" >> config.txt
echo "Nelemy = 65" >> config.txt
echo "orderOfBF = 1" >> config.txt
echo "ifDD = 1" >> config.txt
echo "outputingStrategy = 1" >> config.txt
echo "ifRandSeed = 0" >> config.txt
echo "varListOutput = [phi]" >> config.txt
echo "typeOfIC = 2" >> config.txt
echo "ifSubstratePatterning = 1" >> config.txt
echo "typeOfSubstratePatterning = 0" >> config.txt
echo "h1 = $2" >> config.txt
echo "g = 0.0" >> config.txt
}

#prepare command line to executions on linux box
function make_linuxBoxScript {
echo "#!/bin/bash" > $1.sh
echo "COMMAND=\"$PATHtoCOMMAND\"" >> $1.sh
echo "ARGs=\"$ARGS\"" >> $1.sh 
# the end of this line is responsible for redirecting standard output of your executable to file (of the name: OUT)
echo "mpirun -np $2 \$COMMAND \$ARGs >> OUT 2>&1" >> $1.sh
}

#prepare pbs script for stampede
function make_Script {
TP1="(("
TP2="))"
echo "#!/bin/bash" > $1.sh
echo "#SBATCH -A TG-CTS110007        # specify charge" >> $1.sh
echo "#SBATCH -J allp-$2" >> $1.sh
echo "#SBATCH -o allp-$2" >> $1.sh
echo "#SBATCH -p normal" >> $1.sh
echo "#SBATCH -n $3 " >> $1.sh
echo "#SBATCH -t $4" >> $1.sh
echo "" >> $1.sh
echo "ARGs=\"$ARGS\"" >> $1.sh 
echo "" >> $1.sh
echo "ibrun $PATHtoCOMMAND \$ARGS" >> $1.sh
}


#############################################################################

for((i=0;i<($NofTests);i++)); do
     testNumber=$(($i*$NofPar))
     testname=${tests[$testNumber]}
     echo $testname

     rm -rf $testname
     mkdir $testname
     cd $testname
     
     make_inputdataFile ${tests[$(($testNumber+3))]} ${tests[$(($testNumber+4))]} ${tests[$(($testNumber+5))]} ${tests[$(($testNumber+6))]} ${tests[$(($testNumber+7))]};

     #If you need to copy some input data file with meshes etc you can do it here
     cp ../TStowrite.data .


     if [ "$MachineType" == "linux" ]; then 
     	#prepare bashscript of a name ($1) to execute program with given number of cores($2) 
     	make_linuxBoxScript $testname ${tests[$(($testNumber+1))]}
	chmod +x $testname.sh
	#run tests (consider making this tests with screen software if tests are time consuming)
     	./$testname.sh
     fi

    if [ "$MachineType" == "stampede" ]; then 
     	#prepare bashscript of a name ($1) to submit job to cystrom with given number of nodes($2) with set Walltime($3) 
     	make_Script run $testname ${tests[$(($testNumber+1))]} ${tests[$(($testNumber+2))]} ;
	#submit job to stampede

	cp -rf ../src/* .
	mv config.txt src_data
	mv TStowrite.data src_data
	mv run.sh src_data
	
    	#qsub run.sh
     fi	
    cd ..

done



