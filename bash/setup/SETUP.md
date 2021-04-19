### SETUP FOR UBUNTU 14.04 ###

#### Software for students:
[COE Downloads Link](https://iastate.app.box.com/files/0/f/6532320317/College_of_Engineering_Software_Downloads_(Student))

1. System Settings > Software & Updates > check graphics and cannonical partners
	- run Ubuntu System update, make sure everything is updated.. this will take a while.

2. copy ` install.sh` and `pkglist.txt` to desktop and run.
	- will take a while (restart afterwards)

3. Install Chrome

4. Customize: 
	- unity-tweak > workspaces (4x3)
	- Wallpaper/sidebar *(34)*
	- Terminal Size: 90x24
	- system load indicator
	- gedit: line numbers & tabs

5. copy over `bashrc` & `bash_aliases`

6. vim colorscheme:
	- `mkdir .vim && mkdir .vim/colors`
	- `cp mustang.vim ~/.vim/colors`
	- vi .vimrc (copy in)

7. Install Tecplot (as root)
	- locate .zip in /packages --> downloads, then run script:
	
	```
		chmod 777 tecplot360ex_linux64.sh
		sudo ./tecplot360ex_linux64.sh
		
	```
	- install path: `/opt/tecplot360ex`
	- copy license into dir: 
	
	```
		sudo cp tecplotlm.lic /opt/tecplot360ex/
	
	```

	#### right click setup	
	- `sudo cp tec360.png /opt/tecplot360ex/`
	- right-click setup (restart afterwards)
	- update path in bashrc: `export PATH=$PATH:/opt/tecplot360ex/bin`
	- check terminal and right click setup
	- place icon in launcher (search, click & drag)
	

8. Install Matlab (as root) 
	- .zip in /packages --> downloads, then run script
	- pass: `HUh-pbr-qb9-LNJ`
	- install dir: `/opt/MATLAB/R2015b`  (for general usage) otherwise matlab's default is `/usr/local/MATLAB/R2016a`
	- check yes for symlinks in `usr/local/bin`
	- Add additional features: `rename matlab gcc libraries: yes ` __Warning: might break gcc!!! dont overwrite__ 
		- `sudo apt-get install matlab-support`
	- `sudo chown <user> -R ~/.matlab`
	- place icon in launcher (search, click & drag)
	- antialiasing to smooth fonts: preferences > fonts
	- keyboad > shortcuts > windows default
	
start from terminal - the updated symlinks in usr/local/bin will find the correct version.
Matlab takes up ~12+ GB, it is best to delete the old version. 
    
9. Install PETSc
	- update paths in bashrc

10. Install TalyFEM: 
	- `git clone https://spfeife@bitbucket.org/baskargroup/taly_fem.git`
	- CC = mpicxx
	- CC_FLAGS += -std=c++0x -O2

11. Install Paraview
	- extract tar
	- update bashrc.
	- add desktop icon

12. Setup Printer:
	-	ip address: `10.10.35.4`

13. Install Dropbox (optional)

## Additional


1. Install Gnuplot 5.0 - (src in /packages)

Will need:
`sudo apt-get install libcairo2-dev`
`sudo apt-get install libpango1.0-dev`

Then install using:
`./configure --with-qt --with-x --with-cairo ` 
`make`
`make install`


### package management ###

####- automatically install package list
` sudo aptitude update && cat pkglist.txt | xargs sudo aptitude install -y `


####- get package list
` sudo dpkg --get-selections | sed "s/.*deinstall//" | sed "s/install$//g" > ~/pkglist `



### Graphics ###
 - opengl drivers:  `glxinfo | grep OpenGL`
 - hardware: 		lspci -v -s `lspci | awk '/VGA/{print $1}'`


## migrating over ##

sudo rsync sources.list /etc/apt/
sudo rsync -arv opt/ /opt/

#### must go through /ect manually to figure out which packages need merged or not, meld 
sudo rsync -arv etc/ /etc/

#### as well as the /home directory config files 
 rsync -arv google-chrome/ /home/htran/.config/

/etc/apt/sources.list

## Matlab activation for different user ##
`/opt/MATLAB/R2015b/bin/activate_matlab.sh`
