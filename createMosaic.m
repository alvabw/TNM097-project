

function result = createMosaic(orig, db, sampleSize)

tileSize = 16; %alla bilder i db är 16x16, typ

[h,w,~] = size(orig);
h = floor(h/sampleSize)*sampleSize;
w = floor(w/sampleSize)*sampleSize;
orig = orig(1:h,1:w,:);

resultH = h/sampleSize * tileSize;
resultW = w/sampleSize * tileSize;

result = cast(zeros(resultH, resultW, 3), class(db(1).img));

orig = im2double(orig);
labOrig = my_rgb2lab(orig);

dbLabColors = reshape([db.color],3,[])';

for y = 1:sampleSize:h
    for x = 1:sampleSize:w

        block = labOrig(y:y+sampleSize-1, x:x+sampleSize-1, :);
        meanColorLab = reshape(mean(mean(block,1),2),1,3);

        idx = findBestMatch(meanColorLab, dbLabColors);

        ry = (y-1)/sampleSize * tileSize + 1;
        rx = (x-1)/sampleSize * tileSize + 1;

        result(ry:ry+tileSize-1, rx:rx+tileSize-1, :) = db(idx).img;

    end
end
end