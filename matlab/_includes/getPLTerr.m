function [L1,L2,L_inf,t] = getPLTerr(path1,path2,var)
%% get error between two data sets (PLT)
%   INPUT:
%       path1 -- path of dataset 1
%       path2 -- path of dataset 2
%        N - length of phi
%
%   OUTPUT:
%       L1 - normalized
%       L2 - normalized
%       L_inf - normalized
%   
%
% Written By:    SP
% Last Update:   2/13/15

%% main

% load first data set
files1 = dir([path1 '/dataCH*']);
files2 = dir([path2 '/dataCH*']);

% find no of files
nof = length(files1); 

% get number of nodes
 phiN = loadPLT([ path1 '/' files1(1).name ],'nodes');
    
% preallocate space
M = zeros(phiN,nof);
N = zeros(phiN,nof);

L1 = zeros(1,nof);
L2 = zeros(1,nof);
L_inf = zeros(1,nof);

t = zeros(1,nof);

% load data
for i = 1:nof
    
    % load dataset1
    [temp1,t(i)] = loadPLT([ path1 '/' files1(i).name]);
    [temp2,t(i)] = loadPLT([ path2 '/' files2(i).name]);

    M(:,i) = temp1(:,var);
    N(:,i) = temp2(:,var);
end



d = M-N;
for k = 1:nof
    
    L1(k) = norm(d(:,k),1)/norm(N(:,k),1);
    L2(k) = norm(d(:,k),2)/norm(N(:,k),2);
    L_inf(k) = norm(d(:,k),Inf)/norm(N(:,k),Inf);

end
 


end