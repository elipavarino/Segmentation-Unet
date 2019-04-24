% Code to create datasets.

labelDir = "ac3_dbseg_images";
targetDir = "ac3_dbseg_images_bw";
prefix = 'ac3_daniel_s';
r1=1;r2=256;

% labelDir = "ac4_seg_daniel";
% targetDir = "ac4_seg_daniel_bw";
% prefix = 'ac4_daniel_s';
% r1=1;r2=100;

% there was a problem for the name of the files, whereby the labels
% comenced with an order in the EM stack, and the reverse numeration in the
% label images. Thus, the following code is an excamotage to ovviate this
% problem.
for i = r1:r2
    s = num2str(i*1e-4, '%1.4f');
    s = s(3:end);
    s_f = strcat(prefix,s);
    filename = strcat(labelDir,'/',s_f, '.png');
    
    importfile(filename)

    s = r2 - str2num(s);
    
    s = num2str(s*1e-4, '%1.4f');
    s = s(3:end);
%     


    out = evalin('base', strcat('get_border(',s_f,')'));
    s_f = strcat(prefix,s);
%     disp(s)
    filename = strcat(targetDir,'/',s_f, '.png');
    imwrite(out,filename);
    
    clear(s_f)
end
%%

labelDir = "ac3_dbseg_images_bw";
targetDir = "ac3_dbseg_images_bw_patch";
prefix = 'ac3_daniel_s';
r1=0;r2=255;

% labelDir = "ac4_seg_daniel_bw";
% targetDir = "ac4_seg_daniel_bw_patch";
% prefix = 'ac4_daniel_s';
% r1=0;r2=99;


for i = r1:r2
    s = num2str(i*1e-4, '%1.4f');
    s = s(3:end);
    s_f = strcat(prefix,s);
    filename = strcat(labelDir,'/',s_f, '.png');
    
    importfile(filename)



    out = evalin('base', strcat('break_image(',s_f,',256)'));
    for i = 1: size(out,3)
        filename = strcat(targetDir,'/',s_f,'_',int2str(i), '.png');
        imwrite(out(:,:,i),filename);
    end
    clear(s_f)
end


%%

labelDir = "ac3_EM";
targetDir = "ac3_EM_patch";
prefix = 'Thousand_highmag_256slices_2kcenter_1k_inv_';
r1=0;r2=255;

% labelDir = "ac4_EM";
% targetDir = "ac4_EM_patch";
% prefix = 'affinecropped4_inv_';
% r1=1;r2=100;

for i = r1:r2
    s = num2str(i*1e-4, '%1.4f');
    s = s(3:end);
    s_f = strcat(prefix,s);
    filename = strcat(labelDir,'/',s_f, '.png');
    
    importfile(filename)



    out = evalin('base', strcat('break_image(',s_f,',256)'));
    out = uint8(out);
    for i = 1: size(out,3)
        filename = strcat(targetDir,'/',s_f,'_',int2str(i), '.png');
        imwrite(out(:,:,i),filename);
    end
    clear(s_f)
end
