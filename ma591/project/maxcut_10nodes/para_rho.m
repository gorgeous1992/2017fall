%This function is to set parameter rho
% Input: 3-d matrix A
% Output: rho = max_i ||A(:,:,i)||

% function rho = para_rho(A)
% 
% [~, ~, n] = size(A);
% 
% temp = zeros(n,1);
% for i = 1 : n
%     temp(i) = norm(A(:,:,i));
% end
% 
% rho = max(temp);
% 
% end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%(version 2) we set a rho vector.
%%%% each element is the rho value for each constraint

function rho = para_rho(A)

[~, ~, n] = size(A);

temp = zeros(n,1);
for i = 1 : n
    temp(i) = norm(A(:,:,i));
end

rho = temp;

end
    