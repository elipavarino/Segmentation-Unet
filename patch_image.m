function patch = patch_image(im)

grayImage = im;
% Get the dimensions of the image.  numberOfColorBands should be = 1.
[rows columns numberOfColorBands] = size(grayImage);
% Display the original gray scale image.
figure;
subplot(2, 2, 1);
imshow(grayImage, []);
%title('Original Grayscale Image', 'FontSize', fontSize);
% Enlarge figure to full screen.
set(gcf, 'units','normalized','outerposition',[0 0 1 1]);

% Divide the image up into 4 blocks.
% Let's assume we know the block size and that all blocks will be the same size.
blockSizeR = 128; % Rows in block.
blockSizeC = 128; % Columns in block.
% Figure out the size of each block.
wholeBlockRows = floor(rows / blockSizeR);
wholeBlockCols = floor(columns / blockSizeC);
% Preallocate a 3D image
image3d = zeros(wholeBlockRows, wholeBlockCols, 3);
% Now scan though, getting each block and putting it as a slice of a 3D array.
sliceNumber = 1;
for row = 1 : blockSizeR : rows
    for col = 1 : blockSizeC : columns
        % Let's be a little explicit here in our variables
        % to make it easier to see what's going on.
        % Determine starting and ending rows.
        row1 = row;
        row2 = row1 + blockSizeR - 1;
        row2 = min(rows, row2); % Don't let it go outside the image.
        % Determine starting and ending columns.
        col1 = col;
        col2 = col1 + blockSizeC - 1;
        col2 = min(columns, col2); % Don't let it go outside the image.
        % Extract out the block into a single subimage.
        oneBlock = grayImage(row1:row2, col1:col2);
        % Specify the location for display of the image.
        subplot(2, 2, sliceNumber);
        imshow(oneBlock);
        % Make the caption the block number.
        caption = sprintf('Block #%d of 4', sliceNumber);
        %title(caption, 'FontSize', fontSize);
        drawnow;
        % Assign this slice to the image we just extracted.
        if (row2-row1+1) == blockSizeR && (col2-col1+1) == blockSizeC
            % Then the block size is the tile size,
            % so add a slice to our 3D image stack.
            image3D(:, :, sliceNumber) = oneBlock;
        else
            newTileSize = [(row2-row1+1), (col2-col1+1)];
            warningMessage = sprintf('Warning: this block size of %d rows and %d columns\ndoes not match the preset block size of %d rows and %d columns.\nIt will not be added to the 3D image stack.',...
                newTileSize(1), newTileSize(2), blockSizeR, blockSizeC);
            uiwait(warndlg(warningMessage));
        end
        sliceNumber = sliceNumber + 1;
    end
end
% Now image3D is a 3D image where each slice,
% or plane, is one quadrant of the original 2D image.

msgbox('Done with demo!  Check out the two figures.');