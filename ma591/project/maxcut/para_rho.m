%This function is to set parameter rho
% Input: 3-d matrix A
% Output: rho = max_i ||A(:,:,i)||

function rho = para_rho(A)

[~, ~, n] = size(A);

temp = zeros(n,1);
for i = 1 : n
    temp(i) = norm(A(:,:,i));
end

rho = max(temp);

end
    