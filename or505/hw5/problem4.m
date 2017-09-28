clc
clear all

A = [2*eye(3), eye(3)];
%step3
B = [A(:, [2,6,1])];
N = [A(:, [5, 3, 4])];

M = [B, N; zeros(size(N')), eye(3)]
inv(M)
inv(B)*N

