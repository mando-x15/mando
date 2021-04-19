
% basic syntax
h = plot(x,T,'^');
set(h,'Color', 'k','MarkerFaceColor','k', 'MarkerSize',7);
set(h,'Color',rd);


% labels
xlabel('x');
ylabel('y');
title('Laminar Flow','FontSize',20);
legend('Exp.', 'T_s','T_m', 'Location','Northwest')
grid on



%% LineStyles 
    '-', '--', ':', '-.'	
    
% Markers
    '+'	'o'	'*'	'.'	'x'	
    'square' or 's', 'diamond' or 'd'
    '^'	'v'	'>'	'<'	
    'pentagram' or 'p', 'hexagram' or 'h'



% set multiple properties
h = plot(xl,yl); hold on
set(h,'Color',color(i,:),'LineStyle','-','LineWidth',1.25,'Marker','.','MarkerSize',14)
D{1,i} = h;


% multi-line title
    str = ['C: n = ' d(k).n];
    str2 = '\fontsize{10}\it{late-stage}';
    title({str;str2},'interpreter','tex'); 
    


% latex labels
title(str_title);
xlabel('$\bf{ln|t|}$','interpreter','latex');
ylabel('$\bf{ln|R_g|}$','interpreter','latex');
set(gca, 'Box', 'off', 'XMinorTick'  , 'on', 'YMinorTick'  , 'on');



% surf with points
figure;
surf(xm,tm,zm,'edgecolor','black','edgealpha',0.25,'linewidth',0.5, 'facealpha', 0.75);
colorbar
hold on

% scatter of points
%h = scatter3(xm,ym,CF,'filled');
%set(h,'MarkerEdgeColor','k','MarkerFaceColor','k')

colormap jet
set(gca,'yscale','log')
xlabel('patterning, lp');
ylabel('time, t');
zlabel('cf');





%% LEGEND INFO

% latex legend
l = legend(leg,'Location','northwest');
set(l, 'Interpreter', 'latex')

% move legend below and horizontal
l = legend('Conduction','Convection', 'Radiation', 'Location','Southoutside');
set(l,'Orientation','horizontal','Location','southoutside');



%% Set Ticks & Formatting

% set ytick values
y1 = 0:0.05:0.15;
y2 = 0.20:0.1:1.0;
yticks([y1 y2].*100)

% format to percentage
ytickformat('percentage')




% plotting colors
bl = [0 114 189]./256;      % parula blue
rd = [161 0 31]./256;       % parula red
org = [217 83 25]./256;     % parula orange
ppl = [106 81 163]./256;    % parula purple
gry = [100 100 100]./256;   % gray


% red shades
color = [253,208,162; ...
    252,187,161;  ...
    252,146,114;  ...
    251,106,74;   ...
    239,59,44;   ...
    203,24,29;   ...
    165,15,21;   ...
    103,0,13]./256;
    
    
    
% parula, full (auto)
clr = [ 0    0.4470    0.7410;...       % Blue
    0.8500    0.3250    0.0980;...      % Orange
    0.9290    0.6940    0.1250;...      % Yellow
    0.4940    0.1840    0.5560;...      % Purple
    0.4660    0.6740    0.1880;...      % Green
    0.3010    0.7450    0.9330;...      % light blue
    0.6350    0.0780    0.1840];        % Red
