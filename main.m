%%%%%%
% This script is the main one where the Unet is trained to segment cells
% imaged with the electron microscopy (EM). Here, the training has been
% done on the AC3 and AC4 portions of the Kasthuri dataset that can be
% downloaded at https://software.rc.fas.harvard.edu/lichtman/vast/.
load_net= 1;

% Set initial params
imageSize = [256 256 1];
% imageSize = [32 32];
numClasses = 2;
encoderDepth = 3;


% If a net has already been trained, you can reuse it here, or train it on
% top of what has already been done.
if load_net==1
    load ('unet_epoch_4.mat');
    lgraph = layerGraph(net);
else
    lgraph = unetLayers (imageSize, numClasses, 'EncoderDepth' , encoderDepth);
end


plot (lgraph)

%%
% Set the directory for the EM images and the labels
imageDir = "ac3_EM_patch";
labelDir = "ac3_dbseg_images_bw_patch";

% dataSetDir = fullfile(toolboxdir('vision'),'visiondata','triangleImages');
% imageDir = fullfile(dataSetDir,'trainingImages');
% labelDir = fullfile(dataSetDir,'trainingLabels');

% the imageDatastore is used to manage a db of images. Use it for memory
% reasons.
imds = imageDatastore(imageDir);



classNames = ["border","no_border"];
labelIDs   = [255 0];  % black or white

%get ground truth
pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);

% create a db for training
ds = pixelLabelImageDatastore(imds,pxds);

% create a training, validation and test set
if load_net ==1
    load('data_split.mat');
else
    [train, val, test] = dividerand(ds.NumObservations);
end

% retrieve the sets
pximds_train = partitionByIndex(ds,train);
pximds_val = partitionByIndex(ds,val);
pximds_test = partitionByIndex(ds,test);




%% Set the options for training
options = trainingOptions('adam','InitialLearnRate',1e-3, 'Shuffle', 'every-epoch', ...
    'MaxEpochs',4,'VerboseFrequency',10, 'MiniBatchSize', 4,'ExecutionEnvironment','auto',...
    'Plots', 'training-progress', 'ValidationData', pximds_val, 'ValidationFrequency', 500);

%% Launch the training
doTraining = true; 
if doTraining     
    [net,info] = trainNetwork(pximds_train,lgraph,options); 
%     [net,info] = trainNetwork(pximds_train,net.Layers,options); 
else 
    load(fullfile(imageDir,'trainedUnet','multispectralUnet.mat'));
end

%%
%options = trainingOptions('adam','InitialLearnRate',1e-3, 'Shuffle', 'every-epoch', ...
%    'MaxEpochs',2,'VerboseFrequency',10, 'MiniBatchSize', 4,'ExecutionEnvironment','auto',...
%    'ValidationData', pximds_val, 'ValidationFrequency', 450);

%%
%for i = 1:5
%   lgraph = layerGraph(net);
%   [net,info] = trainNetwork(pximds_train,lgraph,options);  
%   save(strcat('unet_epoch_', int2str(8+i*2),'.mat'), 'net', 'info');
%end