function BW = get_border(x)
%function to get the borders from the labelled images. There are 2 methods
%that can be used here: Either using the gradient of the image and filters
%such as the Sobel, or using the morphological operations of dilation and
%erosion
I_s = unique_rgb(x);

% by changing the size of the ones(), the borders will be fatter or slimmer
BW = imdilate(I_s,ones(5,5)) ~= imerode(I_s,ones(5,5));   
%[~, threshold] = edge(I_s, 'sobel');
%BW = edge(I_s, 'sobel', 'nothinning', threshold*0.001);
end