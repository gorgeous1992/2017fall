%This function is to find index (The smallest) of A_j such that
% A_j X < 0;
%Input: 3-dimensional tensor A and distribution X;
%Output: the smallest index j such that A_j X <0;

function IDX = findexample_matrix(A, X)

% # of inequalities.
n=length(A(1,1,:));

for i = 1 : n
    if trace(A(:,:,i)'*X) < 0
        IDX = i;
        return
    end
end

IDX = -1;
return 


