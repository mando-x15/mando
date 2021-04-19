clear; close all;

% get no of runs
fl = dir('args*');
nof = length(fl);

% extract arg number
args = zeros(1,nof);
for j = 1:nof
    no = str2double(fl(j).name(5:end));
    args(j) = no;
end

[args,ind] = sort(args);
dat = zeros(5,nof);

% collect data (in order)
for k = 1:nof
    filename = [fl(ind(k)).name '/runtime.txt'];
    tmp = load(filename);
    dat(:,k) = tmp(:,2);
end

% sort data
v = dat(5,:);
[~,ind] = sort(v);
dat = dat(:,ind);

[m,n] = size(dat);
v = [1,2,4,6,8];

%% plot sorted data

%set plot length
len_max = nof;
len = nof;

ind_short = ind(1:len);
leg = cellstr(num2str(ind_short', '%-d'));

% my plot fcn - change length of legend
matplot(v,dat,leg);

ylim([20 180])
legend('Location','northeast')
title('Arguments testing');xlabel('Processes, n');ylabel('time, (s)');








