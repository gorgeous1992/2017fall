% Matrix Multiplicated Weights function
% for sovling specific SDP.

% Input: X:    Initial Distribution Matrix  (m by m)
%        rho:  max_i ||A_i||             (real number)
%        epsilon:  relaxation of large-margin solution   (real number)
%        ita: epsilon/(2*rho), parameter for updating weights (real number)
%        A:    Coefficient 3-d Matrix (m by m by n)

% Output: Good solution 
function Solu = Matrix_MW(A, X, rho, epsilon, ita)

%record # of example n and the matrix size m.
[m, ~, n] = size(A);

%check feasibility
IDX = findexample_matrix(A, X);

%Initialize sum. 
%sum: sum of gain matrix from beginning to current round.
sum_M = zeros(m);

while IDX>0
    %Obeserve gain matrix
    M = 1/rho * A(:,:,IDX);
    sum_M = sum_M + M;
    %update date distribution matrix
    X = expm(-ita*sum_M);
    %check feasibility
    %continue loop if IDX >0, otherwise stop
    IDX = findexample_matrix(A, X);
end






