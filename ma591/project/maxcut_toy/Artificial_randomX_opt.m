%This function is to generate one density matrix X = vv' artificially
%v satisfies its sum of all elements is 1.
% Input: dimension m
% Output: density matrix


function X_opt = Artificial_randomX_opt(m)

%v satisfies its sum of all elements is 1.
v = rand(m,1);
Sum = sum(v);
v = 1/Sum*v;

X_opt = v*v';
end