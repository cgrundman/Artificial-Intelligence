%% Qual Dual Program with the Kernel function

clc
clear
close all

% Load data.
load('kernel_data.mat');

% Set up kernel.
K = @(x, y) (x*y')^2;

% Call dual QP with kernel.
[alphas, idx] = dqp_kernel( X, y, K );

% Consider only data points corresponding to non-zero alphas.
alphas_idx = alphas(idx);
X_idx = X(idx, :);
y_idx = y(idx);

% Initialize average d_0.
d_0 = 0;

% Initialize G(x) and grid.
x1 = -1:0.002:1;
x2 = -1:0.002:1;
G = zeros(length(x1), length(x2)); 

sum = ones(length(y_idx),1);
for i = 1:length(y_idx)
    for j = 1:length(X_idx)
        sum(i) = sum(i) + alphas_idx(i)*y_idx(i)*K(X_idx(i,:),X_idx(j,:));
    end
    d_0 = d_0 + (1/y_idx(i)) - sum(i);
end

d_0 = d_0/length(sum);
disp(d_0)

% Calculate G(x) on grid
funct =  zeros(length(x1), length(x2));
sum2 =  zeros(length(x1), length(x2));

for i = 1:length(x1)
    for j = 1:length(x2)
        for p = 1:length(X_idx)
            sum2(i,j) = sum2(i,j) + alphas_idx(p)*y_idx(p)*K([x1(i),x2(j)],X_idx(p,:)); %compute the summation
        end            
    funct(i,j) = sum2(i,j) + d_0; 
        %compute the f function with the previous summation
    G(i,j) = sign(funct(i,j)); 
        %returning a -1 if the sign is negative and 1 in the other case
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
legend('+1', '- 1', 'Location', 'NorthEast') 

subplot(1, 2, 2);
surface(x1, x2, G, 'EdgeColor', 'none');
xlabel('x_1', 'FontSize', 14, 'FontWeight', 'bold');
ylabel('x_2', 'FontSize', 14, 'FontWeight', 'bold');
title('Classification results', 'FontSize', 14, 'FontWeight', 'bold');
set(gca, 'FontSize', 14, 'FontWeight', 'bold');
axis equal;
xlim([-1 1]);
ylim([-1.1 1.1]);
ylim([-1 1]);
colormap([0.75 0.75 0.75; 0.25 0.25 0.25]);
colorbar('YTick', [-0.5 0.5], 'YTickLabel', {' - 1', ' +1'}, 'FontSize', 14, 'FontWeight', 'bold');

print('-dpng', 'kernel_function_1.jpg', '-r150');
print('-dpng', 'kernel_function_1.fig', '-r150');