%%%This is the main file of code for the project of class MA591
%%%Matrix Multiplicated Weights Algorithm for MAX CUT Problem
clc
clear all

%% Generate one toy example with m = 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = cell2mat(struct2cell(load('L_toyExample.mat')));
 trace(L*[1 -1 1 -1; -1 1 -1 1; 1 -1 1 -1; -1 1 -1 1])

optvalue = 16;
[~,m] = size(L);
n = m+1;
A = MAXCUT_A(m, optvalue, L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set parameters:
rho = para_rho(A);
epsilon = 0.01;
ita = epsilon/(2*rho);
%ita = 1/3;

%Initialize density matrix
X = 1/m*eye(m);

%Run Matrix MW algorithm
[Solu, T, gain, bestgain, lbd_gain] = Matrix_MW(A, X, rho, epsilon, ita);

%% Print the solution
fprintf('\nSolution:\n')
Solu = 4*Solu
Solu_cut = 0.25*trace(L*Solu)

%% verify feasibility of Solution
feas = zeros(n,1);
for i = 1:n
    feas(i) = trace(A(:,:,i)*Solu);
end
fprintf('Feasible?\n')
if feas>=0
    fprintf('--Yes--\n')
else 
    fprintf('No\n')
    pause;  
end

%% Compare # of rounds with theoretical upper bound of rounds
fprintf('\nTotal number of rounds:\n')
total_rounds = T;
upbd_rounds = 4*rho^2*log(n)/epsilon^2;
fprintf('Total: %d\nUpperbound: %f\n', T, upbd_rounds);

%% Compare the total gain with best gain
fprintf('\nCompare the total cost with best cost and upperbound cost:\n')

bestgain
gain
lbd_gain
gain_gap = abs(gain - bestgain)
