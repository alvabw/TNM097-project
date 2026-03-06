clc;
clear;
close all;

%% PARAMETERS
%tileSize = 2;  %32;             % size of each mosaic tile
maxImageSize = 256;          % max original size. ska vara tilesize i kvadrat 
dbFolder = 'blocks2';   


%% READ ORIGINAL IMAGE
orig = imread('original5.jpg'); %lägg till en egen bild 

%orig = im2double(orig);

orig = resizeImage(orig, maxImageSize);
imshow(orig);

%% LOAD DATABASE
db = loadDatabase(dbFolder, 16);

%% CREATE MOSAIC WITH FULL DATABASE
sampleSize = 2;   % sampling size av bilden. denna måste ändras baserat på varje bild 
result_full = createMosaic(orig, db, sampleSize);

%% OPTIMIZE DATABASE (100 images)
db100 = optimizeDatabase(db, 100);
result_100 = createMosaic(orig, db100, sampleSize);

%% OPTIMIZE DATABASE (50 images)
db50 = optimizeDatabase(db, 50);
result_50 = createMosaic(orig, db50, sampleSize);
%%  OPTIMIZE BY SPECIFIC IMAGE 
db50_image = optimizeDatabaseForImage(orig, db, sampleSize, 50);
result_image50 = createMosaic(orig, db50_image, sampleSize);

%% SHOW RESULTS
figure(1)
imshow(orig); title('Original');
figure(2) 
imshow(result_full); title('Full DB');
figure(3)
imshow(result_100); title('100 images');
figure(4)
imshow(result_50); title('50 images');
figure(5)
imshow(result_image50); title('images optimized (50)');

%% QUALITY METRICS
fprintf("\nQUALITY METRICS\n");

qualityMetrics(orig, result_full, "Full DB");
qualityMetrics(orig, result_100, "100 images");
qualityMetrics(orig, result_50, "50 images");
qualityMetrics(orig, result_image50, "optimized 50 images");
