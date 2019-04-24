function out = unique_rgb(in)
% This function brings all the 3 channels on one single layout (the labels are mostly blue, but some are also green). 
out = double(in(:,:,3))*1000000 +...
    double(in(:,:,2))*1000 + double(in(:,:,1));
end