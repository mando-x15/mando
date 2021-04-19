
% SET_FIG_LOCATION: simply sets the defualt location 
%                   on screen to show figures

% get monitor screen size(s)
mp = get(0, 'MonitorPositions');
[mno,~] = size(mp);

if ismac
    
    if mno > 1
        p = [1950 50 850 530];
    else
        p = [175 125 850 530];
    end

elseif isunix
    s = get(0,'screensize');
    p = [s(3)/4 s(4)/4 ceil(s(3)/1.5) ceil(s(4)/1.5)];
else
    s = get(0,'screensize');
    p = [524 294 875 606];
end


set(0,'defaultFigurePosition', p);

