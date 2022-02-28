function [exitflag, w, d, margin, dists] = maxMarg( X, y )
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
% exitflag ... Exitflag of quadprog.
%
% w        ... Weight vector.
%
% d        ... Distance from the origin.
%
% margin   ... Margin.
%
% dists    ... Distances of each data point to the separating plane.

% Define the number of rows of the data matrix
[n, m] = size(X);

% Initialize variables for quadratic programming
Q = eye(m+1);
Q(end, end) = 0;

c = zeros(m+1, 1);

A = [X ones(n, 1)];
indPos = (y == 1);
A(indPos, :) = -A(indPos, :);

b = -ones(n, 1);

opts = optimoptions('quadprog', 'Algorithm', 'interior-point-convex', ...
    'Display', 'off');

% Calculate the minimum with the quadprog function
[x, ~, exitflag] = quadprog(Q, c, A, b, [], [], [], [], [], opts);

% Function in quadratic programming
ww = x(1:m);
w = ww/norm(ww);
% Last value of vector obtained with quadprog corresponds to the distance
d = x(end)/norm(ww); 
% Obtain the margin value
margin = 1/norm(ww); 
dists = abs(X * w + d);

end