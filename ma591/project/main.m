%%%This is the main file of code for the project of class MA591
%%%Matrix Multiplicated Weights Algorithm for SDP

%Generate one toy example with m = 3, n = 10;
clc
clear all

m = 2;
n = 3;

%Generate optimal density matrix X_opt
X_opt = Artificial_randomX_opt(m);
%Generate 3-d matrix A
A = Artificial_randomA(m, n, X_opt);

% Set parameters:
rho = para_rho(A);
epsilon = 1e-1;
%ita = epsilon/(2*rho);
ita = 1/3;

%Initialize density matrix
X = 1/m*eye(m);



%Run Matrix MW algorithm
Solu = Matrix_MW(A, X, rho, epsilon, ita);


X_opt
Solu
norm(Solu - X_opt, 'fro')