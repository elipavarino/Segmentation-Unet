function out =  break_image(im, sq_len)
% This function is to decompose an image in to smaller patches. 
% This can serve for 2 principal reasons: (1) a small GPU will not have
% enough memory to train on full-sized images. (2) breaking an image in
% multimple ones will augment the training data.
s = size(im);
num_pieces = s(1)/sq_len;
out = zeros(sq_len,sq_len,num_pieces*num_pieces);

for i = 1:num_pieces
    for j = 1:num_pieces
        out(:,:,(i-1)*num_pieces +j) = im( (i-1)*sq_len +1: i*sq_len, (j-1)*sq_len +1: j*sq_len );       
    end 
end
end