clear; close all;

titan = load('titan_streams.txt');
titan_spd = load('titan_speedup.txt');

% colors
color = [0 114 189; ...     % blue
        20 71 105;  ...     % dk blue
        161 0 31;   ...     % red  
        217 83 25;  ...     % orange
        126 47 172; ...     % ppl
        94 151 17;  ...     % gn
        237 177 32]./256;   % yl
    
    
figure;
set(gcf, 'position', [466 246 802 597] );
D = cell(1,5);
% set up
xrat = 1.5;
yrat = 1;

leg = char('Titan');

h = plot(1:72,titan(:,1)./1000);
set(h,'Marker','.')
set(h,'LineWidth',2)
D{1,1} = h;


legend([D{1,:}],leg,'Location','northwest');
title('Streams');xlabel('Processes');ylabel('GB/s');
set(gca,'FontSize',10);
pbaspect([xrat,yrat,1])

set([D{1,:}],'LineWidth',1.25,'MarkerSize',15)

set(gcf,'PaperPositionMode','auto')
set(gcf,'Renderer','painters')
set(gca,'FontSize',11)

set(gca, 'Box', 'off', ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1 );

hold off







figure;
set(gcf, 'position', [466 246 802 597] );
D = cell(1,5);
% set up
xrat = 1.5;
yrat = 1;

leg = char('Titan');

h = plot(titan_spd(:,1),titan_spd(:,2));
set(h,'Marker','.')
set(h,'LineWidth',2)
D{1,1} = h;


legend([D{1,:}],leg,'Location','northwest');
title('Speedup');xlabel('Processes');ylabel('Speedup');
set(gca,'FontSize',10);
pbaspect([xrat,yrat,1])

set([D{1,:}],'LineWidth',1.25,'MarkerSize',15)

set(gcf,'PaperPositionMode','auto')
set(gcf,'Renderer','painters')
set(gca,'FontSize',11)

set(gca, 'Box', 'off', ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1 );

hold off
