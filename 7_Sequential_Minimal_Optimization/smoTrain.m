function [alphas, idx, d] = smoTrain( X, y, K, C, eps, maxIter )

% Input
% -----
%
% X        ... Data points.
%              [ x_11, x_12;
%                x_21, x_22;
%                x_31, x_32;
%                ...              ]
%
% y        ... Class labels.
%              [ s_1; s_2; s_3; ... ]
%
% K        ... Kernel.
%              @(x, y) ...
%
% C        ... SVM hyperparameter.
%
% eps      ... User-defined epsilon.
%
% maxIter  ... Maximum number of iterations.

% Output
% ------
%
% alphas   ... Lagrange multipliers.
%
% idx      ... Indices of non-zero alphas.
%
% d        ... Parameter d.

% STUDENT 1: María de Castro
% STUDENT 2: Belén Chérrez
% STUDENT 3: Christian Grundmann
% STUDENT 4: Ainhoa Xia Fernández

% YOUR IMPLEMENTATION GOES HERE...

[n, ~] = size(X); %define the number of rows of the data matrix

% Construct the kernel matrix
KM = zeros(n);
for i = 1:n
    for j = 1:n
        KM(i, j) = K(X(i, :),X(j, :)); 
    end
end

% Initiallize Parameters
alphas = zeros(n, 1);
d = 0;
numIter = 0;
KKT_met = false;

% Main Loop
while numIter < maxIter && (not(KKT_met)) %why not an OR  

    numIter = numIter + 1;
    KKT_met = true;

    % For Loop
    for i = 1:n
        ai = alphas(i);
        yi = y(i);
        fi = KM(i, :)*(alphas.*y') + d;
        
        % Check KKT conditions and run the SMO algorithm
        if ~(((ai <= eps) && ((yi*fi-1) >= 1)) || ...
                ((ai > eps) && (ai < C-eps) && ((yi*fi-1) == 1)) || ...
                ((ai >= C - eps) && ((yi*fi-1) <= 1)))
            KKT_met = false;
            j = ceil(rand * n);

            % Generate random j, not equal to i
            while (j == i)
                j = ceil(rand * n);
            end

            % Create variables at j
            aj = alphas(j);
            yj = y(j);
            fj = KM(j, :)*(alphas.*y') + d;
            
            % Compute eta using the kernal function
            eta = -KM(i, i) - KM(j, j) + 2*KM(i, j);

            if (eta >= 0)
                continue;
            end
            
            % Calculate L and H
            if (yi == yj)
                L = max(0, ai + aj - C);
                H = min(C, ai + aj);
            else
                L = max(0, aj - ai);
                H = min(C, C + aj - ai);
            end
            

            if (L == H)
                continue;
            end
            
            % Calculate ajNew
            Ei = fi - yi;
            Ej = fj - yj;
            ajNew = aj - (yj * (Ei - Ej))/eta;

            % Calculate ajNewClipped
            if (ajNew >= H)
                ajNewClipped = H;
            elseif ((ajNew > L) && (ajNew < H))
                ajNewClipped = ajNew;
            elseif (ajNew <= L)
                ajNewClipped = L;
            end
            
            % Calculate aiNew
            aiNew = ai + yi*yj*(aj - ajNewClipped);
            
            % Perform clipping and adjust variables within bounds
            aiNewNotAtBounds = false;
            if ((aiNew > 0) && (aiNew < C))
                aiNewNotAtBounds = true;
                d1 = d - Ei - yi * (aiNew - ai)*KM(i, i) + ...
                yj*(ajNewClipped - aj)*KM(i, j);
            end

            ajNewNotAtBounds = false;
            if ((ajNewClipped > 0) && (ajNewClipped < C))

                ajNewNotAtBounds = true;
                d2 = d - Ej - yi*(aiNew - ai)*(KM(i, j) + ...
                    yj*(ajNewClipped - aj)*KM(j, j));
            end

            if (~aiNewNotAtBounds && ~ajNewNotAtBounds)
                d = (d1 + d2)/2;
            elseif (aiNewNotAtBounds)
                d = d1;
            elseif (ajNewNotAtBounds)
                d = d2;
            end

            % Store alphas 
            alphas(i) = aiNew;
            alphas(j) = ajNewClipped;
        end
    end
end

% Indices of alphas, eliminating rounding error
idx = (alphas > 0.00001);

end