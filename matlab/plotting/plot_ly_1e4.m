
clear; close all;


% plotting colors
bl = [0 114 189]./256;      % parula blue
rd = [161 0 31]./256;       % parula red
org = [217 83 25]./256;     % parula orange
ppl = [106 81 163]./256;    % parula purple

% red shades
color = [253,208,162; ...
    252,187,161;  ...
    252,146,114;  ...
    251,106,74;   ...
    239,59,44;   ...
    203,24,29;   ...
    165,15,21;   ...
    103,0,13]./256;

% loop over heights
ly_files =  dir( 'Ly_*');
NLY = length(ly_files);

% plot properties
D = cell(1,NLY);

% set title / legend
str_title = 'Rg: h1.1e-4';
leg = char('0.2','0.3','0.4','0.5','0.75','1.00','1.50','2.00');

figure;
%setDefProp;

for i = 1:NLY
    
    % get data
    load([ly_files(i).name '/S.mat']);
    
    % h1.1e-4
   % t = S.lp100.t(:,2);
   % Rg = S.lp100.Rg(:,2);
    
    t = S.allp.t(:,2);
    Rg = S.allp.Rg(:,2);
    
    xl = log(t);
    yl = log(Rg);
    
    h = plot(xl,yl); hold on
    set(h,'Color',color(i,:),'LineStyle','-','LineWidth',1.25,'Marker','.','MarkerSize',14)
    D{1,i} = h;
    
    clear S
end

title(str_title);
xlabel('$\bf{ln|t|}$','interpreter','latex');
ylabel('$\bf{ln|R_g|}$','interpreter','latex');
l = legend(leg,'Location','northwest');
set(l, 'Interpreter', 'latex')
set(gca, 'Box', 'off', 'XMinorTick'  , 'on', 'YMinorTick'  , 'on');


%reference line
p = [0.3333,-1.0];
x = linspace(-3.25,-2,50);
fn = p(1).*x + p(2) +0.3;

h = plot(x,fn,'k'); hold on;
set(h,'LineWidth',1.25)


%% PolyFit

% initial points to skip
il = 6;

% fit a 1st order polynomial in range
 xls = xl(il:end-5);
 yls = yl(il:end-5);
 [xData, yData] = prepareCurveData( xls, yls );ft = fittype( 'poly1' );
 f = fit( xData, yData, ft);


% plot fit
p = coeffvalues(f);
x = linspace(xls(1),xls(end),50);
fn = p(1).*x + p(2);

h = plot(x,fn,'m'); hold on;
set(h,'LineWidth',1.0)

% slope on plot
mid = [(xl(1)+xl(end))/2, (yls(3)+yls(end))/2];
str = ['m = ' num2str(p(1)) ];
text(mid(1),mid(2),str, 'Color','m','FontSize',14)

%ylim([-2.8 -1.2])
%xlim([-6 0])









% print
str = 'h1.1e4all_allp'; %#ok<*NASGU>
print(str, '-dpng');




