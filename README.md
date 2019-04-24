# Segmentation-Unet
This repo was written to load, preprocess EM images to then train a Unet to segment EM images by detecting cell borders.
Here, the training has been done on the AC3 and AC4 portions of the Kasthuri dataset that can be downloaded at https://software.rc.fas.harvard.edu/lichtman/vast/
The folders containing the dataset should be downloaded and added to the directory.
First datasets should be created with the "create_datasets". 
The labels should be processed with the "unique_rgb" script, and then be patched together with the EM images with the "break_image" code. 
The subsequent steps should be carried out with the "main" script. 
For suggestions or bugs, please report to elisa.pavarino@tum.de
