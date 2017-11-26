%This function is to genterate matrix A for max cut problem
% A max cut problem in SDP form generally is
%    MAX  1/4*L \dot X
%    s.t.  X_ii = 1
%          X psd (m by m)
% (with optimal value b)===>
%      m/4b * L\dot X - 1 >= 0
% m(e_ie_i^T)\dot X -1 >= 0  \forall i = 1,...,m

%Input: m: dimension of X. # of constraints is n = m+1;
%       b: optimal value b 
%       L: Laplacian matrix
%Output: A is a m by m by m+1 3-d matrix.

function A = MAXCUT_A(m, b, L)

A = zeros(m,m,m+1);
for i = 1 : m
    temp = -eye(m);
    temp(i,i) = temp(i,i) + m;
    A(:,:,i) = temp;
end

A(:,:,m+1) = m/(4*b)*L - eye(m);
%rescale A_{m+1}
A(:,:,m+1) = (m-1)/norm(A(:,:,m+1))*A(:,:,m+1);

end
    

        