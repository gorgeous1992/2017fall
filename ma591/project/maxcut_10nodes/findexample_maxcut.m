%This function is to find index (The smallest) of A_j such that
% A_j X < 0;
%Input: 3-dimensional tensor A and distribution X;
%       epsi: Large-Margin coefficient
%Output: the smallest index j such that A_j X <0;

function IDX = findexample_maxcut(A, X, epsi)

% # of inequalities.
n = length(A(1,1,:));

% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i = 1 : n 
%      trace(A(:,:,i)'*X)
%     if abs(trace(A(:,:,i)'*X)) > epsi
%        continue
%     else IDX = i
%         return
%     end
% end
% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i = 1 : n
    
    if trace(A(:,:,i)'*X) < -epsi
       IDX = i
       ooo = trace(A(:,:,i)'*X)
        return
    end
end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

IDX = -1
pause
return 