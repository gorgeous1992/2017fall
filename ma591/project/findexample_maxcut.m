%This function is to find index (The smallest) of A_j such that
% A_j X < 0;
%Input: 3-dimensional tensor A and distribution X;
%Output: the smallest index j such that A_j X <0;

function IDX = findexample_maxcut(A, X)

% # of inequalities.
n = length(A(1,1,:));
epsi = 1e-06;

for i = 1 : n 
     trace(A(:,:,i)'*X)
    if abs(trace(A(:,:,i)'*X)) > epsi
       continue
    else IDX = i
        return
    end
end

IDX = -1
pause
return 