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

%% Generate one big example with file L_pw05_100_0.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = cell2mat(struct2cell(load('L_pw05_100_0.mat')));

optvalue = NaN;
[~,m] = size(L);
n = m+1;
A = MAXCUT_A(m, optvalue, L)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set parameters:
rho = para_rho(A);
epsilon = 0.01;
ita = epsilon/(2*rho);
%epsi is the epsilon that for solving large-margin problem
epsi = 1e-4;
%ita = 1/3;

%Initialize density matrix
X = 1/m*eye(m);

%Run Matrix MW algorithm
[Solu, T, gain, bestgain, lbd_gain] = Matrix_MW(A, X, rho, epsilon, ita);



%% verify feasibility of Solution
feas = zeros(n,1);
for i = 1:n
    feas(i) = trace(A(:,:,i)*Solu);
end
fprintf('Feasible?\n')
if feas >= -epsi
    fprintf('--Yes--\n feasibility vector \n')
    feas
else 
    fprintf('No\n')
    feas
    pause;  
end

%% Print the solution
fprintf('\nSolution:\n')
Solu = 4*Solu
Solu_value = 0.25*trace(L*Solu)

%% Compare # of rounds with theoretical upper bound of rounds
fprintf('\nTotal number of rounds:\n')
total_rounds = T;
upbd_rounds = 4*rho^2*log(n)/epsilon^2;
fprintf('Total: %d\nUpperbound: %f\n', T, upbd_rounds);

%% Compare the generated answer and best cut
fprintf('\nThe ptimal value = %f \n Our optimal value = %f\n', optvalue, Solu_value);

