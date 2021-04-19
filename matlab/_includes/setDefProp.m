% sets all default plotting properties, run once

% print settings
height = 7;         % Height in inches
width = 10;         % Width in inches

% screen info
s = get(0,'screensize');

% figure properties
set(0,'defaultAxesLineWidth',0.85); 
set(0,'defaultLineLineWidth',1.2);  
set(0,'defaultLineMarkerSize',6);  
set(0,'DefaultAxesFontSize',14)

% use latex interpreter
%set(0,'defaulttextinterpreter','latex')
%set(0,'defaulttextinterpreter','tex')
set(0,'defaulttextinterpreter','none')

set(0,'defaultaxesfontname','Helvetica')
set(0,'defaulttextfontname','Helvetica');

% size/location on screen
if ismac
    set(0,'defaultFigurePosition', [211 94 854 534]);
else
    set(0,'defaultFigurePosition', [s(3)/4 s(4)/4 ceil(s(3)/1.5) ceil(s(4)/1.5)]);
    movegui('center') 
end

% set png output size
set(0,'defaultFigureInvertHardcopy','on');
set(0,'defaultFigurePaperUnits','inches'); 
defsize = get(gcf, 'PaperSize');
left = (defsize(1)- width)/2;
bottom = (defsize(2)- height)/2;
defsize = [left, bottom, width, height];
set(0, 'defaultFigurePaperPosition', defsize);


%clean up 
clear s height width left bottom defsize
