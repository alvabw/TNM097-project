function qualityMetrics(orig, result, name)

    % Se till att båda bilderna är samma storlek
     orig = im2double(imresize(orig, [size(result,1), size(result,2)]));
     result = im2double(result);


    % MSE
    % ------------------
    mseVal = mean((orig(:) - result(:)).^2);

    % ------------------
    % SSIM
    % ------------------
    % SSIM kräver värden mellan 0–1;
    % Enkel SSIM (Structural Similarity) 
    % En förenklad version som mäter korrelation (likhet i struktur) 
    c = corrcoef(orig(:), result(:)); 
    ssimVal = c(1,2); % Ger ett värde mellan -1 och 1 (närmare 1 är bättre)

    
    % S-CIELAB
    % ------------------
    labOrig = my_rgb2lab(orig);
    labResult = my_rgb2lab(result);

    deltaE = sqrt(sum((labOrig - labResult).^2,3));
    scielabVal = mean(deltaE(:));

    % Print results
    fprintf("\n--- %s ---\n", name);
    fprintf("MSE: %.4f\n", mseVal);
    fprintf("SSIM: %.4f\n", ssimVal);
    fprintf("S-CIELAB: %.4f\n", scielabVal);

end
