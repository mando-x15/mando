function [ time, C ] = fcn_max( filename )
energy = importdata(filename);

%skip first line
energy=energy(2:end,:);
int = energy(:,4);

% find max
[C,I] = max(int);
time = energy(I,1);


SP = fopen('tmp.txt', 'w');

fprintf(SP, '%.20f \t', time)
fprintf(SP, '%.20f', C)
fclose(SP);

end
