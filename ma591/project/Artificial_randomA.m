%This function is to genterate 3-d matrix A(m by m by n) artificially.
% Each matrix A(:,:,i) is symmetric and m by m.
% Input: dimension parameters m and n. 
%        X_opt is one feasible solution to the problem.
% Output: 3-d matrix A

function A = Artificial_randomA(m,n,X_opt)
%Initialize A as a m by m by n zeros.
A = zeros(m, m, n);
for j = 1 : n
    % M is just a temporary variable matrix
    % element of M is random number in [-10, 10]
    M = 20*rand(m)-10*ones(m);
    % Make M a symmetrical matrix.
    M = 0.5 * (M + M');
    
   %Check if M satisfies all example.
   if trace(M*X_opt) >=0
       A(:, :, j) = M;
   else
       A(:, :, j) = -M;
   end
end
end