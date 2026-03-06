function out = resizeImage(im, maxSize)

[h,w,~] = size(im);

if max(h,w) > maxSize
    scale = maxSize / max(h,w);
    out = imresize(im, scale);
    fprintf("Image resized down\n");

elseif max(h,w) < maxSize/2
    out = imresize(im, 2);
    warning("Image was small and enlarged — quality may decrease");

else
    out = im;
end

end
