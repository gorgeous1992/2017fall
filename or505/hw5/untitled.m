clc
clear all
A = [-2 1 1 1 1 ; -1 2 0 1 -1 ; 1 -3 1 0 4];
b = [12; 5; 11];
B = A(:, 3:5)
N = A(:, 1:2)

M = [B, N ; zeros(size(N')), eye(2)]

%inverse of M 
inv(M)
-inv(B)*N
%Gauss elimination(Reduced row echelon form)
R = rref([B, N, -[12;5;11]])

%Problem (e)
%B^-1 A and B^-1b

Ans_e1 = B\A
Ans_e2 = B\b

%Problem (g)-(i) 
%For d^1,
tilde_B = [A(:, 3:4), A(:, 1)];
tilde_N = [A(:, 5), A(:, 2)];
tilde_M = [tilde_B, tilde_N; zeros(size(tilde_N')), eye(2)]

inv(tilde_M)

%For d^2,
bar_B = [A(:, 4:5), A(:, 2)];
bar_N = [A(:, 3), A(:, 1)];
bar_M = [bar_B, bar_N; zeros(size(bar_N')), eye(2)]
inv(bar_M)

%problem (j)
R_1 = rref([tilde_B, tilde_N, -b])
R_2 = rref([bar_B, bar_N, -b])


