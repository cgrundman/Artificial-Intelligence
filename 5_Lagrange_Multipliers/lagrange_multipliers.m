%% Lagrange Multipliers

clc
clear 
close all

%% Mesh visualizaiton of Lagrange multipliers in optimization
 
% Initialize mesh
x = (-3.25:0.01:3.25);
y = (-3.25:0.01:3.25);
z = meshgrid(x,y);

f = zeros(size(z));
g = -x + 1.5;

for i =1:length(x) 
    for j = 1:length(y)
        f(i,j) = -x(i)^2 - 2*y(j)^2 + 7.5;
    end
end
 
figure()
contour(x, y, f, 1:10, 'Linewidth', 2); hold on;
plot(x , g, 'k', 'Linewidth', 2);
plot(0.5, 1, 'k*');

text(-0.1, -0.8, 'c = 7', 'FontSize', 14, 'FontWeight', 'bold');
text(-0.1, -1.3, 'c = 6', 'FontSize', 14, 'FontWeight', 'bold');
text(-0.1, -1.65, 'c = 5', 'FontSize', 14, 'FontWeight', 'bold');
text(-0.1, -1.93, 'c = 4', 'FontSize', 14, 'FontWeight', 'bold');
text(-0.1, -2.175, 'c = 3', 'FontSize', 14, 'FontWeight', 'bold');
text(-0.1, -2.41, 'c = 2', 'FontSize', 14, 'FontWeight', 'bold');
text(-0.1, -2.65, 'c = 1', 'FontSize', 14, 'FontWeight', 'bold');
hold off;

xlabel('x_1', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('x_2', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([-3.25 3.25])
ylim([-3.25 3.25])

title('Representation of f and g')
legend('f(x_1,x_2)','g(x_1,x_2)')
 
ax = gca;
ax.FontSize = 10; 

saveas(gcf, 'lagrange_multipliers_mesh.jpg');
saveas(gcf, 'lagrange_multipliers_mesh.fig');

%% Seperation planes with Lagrange multipliers in optimization

if (exist('output.txt', 'file'))
    delete('output.txt');
end

diary('output.txt');

% Test instance #1
X = [1 1; 0 1; 2 2; 1 2];
y = [1 -1 1 -1];

[exitflag, w, d, margin, dists, alphas, sv] = maxMarg_lagrange( X, y );

disp('Test instance #1.');
disp('-----------------');
if (exitflag ~= 1)
    disp('No solution found.');
    disp(' ');
else
    disp('Weight vector w = ');
    disp(w);
    disp('Distance d = ');
    disp(d);
    disp('Margin = ');
    disp(margin);
    disp('Distances = ');
    disp(dists);
    disp('Lagrange multipliers = ');
    disp(alphas);
    disp('Support vectors = ');
    disp(sv);
end

figure(1);
set(gcf, 'Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.9]);
plot(X([1 3], 1), X([1 3], 2), 'b.', 'MarkerSize', 23); hold on; 
plot(X([2 4], 1), X([2 4], 2), 'r.', 'MarkerSize', 23);
if (exitflag ~= 1)
    text(3, 3, 'No solution found.', 'FontSize', 16, 'FontWeight', 'bold');
else
    x1 = -0.25:0.01:5.25;
    x2 = -w(1)/w(2) * x1 - d/w(2);
    plot(x1, x2, 'k', 'LineWidth', 2);
end
xlabel('x_1', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('x_2', 'FontSize', 14, 'FontWeight', 'bold');
title('Test instance #1', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([-0.25 5.25]);
ylim([-0.25 5.25]);
grid on;

saveas(gcf, 'lagrange_multipliers_1.jpg');
saveas(gcf, 'lagrange_multipliers_1.fig');

% Test instance #2
X = [0 1; 1 1; 2 2; 1 2];
y = [1 -1 1 -1];

[exitflag, w, d, margin, dists, alphas, sv] = maxMarg_lagrange( X, y );

disp('Test instance #2.');
disp('-----------------');
if (exitflag ~= 1)
    disp('No solution found.');
    disp(' ');
else
    disp('Weight vector w = ');
    disp(w);
    disp('Distance d = ');
    disp(d);
    disp('Margin = ');
    disp(margin);
    disp('Distances = ');
    disp(dists);
    disp('Lagrange multipliers = ');
    disp(alphas);
    disp('Support vectors = ');
    disp(sv);
end

figure(2);
set(gcf, 'Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.9]);
plot(X([1 3], 1), X([1 3], 2), 'b.', 'MarkerSize', 23); hold on;
plot(X([2 4], 1), X([2 4], 2), 'r.', 'MarkerSize', 23);
if (exitflag ~= 1)
    text(3, 3, 'No solution found.', 'FontSize', 16, 'FontWeight', 'bold');
else
    x1 = -0.25:0.01:5.25;
    x2 = -w(1)/w(2) * x1 - d/w(2);
    plot(x1, x2, 'k', 'LineWidth', 2);
end
hold off;
xlabel('x_1', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('x_2', 'FontSize', 14, 'FontWeight', 'bold');
title('Test instance #2', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([-0.25 5.25]);
ylim([-0.25 5.25]);
grid on;

saveas(gcf, 'lagrange_multipliers_2.jpg');
saveas(gcf, 'lagrange_multipliers_2.fig');

% Test instance #3
X = [1 1; 0 1; 2 2; 1 2.5];
y = [1 -1 1 -1];

[exitflag, w, d, margin, dists, alphas, sv] = maxMarg_lagrange( X, y );

disp('Test instance #3.');
disp('-----------------');
if (exitflag ~= 1)
    disp('No solution found.');
    disp(' ');
else
    disp('Weight vector w = ');
    disp(w);
    disp('Distance d = ');
    disp(d);
    disp('Margin = ');
    disp(margin);
    disp('Distances = ');
    disp(dists);
    disp('Lagrange multipliers = ');
    disp(alphas);
    disp('Support vectors = ');
    disp(sv);
end

figure(3);
set(gcf, 'Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.9]);
plot(X([1 3], 1), X([1 3], 2), 'b.', 'MarkerSize', 23); hold on; 
plot(X([2 4], 1), X([2 4], 2), 'r.', 'MarkerSize', 23);
if (exitflag ~= 1)
    text(3, 3, 'No solution found.', 'FontSize', 16, 'FontWeight', 'bold');
else
    x1 = -0.25:0.01:5.25;
    x2 = -w(1)/w(2) * x1 - d/w(2);
    plot(x1, x2, 'k', 'LineWidth', 2);
end
xlabel('x_1', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('x_2', 'FontSize', 14, 'FontWeight', 'bold');
title('Test instance #3', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([-0.25 5.25]);
ylim([-0.25 5.25]);
grid on;

saveas(gcf, 'lagrange_multipliers_3.jpg');
saveas(gcf, 'lagrange_multipliers_3.fig');

diary off; 