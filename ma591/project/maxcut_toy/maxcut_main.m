%%%This is the main file of code for the project of class MA591
%%%Matrix Multiplicated Weights Algorithm for MAX CUT Problem

clc
clear all

%% Generate one toy example with m = 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = cell2mat(struct2cell(load('L_toyExample.mat')));
X_opt = [1 -1 1 -1; -1 1 -1 1; 1 -1 1 -1; -1 1 -1 1];

optvalue = 16;
[~,m] = size(L);
n = m+1;
A = MAXCUT_A(m, optvalue, L);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% Set parameters:
rho = para_rho(A);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%% ita(version 1)
%ita = epsilon/(2*rho);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ita (version 2)
%epsilon = 9.1*1e-03;
epsilon = [1e-1, 1e-02, 1e-03, 1e-04];
ita = [-log(1-epsilon(1)),  -log(1-epsilon(2)), -log(1-epsilon(3)), -log(1-epsilon(4))];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%epsi is the epsilon that for solving large-margin problem
epsi = [0.1, 1e-02, 1e-3, 1e-04];




%Initialize density matrix
X = 1/m*eye(m);

%Run Matrix MW algorithm
[Solu, T] = Matrix_MW(L, A, X, rho, ita(1), epsi(1));



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
%upbd_rounds = 4*rho^2*log(n)/epsilon^2;
%fprintf('Total: %d\nUpperbound: %f\n', T, upbd_rounds);
fprintf('\nTotal rounds = %d\n', T);
%% Compare the generated answer and best cut
fprintf('\nThe ptimal value = %f \n Our optimal value = %f\n', optvalue, Solu_value);

fprintf('\n err_X = %f\n err_b = %f \n', norm(X_opt - Solu), norm(optvalue - Solu_value));
fprintf('\n Relative err_X = %f\n', norm(X_opt - Solu)/norm(X_opt));
fprintf('\n Rank (X) = %d\n', rank(Solu));