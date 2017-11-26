% Matrix Multiplicated Weights function (Gain version)
% for sovling specific SDP.

% Input: X:    Initial Distribution Matrix  (m by m)
%        rho:  max_i ||A_i||             (real number)
%        epsilon:  relaxation of large-margin solution   (real number)
%        ita: epsilon/(2*rho), parameter for updating weights (real number)
%        A:    Coefficient 3-d Matrix (m by m by n)
%        L: Laplacian matrix

% Output: Good solution, # of rounds, total gain, best gain
function [Solu, T] = Matrix_MW(L, A, X, rho, ita, epsi)

%record # of example n and the matrix size m.
[m, ~, n] = size(A);

%check feasibility
IDX = findexample_matrix(A, X, epsi);


%Initialize sum. 
%sum_M: sum of cost matrix from beginning to current round.
sum_M = zeros(m);

T=0;
while IDX>0
    %Obeserve gain matrix
    M = 1/rho * A(:,:,IDX);
    sum_M = sum_M + M;
    
    %update date distribution matrix
    W = expm(ita*sum_M);
    X = 1/trace(W)*W;
    %Print 1/4 * L*X at each iteration
    objvalue = trace(L*X)
    
    
    %Count # of rounds
    T = T + 1;
    
    %check feasibility
    %continue loop if IDX >0, otherwise stop
    IDX = findexample_matrix(A, X, epsi);
end

Solu = X;
end






