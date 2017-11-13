%%%This is the main file of code for the project of class MA591
%%%Matrix Multiplicated Weights Algorithm for SDP

%Generate one toy example with m = 3, n = 10;
clc
clear all

m = 10;
n = 100;

%Generate optimal density matrix X_opt
X_opt = Artificial_randomX_opt(m);
%Generate 3-d matrix A
A = Artificial_randomA(m, n, X_opt);

% %% Hand calculating example
% 
% A(:,:,1) = [-2 0 ; 0 1];
% A(:,:,2) = [-2 1 ; 2 2];
% A(:,:,3) = [-1 0 ; 1 2];
% 
% v = [1/3; 2*sqrt(2)/3];
% X_opt = v*v';
% 
% 
% A
% X_opt
% 


% Set parameters:
rho = para_rho(A);
epsilon = 1e-1;
ita = epsilon/(2*rho);
%ita = 1/3;

%Initialize density matrix
X = 1/m*eye(m);

%Run Matrix MW algorithm
[Solu, T, cost, bestcost, upbd_cost] = Matrix_MW(A, X, rho, epsilon, ita);

%% Print the solution
fprintf('\nSolution:\n')
Solu

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
cost
bestcost = 0
upbd_cost
cost_gap = abs(cost - bestcost)