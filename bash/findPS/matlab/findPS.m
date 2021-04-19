function [ psx ] = findPS( filename )

% load energy file
energy = importdata(filename);

% isolate t=0.1 --> t=1
[row,col] = find(0.1 < energy(:,1) & energy(:,1) < 1.0);

E = energy(row(:),:);
clear row col

% set x & y vars
x = E(:,1);
y = E(:,4);

% reduce x & y
xn=x(1:2:end);
yn=y(1:2:end);

% calculate derivative
dy=diff(yn)./diff(xn);

% plots
%figure
%semilogx(xn,yn);

%figure
%semilogx(xn(2:end),dy,'k')


% find the energy max, remove following values, set to datax
[mv mr] = max(yn);
[row,col] = find( xn(:) > xn(mr));

datax = xn;
datay = yn;

datax(row) = [];
datay(row) = [];

clear row col mr mv

% find min of derivative, remove previous data
[dmv dmr] = max(dy);
[row,col] = find( xn(:) < xn(dmr));

datax(row) = [];
datay(row) = [];

% figure
% semilogx(datax,datay,'k')

% of remaining data, find median
[v_max,r_max] = max(datax);
[v_min,r_min] = min(datax);
avg = (v_max + v_min)/2;

[C, I] = find(datax >= avg);

% output final point of phase separation
psx=datax(C(1));
psy=datay(C(1));

out = [ psx psy ];
SP = fopen('tmp.txt', 'w');

fprintf(SP, '%.5f ', out)

fclose(SP);

end
