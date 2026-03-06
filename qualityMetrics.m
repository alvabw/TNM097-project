function qualityMetrics(orig, result, name)
    % Se till att båda bilderna är double och i samma storlek
    orig = double(imresize(orig, [size(result,1), size(result,2)]));
    result = double(result);

    % Mean Squared Error
    % Vi normaliserar till [0, 1] om de är i 0-255 format för snyggare siffror
    mseVal = mean((orig(:) - result(:)).^2);

    % PSNR (Peak Signal-to-Noise Ratio)
    % Formel: 10 * log10( MAX^2 / MSE )
    max_pixel = 255; 
    if mseVal > 0
        psnrVal = 10 * log10((max_pixel^2) / mseVal);
    else
        psnrVal = Inf;
    end

    %  Enkel SSIM (Structural Similarity)
    % En förenklad version som mäter korrelation (likhet i struktur)
    c = corrcoef(orig(:), result(:));
    ssimVal = c(1,2); % Ger ett värde mellan -1 och 1 (närmare 1 är bättre)

    fprintf("\n--- %s ---\n", name);
    fprintf("MSE:  %.4f\n", mseVal);
    fprintf("PSNR: %.2f dB\n", psnrVal);
    fprintf("Likhet (Korr): %.4f\n", ssimVal);
end