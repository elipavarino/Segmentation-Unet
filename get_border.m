function BW = get_border(x)

I_s = unique_rgb(x);

BW = imdilate(I_s,ones(5,5)) ~= imerode(I_s,ones(5,5));
%[~, threshold] = edge(I_s, 'sobel');
%BW = edge(I_s, 'sobel', 'nothinning', threshold*0.001);
end