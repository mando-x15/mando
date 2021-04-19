function [] = addPlotProp(D)

xrat = 1.5;
yrat = 1;
%xlim( [10^1 10^3])
set([D{1,:}],'LineWidth',1.25,'MarkerSize',15)

pbaspect([xrat,yrat,1])
set(gcf,'PaperPositionMode','auto')
set(gcf,'Renderer','painters')
set(gca,'FontSize',11)

set(gca, 'Box', 'off', ...
  'XMinorTick'  , 'on'      , ...
  'YMinorTick'  , 'on'      , ...
  'LineWidth'   , 1 );
end

