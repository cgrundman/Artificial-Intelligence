function [exitflag, w, d, margin, dists, alphas, sv] = ...
    maxMarg_lagrange( X, y )

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
%              [ s_1; s_2; s_3; ... ]

% Output
% ------
%
% exitflag ... Exitflag of quadprog. %hecho
%
% w        ... Weight vector. %hecho
%
% d        ... Bias of Separating Plane. %hecho
%
% margin   ... Margin.%hecho
%
% dists    ... Distances of each data point to the separating plane.%hecho
%
% alphas   ... Lagrange multipliers.
%
% sv       ... Indices of support vectors.

[n, ~] = size(X); % define the number of rows of the data matrix

Q = (y' * y) .* (X * X');

c = -ones(n, 1);

A = [];
b = [];

Aeq = y;
beq = 0;

lb = zeros(n, 1);

opts = optimoptions('quadprog', 'Algorithm', 'interior-point-convex', ...
    'Display', 'off');

[alphas, ~, exitflag] = quadprog(Q, c, A, b, Aeq, beq, lb, [], [], opts);

ww = (alphas' .* y) * X;
w = ww/norm(ww);
d = -1/2 * (min(w * X(y == 1, :)') + max(w * X(y == -1, :)'));
margin = 1/norm(ww);
dists = abs(w * X' +d);
sv = find((dists - margin) < 1e-9);

% A = [];
% for i = 1:n
%     A = [A; y(i)*X(i,:) y(i)]; 
%     %construct the matrix A from X and Y values following the constraint
% end
% 
% A = -A; %change the sign of A in order to minimize the f function
% 
% b = -1*ones(n,1); %construct the b matrix
% 
% H = eye(3); %construct the objective quadratic term
% 
% H(end,end) = 0;
% 
% f = [0;0;0];%construct the objective lineal term
% [result, fval, exitflag, output, alpha] = quadprog(H,f,A,b); 
%     %computes the minimum of the objective
% 
% %function in quadratic programming
% d = result(end); 
%     %last value of the vector obtained with quadratic programming 
%     % corresponds to the distance
% w = result(1:end-1); 
%     %the other values of the vector obtained, correspond to the weights
% margin = 1/norm(w); 
%     %obtain the margin value
%     
% dists=[];
% for i = 1:n
%     dists=[dists, (abs(w'*X(i,:)'+d))*margin]; %compute the distances from each data point to the separating plane
% end
% alphas = getfield(alpha,'ineqlin'); %extract just the linear inequalities alphas field from alpha struct array obtained in quadprog
% 
% sv=[];
% for i = 1:length(alphas) 
%     p = round(alphas(i),4); %we round the alpha values to 4 decimals
%     if p == 0 %check if the alpha is equal to 0
%         sv = sv; %if alpha is 0, the sv vector doesn't change
%     else
%         sv = [sv,i]; %if alpha is different than 0 we update the sv vector with the position of that alpha
%     end
% end

end
      