clc;
clear all;
display('Hello! This is the Power System Project')

% methods used - OLS, PLS, BLR
% Further steps:

% 1. Implement ann model
% 2. equiproportionate dist. -> Normal dist.
% 3. Shuffle data -> recompute error
% 4. Plotting error vs. data ratio curves
% 5. Conversion of outlier angle into a range of -90 to 90 degree


ref = [5]
pq = [1,2,3,4,6]
pv = [7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30]

for i = 1:num_load 
	P = data.P;
% Doubt: Why ref bus -> P=0?
	P(:, ref) = zeros;
	PQ_va = [P data.Q ones(size(data.V, 1), 1)];
	[b,~,~,~,~] = regress(data.Va(:, i) * pi / 180, PQ_va);
	Xva(i, :) = b';
	[b,~,~,~,~] = regress(data.V(:, i), PQ_va);
	Xv(i, :) = b';
end
Xpf = [];
Xqf = [];