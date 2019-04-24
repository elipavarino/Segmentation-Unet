function out = unique_rgb(in)

out = double(in(:,:,3))*1000000 +...
    double(in(:,:,2))*1000 + double(in(:,:,1));


end