%% 1 - Nearest Neighbor Classification

clc
clear
close all

%% Task 1: Matlab Introduction (10 points)
% Prepare a MATLAB script called myIntroduction and perform the following tasks:
% a) Create the vectors a, b ∈ R 1×5 with uniformly distributed random
% numbers.

a = rand(1,5);
b = rand(1,5);

%b) Multiply the vectors a and b to get c ∈ R and A ∈ R 5×5. Transpose the 
% vectors if necessary.

c = a*b';
A = a'*b;

%c) Perform element-wise multiplication with a and b to get vector 
% e ∈ R 1×5

e = a.*b;

%d) Extract the elements at locations (1,2) and (2,3) from A

element1=A(1,2);
element2=A(2,3);

%e) Extract and concatenate the elements in the upper and lower rows from 
% A.

firstrow= A(1,:);
lastrow =A(5,:);
concatenate = cat(1,firstrow,lastrow); 
        %we don't know if you mean concatenation with 1 or 2 dimensions

%f) Set every value < 0.5 in A to 0 using logical indexing.

[Ax,Ay] = size(A);
    %Ax = number of rows
    %Ay = number of columns

Amod = zeros(Ax,Ay);

for i=1:Ax
    for j=1:Ay
        Amod(i,j) = A(i,j) * (A(i,j) >  0.5);
        %valuematrixB = valuematrixA * 1 value matrixA is >0.5 
        %or
        %valuematrixB = valuematrixA * 0 if value matrixA is not >0.5 
    end
end

Amod2 = A - (A).*(A < 0.5);
 
%g) Create a matrix B ∈ R 3×3 using magic().

B = magic(3);

%h) Solve Bx = f with f = (1, 2, 3)T

f = [1 2 3]';
x = linsolve(B,f);

%i) Compute the eigenvalues of B

eigenvalues = eig(B);

%% Task 2 Nearest Neighbor (10 Points)

% Add the following tasks to your MATLAB script myIntroduction.
% You received the following training data labeled with the classes 0 or 1:

x1 = [2 2 2 3 3 4 4 5 7 7 8 9];
x2 = [5 6 8 4 6 5 9 9 7 9 8 7];
y = [0 0 0 0 0 0 1 1 1 1 1 1];

% You want to classify new datapoints U using nearest neighbor 
% classification.
% a) Import the data into your matlab script and visualize it in a scatter 
% plot. Mark the classes in different colors, name the axes and prepare a 
% legend with 'class 0' and 'class 1'. (Hint: use doc gscatter )

ax1 = gscatter(x1, x2, y, "rb", "_+", 12, "on", "x1", "x2");
title('Nearest Neighbor Problem')
legend("class 0", "class 1")
axis([0 10 0 10])

% b) Create the function [ v, pred ] = bruteForce( X, Y, U ) and implement 
% a brute force algorithm to classify U using a for-loop. The function 
% returns the distance vector v that contains all distances between U and 
% dataset X and the nal classication pred. Use the function to classify 
% the datapoints U1 = (4; 7) and U2 = (7; 5).

X = cat(1, x1, x2);
Y = y;
U1 = [4 7];
U2 = [7 5];
bruteForce(X, Y, U1)
bruteForce(X, Y, U2)

% c) Use the MATLAB function knnsearch() to perform a nearest neighbor 
% classification of the datapoints U1 and U2 using a kd-tree.

tic
class = knnsearch([x1' x2'], [U1; U2]);
class_U1 = Y(class(1));
class_U2 = Y(class(2));
toc

% d) What is the benefit of the kd-tree based approach in contrast to a 
% brute-Force approach in Nearest Neighbor classification? 
% (Hint: You can answer this question in a comment in your MATLAB script.)

% The Brute force method requires you to input one new data point at a
% time, where the KD-tre aproach classifies an entire dataset at once.

%% Function Section

function [ v, pred ] = bruteForce( X, Y, U )
tic
x1 = X(1,:); % Extracting first row of X
x2 = X(2,:); % Extracting second row of X
len = length(x1);
for i = 1:len
    v(i) = sqrt(abs((U(1) - x1(i))^2 + (U(2) - x2(i))^2));
% % v = distance vector contains distances from U to all X points
% % pred = is U X or Y type
end
[~, pos] = min(v);
pred = Y(pos);
toc
end

