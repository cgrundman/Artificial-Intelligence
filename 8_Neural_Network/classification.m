function [y] = classification( X, g, g_bias, h, h_bias )
% Input
% -----
%
% X                 ... Data point.
%                       [ x_1, x_2, x_3]
%
% g,h               ... weigths of layers.
%                       [ w_11, w_12, w_13, 
%                         w_21, w_22   ... ]
%
% g_bias, h_bias    ... bias of layers.
%                       [ b_1, b_2, ... ]

% Output
% ------
%
% y                 ... Network output.
%

f =@(x) 1./(1+exp(-x));

layer1 = f(X * g + g_bias);
layer2 = f(layer1 * h + h_bias);

y = round(layer2);

% %reweite the g and h weights and biases to make them double
% g = double(g);
% h = double(h);
% g_bias = double(g_bias);
% h_bias = double(h_bias);
% 
% Xrow = length(X); %obtain X length
% gcolumn = length(g); %obtain g length
% hidden = zeros(Xrow,gcolumn); %initialize the hidden vector
% 
% for j = 1:gcolumn
%     %prepare the first thresholding comparision
%     hidden(:,j) = ((X(:,1) * g(1,j) +(X(:,2) * g(2,j) )) + g_bias(j)); 
%     %compute the 4 nodes of the hidden layer
% end
% 
% % evaluate the result of each node of the hidden layer and output a 1 or a
% % 0 with the sigmoid activation function
% [n,m] = size(hidden);
% f1 = zeros(n,m);
% for i2 = 1:n
%     for j2 =1:m
%         if 1/(1+exp(-hidden(i2,j2))) >= 0.5 %sigmoid activation funciton
%             f1(i2,j2) = 1;
%         else
%             f1(i2,j2) = 0;
%         end
%     end
% end
% 
% % compute the other layer to obtain the final output
% [frow,fcolumn] = size(f1);
% output = zeros(frow,fcolumn); % initialize the output vector
% for p = 1:frow
%     for b= 1:fcolumn
%         % prepare the second thresholding comparision
%         output = output + f1(:,b)*h(b); 
%     end
% end
% finaloutput = output+h_bias;
% 
% y = zeros(length(finaloutput),1); % inizialize y vector
% 
% % evaluate the output obtained before with the sigmoid function
% for k = 1:length(finaloutput)
%     if 1/(1+exp(-finaloutput(k))) >= 0.5
%         y(k) = 1;
%     else
%         y(k) =0;
%     end
% end

end






