function results = MYparalleldemo_backslash_bench(memoryPerWorker, noWorkers)
%% Benchmarking A\b


%% Specify Memory
if nargin == 0
    memoryPerWorker = 0.25; % In GB
    warning('pctexample:backslashbench:BackslashBenchUsingDefaultMemory', ...
            ['Amount of system memory available to each worker is ', ...
             'not specified.  Using the conservative default value ', ...
             'of %.2f gigabytes per worker.'], memoryPerWorker);
end

%% Avoiding Overhead
% To get an accurate measure of our capability to solve linear systems, we
% need to remove any possible source of overhead.  This includes getting
% the current parallel pool and temporarily disabling the deadlock
% detection capabilities.
p = gcp;
if isempty(p)
    error('pctexample:backslashbench:poolClosed', ...
        ['This example requires a parallel pool. ' ...
         'Manually start a pool using the parpool command or set ' ...
         'your parallel preferences to automatically start a pool.']);
end
poolSize = noWorkers;
pctRunOnAll 'mpiSettings(''DeadlockDetection'', ''off'');'



%% The Benchmarking Function
function [A, b] = getData(n)
    fprintf('Creating a matrix of size %d-by-%d.\n', n, n);
    spmd
        % Use the codistributor that usually gives the best performance
        % for solving linear systems.  
        codistr = codistributor2dbc(codistributor2dbc.defaultLabGrid, ...
                                    codistributor2dbc.defaultBlockSize, ...
                                    'col');
        A = codistributed.rand(n, n, codistr);
        b = codistributed.rand(n, 1, codistr);
    end
end

function time = timeSolve(A, b)
    spmd
        tic;
        x = A\b; %#ok<NASGU> We don't need the value of x.
        time = gop(@max, toc); % Time for all to complete.
    end
    time = time{1};
end

%% Choosing Problem Size

% Declare the matrix sizes ranging from 1000-by-1000 up to 45% of system
% memory available to each worker.

maxMemUsagePerWorker = 0.45*memoryPerWorker*1024^3; % In bytes.
maxMatSize = round(sqrt(maxMemUsagePerWorker*poolSize/8));
matSize = round(linspace(1000, maxMatSize, 2));

%%
% Given a matrix size, the benchmarking function creates the matrix |A| and
% the right-hand side |b| once, and then solves |A\b| multiple times to get
% an accurate measure of the time it takes.  We use the floating operations
% count of the HPC Challenge, so that for an n-by-n matrix, we count the
% floating point operations as |2/3*n^3 + 3/2*n^2|.
function [gflops,time] = benchFcn(n)
    numReps = 3;
    [A, b] = getData(n);
    time = inf;
    % We solve the linear system a few times and calculate the Gigaflops 
    % based on the best time.
    for itr = 1:numReps
        tcurr = timeSolve(A, b);
        if itr == 1
            fprintf('Execution times: %f', tcurr);
        else
            fprintf(', %f', tcurr);
        end
        time = min(tcurr, time);
    end
    fprintf('\n');
    flop = 2/3*n^3 + 3/2*n^2;
    gflops = flop/time/1e9;
end

%% Executing the Benchmarks
% Having done all the setup, it is straightforward to execute the
% benchmarks.  However, the computations may take a long time to complete,
% so we print some intermediate status information as we complete the
% benchmarking for each matrix size.
fprintf(['Starting benchmarks with %d different matrix sizes ranging\n' ...
         'from %d-by-%d to %d-by-%d.\n'], ...
        length(matSize), matSize(1), matSize(1), matSize(end), ...
        matSize(end));
gflops = zeros(size(matSize));
time = zeros(size(matSize));
for i = 1:length(matSize)
    [gflops(i),time(i)] = benchFcn(matSize(i));
    fprintf('Gigaflops: %f\n\n', gflops(i));
end
results.matSize = matSize;
results.gflops = gflops;
results.time = time;

%% Plotting the Performance
% We can now plot the results, and compare to the expected graph shown
% above.
% fig = figure;
% ax = axes('parent', fig);
% plot(ax, matSize/1000, gflops);
% lines = ax.Children;
% lines.Marker = '+';
% ylabel(ax, 'Gigaflops')
% xlabel(ax, 'Matrix size in thousands')
% titleStr = sprintf(['Solving A\\b for different matrix sizes on ' ...
%                     '%d workers'], poolSize);
% title(ax, titleStr, 'Interpreter', 'none');
% 

%% Re-enabling the Deadlock Detection
% Now that we have concluded our benchmarking, we can safely re-enable the
% deadlock detection in the current parallel pool.
pctRunOnAll 'mpiSettings(''DeadlockDetection'', ''on'');'
end
