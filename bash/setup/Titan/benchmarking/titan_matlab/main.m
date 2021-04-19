close all; 
% a benchmark for matlab
%% set up

% number of LOGICAL processors to test
proc = 36;

%plotting legend
leg = char('36p');

% memory per proc (GB)
mem = 10;

% flags
ifRunData = 1;
ifPlotData = 1;
ifPrintPNG = 1;
ifSaveData = 1;

flg = { ifRunData, ifPlotData, ifPrintPNG, ifSaveData};
%% MAIN
clearvars -except flg proc flg mem R k leg
n = length(proc);

if flg{1} == 1
    R = cell(1,n);
    k = 0;
    for i = n:-1:1
        R{i} = MYparalleldemo_backslash_bench(mem,proc(i));
        k=k+1;
    end
end


% get max performance
for i = 1:k
    s(i) = max(R{1,i}.gflops);
end


if flg{2} == 1
%% PLOTTING

% setup
xrat = 1.5;
yrat = 1;

% colors
bl = [0 114 189]./256;
dkbl = [20 71 105]./256;
rd = [161 0 31]./256;
og = [217 83 25]./256;
ppl = [126 47 172]./256;
gn = [94 151 17]./256;
yl = [237 177 32]./256;

color = [bl; rd; og; dkbl; ppl; og; gn; yl];
%% plot GFLOPS
fig = figure;
ax = axes('parent', fig);
D = cell(1,k);

for i = 1:k
    x = R{1,i}.matSize/1000;
    y = R{1,i}.gflops;
    h = plot(ax, x, y); hold on;
    set(h,'Color', color(i,:))
    set(h,'Marker','.','MarkerSize',15)
    D{1,i} = h;
end

ylabel(ax, 'Gflops')
xlabel(ax, 'Matrix size (thousands)')
titleStr = sprintf('Solving A\\b for different matrix sizes: GFLOPS');
title(ax, titleStr, 'Interpreter', 'none');
legend([D{1,:}],leg,'Location','northWest')
pbaspect([xrat,yrat,1])
set(gcf,'PaperPositionMode','auto')
if flg{3}, print('gflops', '-dpng', '-r500'), end;


%% plot time

fig = figure;
ax = axes('parent', fig);
D = cell(1,k);

for i = 1:k
    x = R{1,i}.matSize/(1000);
    y = R{1,i}.time;
    h = plot(ax, x, y); hold on;
    set(h,'Color', color(i,:))
    set(h,'Marker','.','MarkerSize',15)
    D{1,i} = h;
end

ylabel(ax, 'time, s')
xlabel(ax, 'Matrix size (thousands)')
titleStr = sprintf('Solving A\\b for different matrix sizes: TIME');
title(ax, titleStr, 'Interpreter', 'none');
legend([D{1,:}],leg,'Location','northWest')
pbaspect([xrat,yrat,1])
set(gcf,'PaperPositionMode','auto')
if flg{3}, print('time', '-dpng', '-r500'), end;

%% plot speedup

fig = figure;
ax = axes('parent', fig);

h=plot(proc,s);
set(h,'Color', color(4,:))
set(h,'Marker','.','MarkerSize',15)

ylabel(ax, 'gflops')
xlabel(ax, 'proc')
titleStr = sprintf('Solving A\\b for different matrix sizes: SP MAX');
title(ax, titleStr, 'Interpreter', 'none');
pbaspect([xrat,yrat,1])
set(gcf,'PaperPositionMode','auto')
if flg{3}, print('sp', '-dpng', '-r500'), end;


end

for i = 1:k
    R{2,i} = proc(i);
end

if flg{4} == 1
    save('bench.mat','R') 
end
