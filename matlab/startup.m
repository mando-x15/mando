%% STARTUP.M

% set command window format
format compact
format short g

% my functions
addpath(genpath('~/Documents/MATLAB/_includes'))
addpath(genpath('~/PACKAGES/petsc-3.6.0/share/petsc/matlab'))
addpath(genpath('~/Documents/MATLAB/mlinter'))

feature('DefaultCharacterSet', 'UTF8');

beep off

% set plotting defaults
s = get(0,'screensize');

% figure properties
set(0,'defaultAxesLineWidth',0.85); 
set(0,'defaultLineLineWidth',1.2);  
set(0,'defaultLineMarkerSize',6);  
set(0,'DefaultAxesFontSize',14)

% Turn grid lines on by default
set(0, 'defaultAxesXGrid', 'on')
set(0, 'defaultAxesYGrid', 'on')
set(0, 'defaultAxesZGrid', 'on')

% use latex interpreter
%set(0,'defaulttextinterpreter','latex')
%set(0,'defaulttextinterpreter','tex')
set(0,'defaulttextinterpreter','none')

set(0,'defaultaxesfontname','Helvetica')
set(0,'defaulttextfontname','Helvetica');

% size/location on screen
set_fig_location;

clear
clc
