function [idx, C] = my_kmeans(X, K, maxIter)
    % X: Matris (N x 3) med färger
    % K: Antal kluster (20)
    % maxIter: Max antal iterationer
    
    % 1. Initiera centerpunkter slumpmässigt från befintliga färger
    n = size(X, 1);
    randIdx = randperm(n, K);
    C = X(randIdx, :);
    
    for i = 1:maxIter
        % 2. Beräkna avstånd från varje punkt till varje center
        % (Använder implicit broadcasting/repmat-logik)
        dist = sum(X.^2, 2) - 2 * (X * C') + sum(C.^2, 2)';
        
        % 3. Tilldela varje punkt till närmaste center
        [~, idx] = min(dist, [], 2);
        
        % 4. Uppdatera centerpunkter (medelvärdet av klustret)
        oldC = C;
        for k = 1:K
            pointsInCluster = X(idx == k, :);
            if ~isempty(pointsInCluster)
                C(k, :) = mean(pointsInCluster, 1);
            end
        end
        
        % Avbryt om centren inte flyttar sig längre
        if isequal(C, oldC), break; end
    end
end