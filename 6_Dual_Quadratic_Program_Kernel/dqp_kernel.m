function [alphas, idx] = dqp_kernel( X, y, K )

% Input
% -----
%
% X        ... Data points and class labels.
%              [ x_11, x_12;
%                x_21, x_22;
%                x_31, x_32;
%                ...              ]
%
% y        ... Class labels.
%              [ s_1, s_2, s_3, ... ]
%
% K        ... Kernel.
%              @(x, y) ...

% Output
% ------
%
% alphas   ... Lagrange multipliers.
%
% idx      ... Indices of non-zero alphas.

[n, ~] = size(X); %define the number of rows of the data matrix

% Determine the kernel matrix
Xnew = zeros(n);
for i = 1:n
    for j = 1:n
        Xnew(i, j) = K(X(i, :), X(j, :));
    end
end

% Generate matrix Q
Q = (y'*y) .* Xnew;

% Gernetate c
c = -ones(n,1);

% Setup A, b, Aeq, and beq
A = []; 
b=[];
Aeq = y;
beq = 0; 

% Setting upper and lower bounds
lb = zeros(n,1);
ub = ones(n,1)*1000;

opts = optimoptions('quadprog', 'Algorithm', 'interior-point-convex', ...
    'Display', 'none');

alphas = quadprog( Q, c, A, b, Aeq, beq, lb, ub, [], opts );
idx = (alphas > 0.00001);

end