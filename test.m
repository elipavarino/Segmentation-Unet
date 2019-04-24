I = imread('ac3_dbseg_images/ac3_daniel_s0001.png');
imshow(I)

one_level = squeeze(I(:, :, 3));
for i = 1:size(one_level, 1)
    for j = 1:size(one_level, 2)
        if one_level(i, j)>0
           one_level(i, j) = 255;
        end
    end
end

[~,threshold] = edge(I,'sobel');
fudgeFactor = 0.5;
BWs = edge(one_level,'sobel',threshold * fudgeFactor);