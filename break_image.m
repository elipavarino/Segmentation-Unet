function out =  break_image(im, sq_len)
s = size(im);
num_pieces = s(1)/sq_len;
out = zeros(sq_len,sq_len,num_pieces*num_pieces);

for i = 1:num_pieces
    for j = 1:num_pieces
 
        out(:,:,(i-1)*num_pieces +j) = im( (i-1)*sq_len +1: i*sq_len, (j-1)*sq_len +1: j*sq_len );
        
    end
    
end



end