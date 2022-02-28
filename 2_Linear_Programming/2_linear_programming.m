%% 2 - Linear programming

clc
clear
close all

%% a) Set up the correct Linear Programming problem. 
% Specify all constraints and the objective function.

% (60 - 35)*xsub1 + (70 - 40)*xsub2 - function to maximize over
% 4*xsub1 + 5*xsub2 <= 40
% xsub1 + xsub2 <= 20
% xsub1 <= 8
% xsub2 <= 5

%% b) Draw the solution polyhedron for the given problem.

x = -1:0.01:21; %stablish a range for x
y1 = (40-4*x)/5; %define each Y inequation as an equation
y2 = 20-x;
y3 = [x(1) x(end)];
x3 = [8 8];
y4 =5 + x*0;
X1 = [0 8 8 15/4 0 0];
X2 = [0 0 1.6 5 5 0];

%target function

figure()
plot(x, y1, 'b', x, y2, 'g', x3,y3, 'k',x,y4,'r','LineWidth', 2); hold on;
pgon = polyshape([0 0 8 8 15/4],[5 0 0 1.6 5]);
plot(pgon)
xlabel('x');
ylabel('y');
set(gca, 'FontSize', 15);
axis equal;
axis([0 14 0 14]);
xticks(0:20)
yticks(0:20)

%% c) Find the optimal solution for the given problem by using the simplex 
% method. Provide your calculations.

A = [4 5 1 0 0 0 40;1 1 0 1 0 0 20; 1 0 0 0 1 0 8; 0 1 0 0 0 1 5; 
    -25 -30 0 0 0 0 0 ];
%entering variable is -30, corresponding to the second column
%We compute b column divided by the column with the entering variable
A(:,7)./A(:,2);
%the departing variable is 5, since it is the smallest positive value
A(4,2) %This is the pivot value

%Gauss-Jordan reducction in the column of the pivot value
A(5,:) = A(5,:)+30*A(4,:);
A(2,:) = A(2,:)-A(4,:);
A(1,:) = A(1,:)-5*A(4,:);

%There is still a negative value in the last row, so this is our new entering variable
 %We compute b column divided by the column with the entering variable
A(:,7)./A(:,1);
%the departing variable is 3.75, since it is the smallest positive value
A(1,1) %This is the new pivot value in this case it is not 1, we have to make it equal to 1
A(1,:) = A(1,:)./4

%Gauss-Jordan reducction in the column of the new pivot value
A(2,:) = A(2,:)-A(1,:);
A(3,:) = A(3,:)-A(1,:);
A(5,:) = A(5,:)+25*A(1,:);

%There is still a negative value in the last row, so -1.25 is our new entering variable
 %We compute b column divided by the column with the entering variable
A(:,7)./A(:,6);
%the departing variable is 3.4, since it is the smallest positive value
A(3,6) %This is the new pivot value in this case it is not 1, we have to make it equal to 1
A(3,:) = A(3,:)./1.25;

%Gauss-Jordan reducction in the column of the new pivot value
A(1,:) = A(1,:)+1.25*A(3,:);
A(2,:) = A(2,:)-0.25*A(3,:);
A(4,:) = A(4,:)-A(3,:);
A(5,:) = A(5,:)+1.25*A(3,:);

%All the values from the last row are now positive. So we compute
%From the final tableau we deduce:
z = 248;
x1 = 8;
x2 = 1.6;
s1 = 0;
s2 = 10.4;
s3 = 0;
s4 = 3.4;
%comprobation
z = 25*8+30*1.6;

%% d) Find the optimal solution for the given problem by using the linprog 
% function in MATLAB. Provide the commented (!) script with the names and 
% student-IDs of all group members in the moodle! 

A = [4 5; 1 1; 1 0; 0 1];
b = [40 20 8 5];
f = [-25 -30];

x = linprog(f,A,b);

%% e) Describe what a Linear Program and what a Feasibility Test is. 
% What is the difference?

% The Linear Feasibility Test determines whether ther is a possible 
% "feasible" solution to a set of conditions. Linear programing takes that
% set of conditions and will maximize along a function vector. The 
% difference between the Linear Feasibility Test and Linear Programming is 
% mainly that the Linear Programming will maximize along a function 
% variable. Both the Linear Feasibility Test and Linear Programming will 
% describe whether there is a solution, making Linear Programing the more 
% useful method.
