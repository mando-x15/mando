function [varargout] = loadPLT(filename,varargin)
% LOADPLT Loads a Tecplot PLT file
%   Returns a VECTOR of (x, y, phi) data
%
% General Context:
%   [data] = loadPLT('dataCH_h_curr_0.60');
%
% Input:
%       filename : Filename to load (if empty or not found then a dialog will be presented)
%
% Output:
%       dat:    nodal data (x, y, phi vectors)
%       t:      time stamp
%       N:      Nodes (vector, nx, ny, nz)
%       vars:   string of variables in PLT (x, y, phi ..)
%       E:      return elemental connectivity data
%       NTotal: return total number of nodes
%
% Examples:
%
%   [dat] = loadPLT(filename)                  // general case
%   [dat,t,N,vars] = loadPLT(filename)         // return all
%   [~,~,~,vars] = loadPLT(filename)           // return only var data
%
%
%   t = loadPLT(filename,'time')                // only time
%   N = loadPLT(filename,'TotalNodes')          // only # of nodes
%   E = loadPLT(filename,'connectivity')        // return only elemental
%                                                   connectivity
%
%   L = loadPLT(filename,'L')                   // return only Lx, Ly, Lz
%   N = loadPLT(filename,'N')                   // return only Nx, Ny, Nz
%
%%
% Written By:    SP
% Last Update:   2/27/15
%
%% SETUP

% is filename a char
if (~ischar(filename))
    error('input file is not of type char, check name');
end

% get filename if doesnt exist
if (~exist('filename','var') || ~exist(filename,'file'))
    [filename, pathname] = uigetfile('*.plt', 'Select File');
    filename = [pathname filename];
end

% defaults
getTime = false;
getNodes = false;
getEle = false;
getL = false;
getN = false;
if nargin >= 2
    for ii = 1:length(varargin)
        switch(lower(varargin{ii}))
            case('time')                  % return only t
                getTime = true;
            case('totalnodes')            % return only N
                getNodes = true;
            case('connectivity')          % return only elemental data
                getEle = true;
            case('l')                     % return only Lx, Ly, Lx vec
                getL = true;
            case('n')                     % return only Nx, Ny, Nz vec
                getN = true;
            otherwise
                error([mfilename ':input'],'Unknown Option %s',varargin{ii});
        end
    end
end


%% LOAD PLT
fileID = fopen( filename);

%% Get all header info

% Get time (title)
ll = fgetl(fileID);         % title line
res = regexp(ll,'TITLE *= *"(?<title>.*)"', 'names');
t = str2double(res(1).title(3:end));

% get number of variables
ll = fgetl(fileID);         % variables line
res = regexp(ll, '(?<=")[^"]+(?=")', 'match');

c = zeros(1,length(res));
for i = 1:length(res)
    c(i) = any(isletter(res{i}));
end
vars = res(logical(c));
nvars = sum(c);


% find no of dimensions
d=0;
for i=1:length(vars)
    
    v = vars{i};
    
    if  strcmp(v,'x') || strcmp(v,'y') || strcmp(v,'z')
        d = d+1;
    end
end

% get number of Nodes
ll = fgetl(fileID);         % nodes line
res = regexp(ll,'ZONE +N=(?<N>[^"]+), E=(?<E>[^"]+), ET=(?<ET>[^"]+)', 'names');

if isempty(res)
    res = regexp(ll,'ZONE +I=(?<I>[^"]+), ZONETYPE=Ordered, DATAPACKING=POINT', 'names');
    N = str2double(res(1).I);
else
    N = str2double(res(1).N);
end

% close open file
fclose(fileID);

% IF return only t or N, end function
if (getTime),  varargout{1} = t; return; end
if (getNodes), varargout{1} = N; return; end
    

%% Read body of PLT file, skipping header

% read first N lines - excluding headerlines
fileID = fopen(filename);
format = repmat('%f ', [1 nvars]);

%get elemental connectivity, otherwise nodal data
if (getEle)
    
    if d == 1
        warning('1D: no connectivity'); 
        dat = 0;
    else
        format = repmat('%f ', [1 4]);
        C = textscan(fileID,format, N,'Headerlines',N+3);
        dat = cell2mat(C);
    end
else
    C = textscan(fileID, format, N,'Headerlines',3);
    dat = cell2mat(C);
end

% close open file
fclose(fileID);


% get L
if (getL)
    
    if d == 1
        Lvec(1) = max(dat(:,1));
    elseif d == 2
        Lvec(1) = max(dat(:,1));
        Lvec(2) = max(dat(:,2));
    else
        Lvec(1) = max(dat(:,1));
        Lvec(2) = max(dat(:,2));
        Lvec(3) = max(dat(:,3));     
    end
    varargout{1} = Lvec;
    return;
end

% get N
if (getN)
    
    if d == 1
        Nvec(1) = length(dat(:,1));
    elseif d == 2
        Nvec(1) = length(find(not(dat(:,2))));
        Nvec(2) = length(find(not(dat(:,1))));
    else
        Nvec(1) = length(unique(dat(:,1),'sorted'));
        Nvec(2) = length(unique(dat(:,2),'sorted'));
        Nvec(3) = length(unique(dat(:,3),'sorted'));
    end
    varargout{1} = Nvec;
    return;
end

varargout{1} = dat;
varargout{2} = t;
varargout{3} = N;
varargout{4} = vars;






end



