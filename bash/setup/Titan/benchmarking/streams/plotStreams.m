clear; close all;

load('streams.txt');
load('speedup.txt');
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

leg = char('i7-4790','E3-1270','i7-2600','Core2');


for i = 2:5
    h = plot(streams(:,1),streams(:,i)./1000); hold on;
    set(h,'Marker','.','Color',color(i,:))
    set(h,'LineWidth',2)
    D{1,i} = h;
end



legend([D{1,:}],leg,'Location','southwest');
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

leg = char('i7-4790','E3-1270','i7-2600','Core2','ideal');



   
figure;
set(gcf, 'position', [466 246 802 597] );
D = cell(1,5);
% set up
xrat = 1.5;
yrat = 1;


ideal(:,1) = 1:4;
ideal(:,2) = 1:4;

for i = 2:5
    h = plot(speedup(:,1),speedup(:,i)); hold on;
    set(h,'Marker','.','Color',color(i,:))
    set(h,'LineWidth',2)
    D{1,i} = h;
end

h = plot(ideal(:,1),ideal(:,2),'k'); hold on;
    set(h,'Marker','.')
    set(h,'LineWidth',2)
D{1,6} = h;

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
