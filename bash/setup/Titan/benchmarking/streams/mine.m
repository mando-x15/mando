clear; close all;

sm = load('myCode_small.txt');
lrg = load('myCode_large.txt');

spd1 = sm(1,2)./sm;
spd2 = lrg(1,2)./lrg;

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


    h = plot(sm(:,1),sm(:,2)); hold on;
    set(h,'Marker','.','Color',color(1,:))
    set(h,'LineWidth',2)


title('Small');xlabel('Processes');ylabel('time, (s)');
set(gca,'FontSize',10);
pbaspect([xrat,yrat,1])

set(h,'LineWidth',1.25,'MarkerSize',15)

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


    h = plot(lrg(:,1),lrg(:,2)); hold on;
    set(h,'Marker','.','Color',color(2,:))
    set(h,'LineWidth',2)


title('Small');xlabel('Processes');ylabel('time, (s)');
set(gca,'FontSize',10);
pbaspect([xrat,yrat,1])

set(h,'LineWidth',1.25,'MarkerSize',15)

set(gcf,'PaperPositionMode','auto')
set(gcf,'Renderer','painters')
set(gca,'FontSize',11)

set(gca, 'Box', 'off', ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1 );

hold off



