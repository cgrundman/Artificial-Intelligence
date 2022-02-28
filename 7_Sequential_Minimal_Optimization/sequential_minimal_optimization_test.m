%% Sequential Minimal Optimiization

clc
clear
close all

% Load data.
load('smo.mat');

% Set up parameters.
C = 1000;
eps = 0.001;
maxIter = 1000;

% Set up kernel.
K = @(x, y) (x*y')^2;

% Call SMO SVM with kernel.
[alphas, idx, d] = smoTrain(X, y, K, C, eps, maxIter);

% Consider only data points corresponding to non-zero alphas.
alphas_idx = alphas(idx);
X_idx = X(idx, :);
y_idx = y(idx);

% Initialize G(x) and grid.
x1 = -1:0.002:1;
x2 = -1:0.002:1;
G = zeros(length(x1), length(x2));

% Calculate G(x) on grid.
for i = 1:length(x1)
    for j = 1:length(x2)
        G(i, j) = d;
        for k = 1:numel(alphas_idx)
            G(i, j) = G(i, j) + alphas_idx(k) * y_idx(k) * K([x1(i) x2(j)], X_idx(k, :));    
        end
        G(i, j) = sign(G(i, j));
    end
end

% Plot given data and classification results.
figure(1);
set(gcf, 'Units', 'normalized', 'OuterPosition', [0.05 0.05 0.9 0.9]);
set(gcf, 'PaperOrientation', 'landscape');
set(gcf, 'PaperUnits', 'centimeters', 'PaperPosition', [0 0 29.7 21]);
set(gcf, 'PaperSize', [29.7 21.0]);

subplot(1, 2, 1);
plot(X(y ==  1, 1), X(y ==  1, 2), 'k+', 'MarkerSize', 15); hold on;
plot(X(y == -1, 1), X(y == -1, 2), 'kx', 'MarkerSize', 15);
xlabel('x_1', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('x_2', 'FontSize', 14, 'FontWeight', 'bold');
title('Given data', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([-1.1 1.1]);
ylim([-1.1 1.1]);
legend('+1', '- 1', 'Location', 'NorthEast') 

subplot(1, 2, 2);
surface(x1, x2, G', 'EdgeColor', 'none');
xlabel('x_1', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('x_2', 'FontSize', 14, 'FontWeight', 'bold');
title('Classification results', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([-1 1]);
ylim([-1 1]);
colormap([0.75 0.75 0.75; 0.25 0.25 0.25]);
colorbar('YTick', [-0.5 0.5], 'YTickLabel', {' - 1', ' +1'}, 'FontSize', 14, 'FontWeight', 'bold');

saveas(gcf, 'sequential_minimal_optimization_1.jpg');
saveas(gcf, 'sequential_minimal_optimization_1.fig');