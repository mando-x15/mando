clear; close all;
%% plotting example1
% Written By:    SP
% Last Update:   3/20/15
%% Setup

ifPrintPDF = 0;
ifPrintPNG = 1;
%% Some Data

% load data1
fid = fopen('energy.txt');
e1 = cell2mat(textscan(fid,'%f %f %f %f %f','Headerlines',1));
fclose(fid);

t = e1(:,1);

% load data1
fid = fopen('betti1.txt');
b1 = cell2mat(textscan(fid,'%d %d %d %d %d %d %d %d %d'));
fclose(fid);

D = [3 5 7 10];
P = [0.975 0.9 0.8];

%% plotting

% set up
xrat = 1.5;
yrat = 1;

%legend
leg = char('total','bulk','int');

% one line at a time
figure;
h = semilogx(t,e1(:,2),t,e1(:,3),t,e1(:,4));hold on;
set(h,'LineWidth',2)
legend(leg,'Location','northeast')
title('Energy Plot');xlabel('Time, t');ylabel('energy');
set(gca,'FontSize',10);
pbaspect([xrat,yrat,1])
if ifPrintPDF, save2pdf('Energy',gcf,600), end;
if ifPrintPNG, print('Energy', '-dpng', '-r500'); end;
hold off

% for loop
leg = char('97.5','90','0.8');

figure;
for i = 1:length(P)
    h = plot(D,b1(:,i));  hold on;
    set(h,'Marker','.','MarkerSize',15)
end
legend(leg,'Location','northeast')
title('Betti Number');xlabel('Lx');ylabel('Betti, \beta');
pbaspect([xrat,yrat,1])
if ifPrintPDF, save2pdf('Betti',gcf,600), end;
if ifPrintPNG, print('Betti', '-dpng', '-r500'); end;
hold off