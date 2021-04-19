%function [t, m] = bench_lu(n)
n=5000;
stream = RandStream('mt19937ar');
A = randn(stream,n,n);
m = memcheck;
tic
B = lu(A);  %#ok<NASGU>
t = toc;
%end