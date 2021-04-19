clear; close all;
%% plot for paper
% Written By:    SP
% Last Update:   4/29/15
%% Setup

xrat = 1.5;
yrat = 1;

%% MAIN

% set colormap
rd = [0.706 0.016 0.150];
blu = [0.230 0.299 0.754];
s = linspace(0,1,50);

[map] = diverging_map(s,rd,blu);

load tt.mat
load Em.mat
load noise.mat


figure;
colormap(map);


[C,h1] = contourf(tt,noise,Em',20); hold on;
set(gca,'YScale','log');set(gca,'XScale','log');

hXLabel = xlabel('Time, t');
hYLabel = ylabel('Noise, \sigma');
colorbar
grid off

set( gca                       , ...
    'FontName'   , 'Times' );
set(gca,'FontSize',18)
set(gca, ...
  'Box'         , 'off'     , ...
  'TickDir'     , 'out'     , ...
  'TickLength'  , [.01 .01] , ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1         );

pbaspect([xrat,yrat,1])
set(gcf,'PaperPositionMode','auto')
%set(gcf, 'PaperUnits', 'centimeters');
%set(gcf, 'PaperPosition', [0 0 10 6 ]);

set(gcf,'renderer','painters')
%if ifPrintPDF, save2pdf('contour',gcf,800), end;
 %print(gcf, '-dpdf', '-r600', 'test.pdf')

print('-dpng', '-painters', 'ci0');
hold off;

