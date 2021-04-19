# Hydra Binding Options

Note: Make sure you're using the petsc-installed MPICH. Check location of mpirun:

`which mpirun`
/Users/spfeife/PACKAGES/petsc-3.5.4/arch-osx-debug/bin/mpirun

If the system already has a symlink in `/usr/bin/mpirun`, remove this and replace it with the petsc MPICH version.

### bindings allowed:
```
    cd /home/share/petsc-3.4.5/externalpackages/mpich-3.0.4-106/src/pm/hydra/examples
    mpiexec -n 8 -bind-to socket ./print_cpus_allowed | sort
```

#### Socket 1 / Socket 2

```
    bglab1.me.iastate.edu[0]: Cpus_allowed_list:    0-17,36-53
    bglab1.me.iastate.edu[1]: Cpus_allowed_list:    0-17,36-53
    bglab1.me.iastate.edu[2]: Cpus_allowed_list:    0-17,36-53
    bglab1.me.iastate.edu[3]: Cpus_allowed_list:    0-17,36-53
    bglab1.me.iastate.edu[4]: Cpus_allowed_list:    0-17,36-53
    bglab1.me.iastate.edu[5]: Cpus_allowed_list:    0-17,36-53
    bglab1.me.iastate.edu[6]: Cpus_allowed_list:    0-17,36-53
    bglab1.me.iastate.edu[7]: Cpus_allowed_list:    0-17,36-53
```


## Single Terminal Testing
Here I'm simply checking to see what the effect of binding specific processors is.

### Baseline
Let the system automatically choose the binding:

`time mpirun -np 8 ./binary_CH > out.log 2>&1`
21.098
20.882


### Bind to specific threads:
`time mpirun -np 8 -bind-to user:0,2,4,6,8,10,12,14 ./binary_CH > out.log 2>&1`
19.44

`time mpirun -np 8 -bind-to user:0,1,2,3,4,5,6,7 ./binary_CH > out.log 2>&1`
19.28
19.57

#### Split across sockets:
`time mpirun -np 8 -bind-to user:0,1,2,3,36,37,38,39 ./binary_CH > out.log 2>&1`
30.876

`time mpirun -np 4 -bind-to user:0,1,2,3 ./binary_CH > out.log 2>&1`
32.545

`time mpirun -np 4 -bind-to user:0,1,36,37 ./binary_CH > out.log 2>&1`
57.686
57.68

## Multiple terminals running 
Now, since PETSc is bandwidth-limited, what happens when multiple processes are running simultaneously? 

### Baseline: 2 terminals
`time mpirun -np 8 ./binary_CH > out.log 2>&1`
20.258  / 19.784

### Baseline: 3 terminals
`time mpirun -np 8 ./binary_CH > out.log 2>&1`
24.928 / 24.261 / 20.885


### Bind to specific threads:
`time mpirun -np 8 -bind-to user:0,1,2,3,4,5,6,7 ./binary_CH > out.log 2>&1`
22.548 / 24.338 / 21.645

### Bind to specific sockets:
`time mpirun -np 8 -bind-to socket ./binary_CH > out.log 2>&1``
34.506 / 35.050 / 34.653

`time mpirun -np 8 -bind-to socket:0 ./binary_CH > out.log 2>&1`
`time mpirun -np 8 -bind-to socket:1 ./binary_CH > out.log 2>&1`
21.225 / 21.461 / 22.307

`time mpirun -np 8 -bind-to socket:0 -map-by hwthread ./binary_CH > out.log 2>&1`
20.377 / 21.545 / 23.212


---------------------------------------------------------------------------------


### Reference:

[Mpich.Wiki](https://wiki.mpich.org/mpich/index.php/Using_the_Hydra_Process_Manager)



