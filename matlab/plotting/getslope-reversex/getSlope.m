close all;
%% Calculate time to reach %Bulk energy
% Written By:    SP
% Last Update:   4/13/15
%% Setup

%flags
ifPrintPNG = 0;
ifPrintTXT = 0;

flg = {ifPrintPNG, ifPrintTXT};
%% MAIN

clearvars -except flg
tmp = load('npbc-nNR/dataAll.mat'); npbc_nNR=tmp.data;
tmp = load('npbc-nNR/noise.mat'); noise=tmp.En;
clear data tmp
%% PLOTTING SETUP

plt = 1;
switch plt
    case 1
        p=1; titl = 'npbc-nNR'; data = npbc_nNR;
    case 2
        p=2; titl = 'npbc-NR'; data = npbc_NR;
    case 3
        p=3; titl = 'pbc-nNR'; data = pbc_nNR;
    case 4
        p=4; titl = 'pbc-NR'; data = pbc_NR;
end

% colors
color = [0 114 189; ...     % blue
        20 71 105;  ...     % dk blue
        161 0 31;   ...     % red  
        217 83 25;  ...     % orange
        126 47 172; ...     % ppl
        94 151 17;  ...     % gn
        237 177 32]./256;   % yl
    
leg = char('L1','L2','L3', 'L5', 'L10','L15','L20','L30');
xl = [30 60 100 160 320 475 630 950];
P = 0.975:-0.01:0.5;

%% Calculations

D = cell(1,8);
x = noise(4:end);
xf = log(x');

a = zeros(8,48);
b=a;

for i = 1:8
    for j = 1:48
        
        y = data{1,i}(:,j);
        y = y(4:end);
        
        % fitting
        yf = y;
        [xData, yData] = prepareCurveData( xf, yf );ft = fittype( 'poly1' );
        f = fit( xData, yData, ft);
        
        % coef
        p = coeffvalues(f);
        a(i,j) = p(1);
        b(i,j) = p(2);
        
        clear yf xData yData ft
    end
end

%% Plotting

figure;
set(gcf, 'position', [1882 291 839 550] );

% plot y
for i = 1:8
    y = a(i,:);
    yn = a(i,:)./a(8,:) -1;
    h = plot(P,y);  hold on;
    set(h,'Marker','.')
    D{1,i} = h;
end
set(gca, 'xdir','reverse')
legend([D{1,:}],leg,'Location','northeast')
title('Slope');xlabel('% drop in Bulk Energy, H_p');ylabel('dm');
addPlotProp(D); hold off


figure;
set(gcf, 'position', [1882 291 839 550] );

% plot yn
for i = 1:8
    y = a(i,:);
    yn = a(i,:)./a(8,:) -1;
    h = plot(P,yn);  hold on;
    set(h,'Marker','.')
    D{1,i} = h;
end
set(gca, 'xdir','reverse')
legend([D{1,:}],leg,'Location','northeast')
title('nomalized');xlabel('% drop in Bulk Energy, H_p');ylabel('dm');
addPlotProp(D); hold off


figure;
set(gcf, 'position', [1882 291 839 550] );

% plot noise @ L30, p60 ~i38

y1 = npbc_nNR{1,1}(:,48);
y1 = y1(4:end);

y2 = npbc_nNR{1,8}(:,48);
y2 = y2(4:end);

h = semilogx(x,y1);  hold on;
set(h,'Marker','.')
D{1,1} = h;

h = semilogx(x,y2);  hold on;
set(h,'Marker','.')
D{1,2} = h;

%legend([D{1,:}],leg,'Location','northeast')
title('max-diff');xlabel('Noise');ylabel('t');
addPlotProp(D); hold off





%% printing

set(gcf,'PaperPositionMode','auto')
if flg{1}, print(titl,'-depsc2','-r300'), end;

if flg{2}
    
    fa = '%d';
    fmat = repmat('%5.8f ', [1 6]);
    fmat = [fa ' ' fmat '\n'];
    
    % output err
    fname = 'nPBC_NRM.txt';
    fid = fopen(fname, 'w');
    fprintf(fid,fmat, nrm_o');
    fclose(fid);
    
    % output nNR_o
    fname = 'nPBC_nNR.txt';
    fid = fopen(fname, 'w');
    fprintf(fid,fmat, nNR_o');
    fclose(fid);
    
    % output nNR_o
    fname = 'nPBC_NR.txt';
    fid = fopen(fname, 'w');
    fprintf(fid,fmat, NR_o');
    fclose(fid);
    
end



