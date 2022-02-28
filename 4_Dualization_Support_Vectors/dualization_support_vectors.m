%% Dualization and Support Vectors

clc
clear
close all

% Establish range for x
x = -1:0.01:21;

% Constraining inequalities
y1 = (-2*x) + 7;
y3 = [x(1) x(end)];
x3 = [1 1];
x4 = [3 3];
y4 = [x(3) x(end)];
y5 = x + 1;
X1 = [0 8 8 15/4 0 0];
X2 = [0 0 1.6 5 5 0];

% Target Function
figure()
plot(x, y1, 'b', x3, y3, 'g', x4, y4,'r', x, y5, 'k', 'LineWidth', 2); 
hold on;

% Area of possible solution
pgon = polyshape([1 1 3 3 2],[2 0 0 1 3]);
plot(pgon)

% Plot properties
legend('2*x1 + x2 = 7', 'x1 = 1', 'x1 = 3','x1 - x2 = -1');
xlabel('x1');
ylabel('x2');
title('Dualization and Support Vectors')
set(gca, 'FontSize', 15);
axis equal;
axis([0 5 0 5]);
xticks(0:20)
yticks(0:20)

saveas(gcf, 'dualization_support_vectors_1.jpg');
saveas(gcf, 'dualization_support_vectors_1.fig');