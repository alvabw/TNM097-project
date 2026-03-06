function dbReduced = optimizeDatabase(db, K)

N = length(db);

colors = zeros(N,3);

for i = 1:N
    colors(i,:) = db(i).color;
end

[idx, C] = my_kmeans(colors, K, 200);

dbReduced = struct([]);

for k = 1:K

    clusterIdx = find(idx == k);

    if isempty(clusterIdx)
        continue;
    end

    center = C(k,:);

    % find closest image to cluster center
    best = clusterIdx(1);
    bestDist = norm(colors(best,:) - center);

    for j = clusterIdx'
        d = norm(colors(j,:) - center);
        if d < bestDist
            bestDist = d;
            best = j;
        end
    end
    %nånting 
    % ISTÄLLET FÖR: dbReduced = struct([]);
    % GÖR SÅ HÄR:
    dbReduced = db(1); % Kopiera strukturen för att få rätt fält
    dbReduced(:) = []; % Töm den men behåll "mallen"
    
    for k = 1:K
        clusterIdx = find(idx == k);
        if isempty(clusterIdx)
            continue;
        end
    
        center = C(k,:);
    
        % Hitta närmaste färg (vektoriserat för snabbhet!)
        currentColors = colors(clusterIdx, :);
        distances = sum((currentColors - center).^2, 2); 
        [~, minLoc] = min(distances);
        best = clusterIdx(minLoc);
    
        % Nu fungerar detta eftersom dbReduced har samma fält som db
        dbReduced(end+1) = db(best);
    end

end

end
