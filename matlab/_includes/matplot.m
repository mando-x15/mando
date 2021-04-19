function matplot(V,M,varargin)
% MATPLOT quick plotting script
%   Returns a VECTOR of (x, y, phi) data
%
% General Context:
%   [data] = matplot('dataCH_h_curr_0.60');
%
% Input:
%       V: x-axis vector
%       M: matrix to loop over
%       varargin1 = legend
% size is based upon length of the legend
%

%%
% Written By:    SP
% Last Update:   8/14/15
%
%% SETUP

% set defaults
n = length(V);
[~,c] = size(M);
nPlot = c;

ifLeg = false;

if iscell(varargin{1})
    ifLeg = true; leg = varargin{1};
    nLeg = length(leg);
    nPlot = nLeg;
end
    
color = [0 114 189; ...     % blue
    161 0 31;   ...     % red
    217 83 25;  ...     % orange
    126 47 172; ...     % ppl
    94 151 17;  ...     % gn
    20 71 105;  ...     % dk blue
    237 177 32]./256;   % yl


figure;
set(gcf, 'position', [466 246 802 597] );
D = cell(1,c);

for i = 1:nPlot
    h = plot(V,M(:,i)); hold on;
    set(h,'Marker','.')
    if c < 8, set(h,'Color',color(1,:)); end;
    set(h,'LineWidth',1.25,'MarkerSize',15)
    D{1,i} = h;
end

set([D{1,:}],'LineWidth',1.25,'MarkerSize',15)
set(gcf,'PaperPositionMode','auto')
set(gcf,'Renderer','painters')
set(gca,'FontSize',11)
pbaspect([1.2,1,1])
set(gca, 'Box', 'off', ...
    'XMinorTick'  , 'on'      , ...
    'YMinorTick'  , 'on'      , ...
    'LineWidth'   , 1 );

hold off

if ifLeg, legend([D{1,:}],leg,'Location','northeast');


end
