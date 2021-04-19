clear; close all;
%% PLOT_DATA:  A short script to visualize 3D field data of a
%               given dataset
%
% USAGE:
%   Simply run this script.  Will prompt user for input.
%
% Written By:    Spencer Pfeifer
%                spfeife@istate.edu
% Date:   1/4/16
%
%% OPTIONAL INPUT
% set filename.  Rather than using UI. Format: dataset/file
%               e.g. run1/dataCH.0000.txt


filename = 'dataCH_final.plt';



tic
%% MAIN

% load data
N = loadPLT(filename, 'N');
v = loadPLT(filename);

V = reshape(v(:,4),N(1),N(2),N(3));

% plot
figure;
data = smooth3(V,'box',5);

isoval = 0.0;
h = patch(isosurface(data,isoval),...
    'FaceColor','blue',...
    'EdgeColor','none', ...
    'AmbientStrength',.2,...
    'SpecularStrength',.5,...
    'DiffuseStrength',.4);

isonormals(data,h)

patch(isocaps(data,isoval),...
    'FaceColor','interp',...
    'EdgeColor','none')


% set colormap
rd = [0.706 0.016 0.150];
blu = [0.230 0.299 0.754];
s = linspace(0,1,50);

[map] = diverging_map(s,rd,blu);

% lighting & etc
colormap(map)
colorbar

caxis([0 1])
daspect([1,1,1])
axis tight

view([300 15]);
camlight 'headlight'

view([135 15]);
camlight right
camlight left
lighting gouraud

[pathstr,name,ext] = fileparts(filename); 
title(name)
xlabel('x')
ylabel('y')
zlabel('z')

toc