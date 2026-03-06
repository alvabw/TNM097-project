function dbReduced = optimizeDatabaseForImage(orig, db, sampleSize, K)

orig = im2double(orig);
labOrig = my_rgb2lab(orig);

[h,w,~] = size(labOrig);

% samla färger från originalbilden
colors = [];

for y = 1:sampleSize:h-sampleSize+1
    for x = 1:sampleSize:w-sampleSize+1

        block = labOrig(y:y+sampleSize-1, x:x+sampleSize-1, :);
        meanColor = reshape(mean(mean(block,1),2),1,3);

        colors(end+1,:) = meanColor;

    end
end

% hitta K viktiga färger i bilden
[idx, C] = my_kmeans(colors, K, 200);

% samla databasens färger
N = length(db);
dbColors = zeros(N,3);

for i = 1:N
    dbColors(i,:) = db(i).color;
end

% skapa reducerad databas
dbReduced = db(1);
dbReduced(:) = [];

for k = 1:K

    center = C(k,:);

    distances = sum((dbColors - center).^2, 2);
    [~, best] = min(distances);

    dbReduced(end+1) = db(best);

end

end