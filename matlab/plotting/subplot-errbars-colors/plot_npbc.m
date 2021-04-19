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
tmp = load('npbc-nNR/data.mat'); npbc_nNR=tmp.data;
tmp = load('npbc-NR/data.mat'); npbc_NR=tmp.data;

%% PLOTTING

plt = 1;
switch plt
    case 1
        p=1; titl = 'npbc-tops'; ylr = [0.04 0.08]; yls = [0 0.005]; yle = [-0.005 0.005];
    case 2
        p=2; titl = 'npbc-80p'; ylr = [0.2 0.35]; yls = [0 0.005]; yle = [-0.005 0.005];
    case 3
        p=3; titl = 'npbc-50p';ylr = [0.2 0.35]; yls = [0 0.025]; yle = [-0.05 0.035];
end

% colors
color = [0 114 189; ...     % blue
        20 71 105;  ...     % dk blue
        161 0 31;   ...     % red  
        217 83 25;  ...     % orange
        126 47 172; ...     % ppl
        94 151 17;  ...     % gn
        237 177 32]./256;   % yl
    
figure;
set(gcf, 'position', [200 61 1401 871] );

leg = char('NR','nNR');  % 5,11,17
x = [30 60 100 160 320 475 630 950];

%% 1e-11
D = cell(1,8);
NR_o(:,1) = x;
nNR_o(:,1) = x;
nrm_o(:,1) = x;

ya = npbc_NR{1,8}(5,p);
for i = 1:8
    y(1,i) = npbc_NR{1,i}(5,p);
    ys(1,i) = npbc_NR{2,i}(5,p);
    y(2,i) = npbc_nNR{1,i}(5,p);
    ys(2,i) = npbc_nNR{2,i}(5,p);
end

NR_o(:,2) = y(1,:);
nNR_o(:,2) = y(2,:);
NR_o(:,3) = ys(1,:);
nNR_o(:,3) = ys(2,:);
nrm_o(:,2) = y(1,:)./ya -1;
nrm_o(:,3) = y(2,:)./ya -1;

subplot(3,3,1);
for i = 1:2
    h = semilogx(x,y(i,:));  hold on;
    set(h,'Marker','.','Color',color(i,:))
    errorbar(x,y(i,:),ys(i,:),'Color',color(i,:));
    D{1,i} = h;
end

% all figure properties
legend([D{1,:}],leg,'Location','southeast')
title('1e-11');xlabel('Elements, El_x');ylabel('Time, t');
addPlotProp(D); hold off
hold off;

% STD
subplot(3,3,2);
for i = 1:2
    h = semilogx(x,ys(i,:));  hold on;
    set(h,'Marker','.','Color',color(i,:))
    D{1,i} = h;
end

% all figure properties
ylim( yls)
title('STD');xlabel('Elements, El_x');ylabel('Time, t');
addPlotProp(D); hold off

% NRM
subplot(3,3,3);
for i = 1:2
    h = semilogx(x,y(i,:)./ya -1);  hold on;
    set(h,'Marker','.','Color',color(i,:))
    D{1,i} = h;
end

% all figure properties
title('NRM');xlabel('Elements, El_x');ylabel('Time, t');
addPlotProp(D); hold off
clear y ys ya

%% 1e-08
D = cell(1,8);
ya = npbc_NR{1,8}(11,p);
for i = 1:8
    y(1,i) = npbc_NR{1,i}(11,p);
    ys(1,i) = npbc_NR{2,i}(11,p);
    y(2,i) = npbc_nNR{1,i}(11,p);
    ys(2,i) = npbc_nNR{2,i}(11,p);
end

NR_o(:,4) = y(1,:);
nNR_o(:,4) = y(2,:);
NR_o(:,5) = ys(1,:);
nNR_o(:,5) = ys(2,:);
nrm_o(:,4) = y(1,:)./ya -1;
nrm_o(:,5) = y(2,:)./ya -1;

subplot(3,3,4);
for i = 1:2
    h = semilogx(x,y(i,:));  hold on;
    set(h,'Marker','.','Color',color(i,:))
    errorbar(x,y(i,:),ys(i,:),'Color',color(i,:));
    D{1,i} = h;
end

% all figure properties
title('1e-08');xlabel('Elements, El_x');ylabel('Time, t');
addPlotProp(D); hold off

% STD
subplot(3,3,5);
for i = 1:2
    h = semilogx(x,ys(i,:));  hold on;
    set(h,'Marker','.','Color',color(i,:))
    D{1,i} = h;
end

% all figure properties
ylim( yls)
title('STD');xlabel('Elements, El_x');ylabel('Time, t');
addPlotProp(D); hold off

% NRM
subplot(3,3,6);
for i = 1:2
    h = semilogx(x,y(i,:)./ya -1);  hold on;
    set(h,'Marker','.','Color',color(i,:))
    D{1,i} = h;
end

% all figure properties
title('NRM');xlabel('Elements, El_x');ylabel('Time, t');
addPlotProp(D); hold off
clear y ys ya

%% 1e-05
D = cell(1,8);
ya = npbc_NR{1,8}(17,p);
for i = 1:8
    y(1,i) = npbc_NR{1,i}(17,p);
    ys(1,i) = npbc_NR{2,i}(17,p);
    y(2,i) = npbc_nNR{1,i}(17,p);
    ys(2,i) = npbc_nNR{2,i}(17,p);
end

NR_o(:,6) = y(1,:);
nNR_o(:,6) = y(2,:);
NR_o(:,7) = ys(1,:);
nNR_o(:,7) = ys(2,:);
nrm_o(:,6) = y(1,:)./ya -1;
nrm_o(:,7) = y(2,:)./ya -1;

subplot(3,3,7);
for i = 1:2
    h = semilogx(x,y(i,:));  hold on;
    set(h,'Marker','.','Color',color(i,:))
    errorbar(x,y(i,:),ys(i,:),'Color',color(i,:));
    D{1,i} = h;
end
title('1e-05');xlabel('Elements, El_x');ylabel('Time, t');
addPlotProp(D); hold off

% STD
subplot(3,3,8);
for i = 1:2
    h = semilogx(x,ys(i,:));  hold on;
    set(h,'Marker','.','Color',color(i,:))
    D{1,i} = h;
end
title('STD');xlabel('Elements, El_x');ylabel('Time, t');
ylim( yls)
addPlotProp(D); hold off

% NRM
subplot(3,3,9);
for i = 1:2
    h = semilogx(x,y(i,:)./ya -1);  hold on;
    set(h,'Marker','.','Color',color(i,:))
    D{1,i} = h;
end

title('NRM');xlabel('Elements, El_x');ylabel('Time, t');
addPlotProp(D); hold off

tt = [ 'PBC: ' titl(end-2:end)];
suptitle(tt)

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



