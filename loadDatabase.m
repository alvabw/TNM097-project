function db = loadDatabase(folder, tileSize)

files = dir(fullfile(folder,'*.png'));

if isempty(files)
    error("No images found in database folder");
end

for i = 1:length(files)

    img = imread(fullfile(folder, files(i).name));

        % Om gråskala, gör till RGB
    if size(img,3) == 1
        img = repmat(img,[1 1 3]);
    end
    
    % ta bort alpha kanal om det finns
    if size(img,3) == 4
        img = img(:,:,1:3);
    end

    img = im2double(imresize(img,[tileSize tileSize]));

    lab = my_rgb2lab(img);

    meanColor = squeeze(mean(mean(lab,1),2));

    db(i).img = img;
    db(i).color = meanColor;

end

end

