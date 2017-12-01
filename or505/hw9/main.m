clear all
clc

%%%Problem 1
A = [1 2 -1;
     1 1  1];
b = [1; 1];
c = [2, 1, 3]';

%Initialize parameters and starting point
x0_a = [0.25, 0.5, 0.25]';

alpha = 0.99;
epsilon = 0.1;

%Use primal affine scaling algorithm
[solu, itnum, obj] = PrimalAffineScaling(x0_a, c, A, b, alpha, epsilon)
