function qualityMetrics(orig, result, name)

    % Se till att båda bilderna är double och i samma storlek
    orig = double(imresize(orig, [size(result,1), size(result,2)]));
    result = double(result);

    % Skala om från [0,1] till [0,255] om nödvändigt
    if max(orig(:)) <= 1.0
        orig = orig * 255;
    end
    if max(result(:)) <= 1.0
        result = result * 255;
    end

    % ------------------
    % MSE
    % ------------------
    mseVal = mean((orig(:) - result(:)).^2);

    % ------------------
    % PSNR
    % ------------------
    max_pixel = 255;
    if mseVal > 0
        psnrVal = 10 * log10((max_pixel^2) / mseVal);
    else
        psnrVal = Inf;
    end

    % ------------------
    % S-CIELAB (ΔE)
    % ------------------
    % Konvertera båda bilderna till LAB
    labOrig = my_rgb2lab(orig / 255);   % ska vara i [0,1]
    labResult = my_rgb2lab(result / 255);

    % Beräkna ΔE för varje pixel
    deltaE = sqrt(sum((labOrig - labResult).^2, 3));

    % Ta medelvärde → S-CIELAB för hela bilden
    scielabVal = mean(deltaE(:));

    % ------------------
    % Skriv ut resultat
    % ------------------
    fprintf("\n--- %s ---\n", name);
    fprintf("MSE:  %.4f\n", mseVal);
    fprintf("PSNR: %.2f dB\n", psnrVal);
    fprintf("S-CIELAB: %.4f\n", scielabVal);

end