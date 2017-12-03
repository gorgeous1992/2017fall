% This function is to implement interior method through Dual affince
% scaling algorithm
% Input:  1. c, A and b are given in the problem; 2. alpha is the step length
% parameter needed; 3. epsilon is the tolerance for stopping; 4. x is the
% starting point;
% Output: 1. solu_x is the iterating solution; 2. itnum is the number of
% iterations; 3. obj is the objective value for last step.

function [solu_w, solu_s, itnum, obj] = DualAffineScaling(w, s, c, A, b, alpha, epsilon)

%record dimension
m = length(w);

%check starting point w0, s0 is feasible

if (isequal(A'*w + s, c) == 0 || all(s > 0) == 0)
    fprintf('w^0, s^0 are not feasible.\n');
    return
end

%Initialize S, d_w, d_s, x
S = diag(s)
d_w = (A*((S*S)\A'))\b
d_s = -A'*d_w
x = -(S*S)\d_s

k = 0;
while (c'*x - b'*w > epsilon || all(x >=0) == 0)
  %check d_s
  if all(d_s >0) == 1
      fprintf('\nPrimal problem is unbounded.\n');
      break
  else if all(d_s == 0) == 1
          break
      end
  end
  
  %compute beta_k
  tempindex = find(d_s < 0);
  beta = min(alpha*s(tempindex)./(-d_s(tempindex)))
  %update w_k+1, s_k+1
  w = w + beta*d_w
  s = s + beta*d_s
  %number of iteration
  k = k + 1;
  
  %Compute S_k
  S = diag(s);
  %Compute d_w, d_s
  d_w = (A*((S*S)\A'))\b
  d_s = -A'*d_w
  %Compute x_k
  x = -(S*S)\d_s;
  pause
end

solu_w = w;
solu_s = s;
itnum = k;
obj = b'*solu_w;

  
  
     