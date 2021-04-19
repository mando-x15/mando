clear; close all;
%% plotting -randseed
% Written By:    SP
% Last Update:   4/10/15
%% Setup

ifPrint = 0;

flg = {ifPrint};
%% Some Data

% load data1
fid = fopen('data/Betti_mean_nNR.txt');
nNR = cell2mat(textscan(fid,'%f %f %f %f %f'));
fclose(fid);

% all time is the same
fid = fopen('data/time_.txt');
t = cell2mat(textscan(fid,'%f %f %f %f %f'));
fclose(fid);

t = t(:,1);

fid = fopen('data/Betti_mean_NR.txt');
NR = cell2mat(textscan(fid,'%f %f %f %f %f'));
fclose(fid);

d = abs(nNR-NR)./nNR;
d(isnan(d)) = 0;

% %get norm
for i = 1:5
    L2(i) = norm(nNR(:,i));
    dL2(i) = norm(d(:,i))/L2(i);
end

%% plotting

% set up
xrat = 1.5;
yrat = 1;

% colors
color = [0 114 189; ...     % blue
        20 71 105;  ...     % dk blue
        161 0 31;   ...     % red  
        217 83 25;  ...     % orange
        126 47 172; ...     % ppl
        94 151 17;  ...     % gn
        237 177 32]./256;   % yl
    

%% Betti number
leg = char('nNR','NR');

for i = 1:5 %:1
    y1 = nNR(:,i);
    y2 = NR(:,i);
    
    h = loglog(t,y1,'b',t,y2,'r'); hold on;
    set(h,'Marker','.','MarkerSize',15)
    
end
legend(leg,'Location','northeast')
title('\beta 1');xlabel('time,t');ylabel('\beta_1');
pbaspect([xrat,yrat,1])
set(gcf,'PaperPositionMode','auto')
if flg{1}, print('betti1_nNR-NR-seeds', '-dpng', '-r500'), end;
hold off



%% L2-Norm with power law curve-fit
D = [ 100 160 320 475 630 ];

%Latex ylabel (L2 norm)
ylbl ='$$|| \beta_1 - \beta_2 ||_2$$';
leg = char('L_2','f=ax^k');

% power law curve-fitting
p=polyfit(log(D),log(dL2),1);
k=p(1);
a=exp(p(2));

figure;
h = loglog(D,dL2,'.'); hold on;
set(h,'Marker','^','MarkerSize',8,'MarkerEdgeColor',dkbl,'MarkerFaceColor',bl)

h = plot(D,a*D.^k);
set(h,'Color',rd)

title('L_2 Error ');xlabel('N^{2}');ylabel(ylbl,'interpreter','LaTex');
legend(leg,'Location','northeast')
pbaspect([xrat,yrat,1])
set(gcf,'PaperPositionMode','auto')
if flg{1}, print('L2_betti1_nNR-NR-seeds', '-dpng', '-r500'), end;
hold off









