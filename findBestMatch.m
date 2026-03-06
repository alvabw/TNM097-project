

function idx = findBestMatch(targetColor, colorList)

diff = colorList - targetColor;
distSq = sum(diff.^2, 2);

[~, idx] = min(distSq);

end
