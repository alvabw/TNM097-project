function lab = my_rgb2lab(img)
    % Normalisera och linjärisera RGB (sRGB till linjär)
    img = double(img) / 255;
    idx = img > 0.04045;
    img(idx) = ((img(idx) + 0.055) / 1.055).^2.4;
    img(~idx) = img(~idx) / 12.92;

    % RGB till XYZ (D65 illuminant)
    T = [0.4124, 0.3576, 0.1805; ...
         0.2126, 0.7152, 0.0722; ...
         0.0193, 0.1192, 0.9505];
    
    [h, w, ~] = size(img);
    rgb_flat = reshape(img, [], 3);
    xyz = rgb_flat * T';

    % XYZ till LAB
    white = [0.95047, 1.00000, 1.08883]; % D65
    xyz = bsxfun(@rdivide, xyz, white);
    
    idx = xyz > 0.008856;
    f_xyz = xyz;
    f_xyz(idx) = xyz(idx).^(1/3);
    f_xyz(~idx) = 7.787 * xyz(~idx) + 16/116;

    L = 116 * f_xyz(:,2) - 16;
    a = 500 * (f_xyz(:,1) - f_xyz(:,2));
    b = 200 * (f_xyz(:,2) - f_xyz(:,3));
    
    lab = reshape([L, a, b], h, w, 3);
end