function [freemem,memsize] = checkmem()
[~,w] = unix('free | grep Mem');
stats = str2double(regexp(w, '[0-9]*', 'match'));
memsize = stats(1)/1e6;  % return in MB
freemem = (stats(3)+stats(end))/1e6;
end
