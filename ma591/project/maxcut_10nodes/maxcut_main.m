%%%This is the main file of code for the project of class MA591
%%%Matrix Multiplicated Weights Algorithm for MAX CUT Problem

clc
clear all

% %% Generate one toy example with m = 4
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% L = cell2mat(struct2cell(load('L_toyExample.mat')));
%  trace(L*[1 -1 1 -1; -1 1 -1 1; 1 -1 1 -1; -1 1 -1 1])
% 
% optvalue = 16;
% [~,m] = size(L);
% n = m+1;
% A = MAXCUT_A(m, optvalue, L)
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%% Generate one big example with file L_toyExample_10nodes.mat
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
L = cell2mat(struct2cell(load('L_toyExample_10nodes.mat')));

optvalue = 80;
[~,m] = size(L);
n = m+1;
A = MAXCUT_A(m, optvalue, L);
% %Rescale the last inequality
% A(:,:,m+1) = (m+1)/trace(A(:,:,m+1))*A(:,:,m+1);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% %%%%%%%%%%%%%%%%%%%%%%%%%%

%% Set parameters:
rho = 1*para_rho(A);


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%% ita (version 1)
%epsilon = 0.1;
%ita = epsilon/(2*rho);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%% ita (version 2)
epsilon = [1e-1, 1e-02, 1e-03, 1e-04];
ita = [-log(1-epsilon(1)),  -log(1-epsilon(2)), -log(1-epsilon(3)), -log(1-epsilon(4))];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%epsi is the epsilon that for solving large-margin problem
epsi = [0.1, 1e-02, 1e-3, 1e-04];


%Initialize density matrix
X = 1/m*eye(m);

%Run Matrix MW algorithm for epsi(1) to converges fast
[Solu, T] = Matrix_MW(L, A, X, rho, ita(4), epsi(4));
% %Run again Matrix MW algorithm with solu from last run for epsi(2) to converges precisely
% [Solu, T2] = Matrix_MW(L, A, temp_Solu, rho, ita(2), epsi(2));


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
Solu = m*Solu
Solu_value = 0.25*trace(L*Solu)

%% Compare # of rounds with theoretical upper bound of rounds
fprintf('\nTotal number of rounds:\n')
total_rounds = T;
%upbd_rounds = 4*(max(rho))^2*log(n)/epsilon^2;
%fprintf('Total: %d\nUpperbound: %f\n', T, upbd_rounds);
fprintf('Total: %d\n', T);


%% Compare the generated answer and best cut
fprintf('\nThe ptimal value = %f \n Our optimal value = %f\n', optvalue, Solu_value);

%% Difference of Solution matrix and X_opt in norm
X_opt = cell2mat(struct2cell(load('Xopt_toyExample_10nodes.mat')));
err_X = norm(Solu - X_opt);
fprintf('\n err_X = %f\n err_b = %f\n', err_X, norm(Solu_value - optvalue));
fprintf('\n Relative err_X = %f\n', err_X/norm(X_opt));
fprintf('\n Rank (X) = %d\n', rank(Solu));