% This function is to implement interior method through Primal affince
% scaling algorithm
% Input:  1. c, A and b are given in the problem; 2. alpha is the step length
% parameter needed; 3. epsilon is the tolerance for stopping; 4. x is the
% starting point;
% Output: 1. solu_x is the iterating solution; 2. itnum is the number of
% iterations; 3. obj is the objective value for last step.

function [solu_x, itnum, obj] = PrimalAffineScaling(x, c, A, b, alpha, epsilon)

%record dimension
n = length(x);

%check starting point x is feasible
if A*x ~= b
    fprintf('x^0 not feasible\n');
    return
end

%Initialize X, w, r
X = diag(x);
w = (A*X*X*A')\A*X*X*c;
r = c - A'*w;

k = 0;
while (ones(1, n)*X*r > epsilon || all(r >=0) == 0)
  %compute d_y^k
  d_y = -X*r
  if all(d_y >0) == 1
      fprintf('\nThis problem is unbounded.\n');
      break
  else if all(d_y == 0) == 1
          break
      end
  end
  
  %compute alpha_k
  temp = d_y(find(d_y < 0));
  al = min(alpha./(-temp))
  %update x_k+1
  x = x + al*X*d_y  
  
  %number of iteration
  k = k + 1;
  
  %Compute X_k
  X = diag(x);
  %Compute w_k
  w = (A*X*X*A')\A*X*X*c;
  %compute r_k
  r = c - A'*w;
  pause
end

solu_x = x;
itnum = k;
obj = c'*solu_x;

  
  
     