%% PERFECT_3D_PLOT
% Takes non-uniform mesh data and plots a nice 3d plot
%
%% Description:
% Performs calculations for both Brass and SS
%
% Input:
%   Requires plot_data.mat to run
%
% Written By:    Spencer Pfeifer
% Last Update:   10/25/16

%% BEGIN
clear; close all;

% load data
load('plot_data.mat');
clear C;

% Create fit model
zm = zm./max(max(zm));
[xData, yData, zData] = prepareSurfaceData( xm, tm, zm );

% Fit model to data.
[fitresult, gof] = fit( [xData, yData], zData, 'biharmonicinterp', 'Normalize', 'on' );

% Map data to uniform mesh
x = 0.01:0.01:0.2;
y = logspace(log10(0.0061),log10(5), 35);

[xq,yq] = meshgrid(x,y);
[r,c] = size(xq);

zq = fitresult(xq(:),yq(:));
zq = reshape(zq,r,c);

% now interpolate data using interp2 -- leaving a little bit excess on the
% boundaries, these will go to zero
x = linspace(0.001,0.21,100);
y = logspace(log10(0.005),log10(5.01),100);

[Xq,Yq] = meshgrid(x,y);
[r,c] = size(Xq);

Vq = interp2(xq,yq,zq,Xq,Yq,'spline',0);


%% PLOTTING

% set colors
gry = 0.6 * [1 1 1];   % gray
C(:,:,1) = gry(1) * ones(r,c);
C(:,:,2) = gry(2) * ones(r,c);
C(:,:,3) = gry(3) * ones(r,c);

% plot
h = mesh(Xq,Yq,Vq,C);

% scale & lines in one direction only
set(gca,'YScale','log')
set(h,'FaceLighting','gouraud','EdgeLighting','flat');
set(h,'MeshStyle','row','LineWidth',0.75,'FaceColor',[1 1 1]);
set(h,'EdgeColor','flat');

% limits
xlim([0.0009,0.22])
ylim([0.004,8])
zlim([0,1.0])

% axis settings
set(gca,'Ydir','reverse')
set(gca,'LineWidth', 1.0)

% grid settings
set(gca,'YMinorGrid','off')
set(gca,'GridLineStyle',':')
set(gca,'GridColor',[0.05,0.05,0.05])
set(gca,'GridAlpha',0.5)

tk1 = 0.02:0.02:0.2;
tk2 = [0.01 0.05 0.1 0.15 0.2];
set(gca,'XTick',tk2)

% aspect ratio
pbaspect([1,1,0.4])
view([30, 20]);

% labels & titles
xlabel('lp');
ylabel('time, t');
title('my perfect plot')

