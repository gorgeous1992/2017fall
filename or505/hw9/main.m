clear all
clc

%%%Problem 1(a)
A = [1 2 -1;
     1 1  1];
b = [1; 1];
c = [2, 1, 3]';

%Initialize parameters and starting point
x0_a = [0.25, 0.5, 0.25]';

alpha = 0.99;
epsilon = 0.1;  

%Use primal affine scaling algorithm
fprintf('Primal affine scaling algorithm: \n')
[solu, itnum, obj] = PrimalAffineScaling(x0_a, c, A, b, alpha, epsilon)

%%%Problem 1(b)

%Initialize dual starting point
w0 = zeros(2  , 1);
s0 = c;
%Use primal affine scaling algorithm
fprintf('Dual affine scaling algorithm: \n')
[solu_w, solu_s, itnum, obj] = DualAffineScaling(w0, s0, c, A, b, alpha, epsilon)


