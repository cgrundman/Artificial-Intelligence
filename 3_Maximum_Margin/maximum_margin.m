%% 4 - Maximum Margin

clc
clear
close all

if (exist('output.txt', 'file'))
    delete('output.txt');
end

diary('output.txt');

% Test instance #1.
X = [3 1; 2 1; 5 2; 3 2];
y = [1 -1 1 -1];

[exitflag, w, d, margin, dists] = maxMarg( X, y );

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
end

figure(1);
set(gcf, 'Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.9]);
plot(X(y ==  1, 1), X(y ==  1, 2), 'b.', 'MarkerSize', 23); hold on;
plot(X(y == -1, 1), X(y == -1, 2), 'r.', 'MarkerSize', 23);
if (exitflag ~= 1)
    text(3, 3, 'No solution found.', 'FontSize', 16, 'FontWeight', 'bold');
else
    x1 = -1.25:0.01:7.25;
    x2 = -w(1)/w(2) * x1 - d/w(2);
    plot(x1, x2, 'k', 'LineWidth', 2);
end
hold off;
xlabel('x_1', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('x_2', 'FontSize', 14, 'FontWeight', 'bold');
title('Test instance #1', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([-1.25 7.25]);
ylim([-1.25 7.25]);
grid on;

saveas(gcf, 'maximum_margin_1.jpg');
saveas(gcf, 'maximum_margin_1.fig');

% ------------------------------------------------------------------------
% Test instance #2.
X = [3 1; 2 1; 5 2; 3 2];
y = [1 -1 -1 1];

[exitflag, w, d, margin, dists] = maxMarg( X, y );

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
end

figure(2);
set(gcf, 'Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.9]);
plot(X(y ==  1, 1), X(y ==  1, 2), 'b.', 'MarkerSize', 23); hold on;
plot(X(y == -1, 1), X(y == -1, 2), 'r.', 'MarkerSize', 23);
if (exitflag ~= 1)
    text(3, 3, 'No solution found.', 'FontSize', 16, 'FontWeight', 'bold');
else
    x1 = -1.25:0.01:7.25;
    x2 = -w(1)/w(2) * x1 - d/w(2);
    plot(x1, x2, 'k', 'LineWidth', 2);
end
hold off;
xlabel('x_1', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('x_2', 'FontSize', 14, 'FontWeight', 'bold');
title('Test instance #2', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([-1.25 7.25]);
ylim([-1.25 7.25]);
grid on;

saveas(gcf, 'maximum_margin_2.jpg');
saveas(gcf, 'maximum_margin_2.fig');

diary off;