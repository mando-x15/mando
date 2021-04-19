



%% Simple Bar Plot
x = -2.9:0.2:2.9;
y = exp(-x.*x);
bar(x,y)

%% Detailed Bar Graph

figure;
y = [pct_cond', pct_conv', pct_rad'].*100;
b = bar(v_mph, y); hold on

b(3).FaceColor = bl;
b(1).FaceColor = rd;
b(2).FaceColor = org;

xlabel('Velocity [mph]');
ylabel('% HT Loss');
title('HT Mode Comparison','FontSize',20);
l = legend('Conduction','Convection', 'Radiation', 'Location','Southoutside');
set(l,'Orientation','horizontal','Location','southoutside');

y1 = 0:0.05:0.15;
y2 = 0.20:0.1:1.0;
yticks([y1 y2].*100)

ytickformat('percentage')

grid on
hold off





% colors
bl = [0 114 189]./256;  % parula blue
rd = [161 0 31]./256;   % parula red
org = [217 83 25]./256; %  parula orange

y = [qh P(i); qm P(i); qc P(i)];
b = bar(y);

b(2).FaceColor = rd;

xlabel('Section');
xlabh = get(gca,'XLabel');
set(xlabh,'Position',get(xlabh,'Position') - [0 0.5 0])
set(gca,'XTick', 1:3,'XTickLabel',{'Heated', 'Specimen', 'Cooled'})
ylabel('Power [W]');
title(titles{1,i},'FontSize',20);
legend('q_x','P_{in}')
grid on