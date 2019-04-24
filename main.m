%%
load_net= 1;

imageSize = [256 256 1];
% imageSize = [32 32];
numClasses = 2;
encoderDepth = 3;

if load_net==1
    load ('unet_epoch_4.mat');
    lgraph = layerGraph(net);
else
    lgraph = unetLayers (imageSize, numClasses, 'EncoderDepth' , encoderDepth);
end


plot (lgraph)

%%

imageDir = "ac3_EM_patch";
labelDir = "ac3_dbseg_images_bw_patch";

% dataSetDir = fullfile(toolboxdir('vision'),'visiondata','triangleImages');
% imageDir = fullfile(dataSetDir,'trainingImages');
% labelDir = fullfile(dataSetDir,'trainingLabels');


imds = imageDatastore(imageDir);



classNames = ["border","no_border"];
labelIDs   = [255 0];

pxds = pixelLabelDatastore(labelDir,classNames,labelIDs);

ds = pixelLabelImageDatastore(imds,pxds);

if load_net ==1
    load('data_split.mat');
else
    [train, val, test] = dividerand(ds.NumObservations);
end

pximds_train = partitionByIndex(ds,train);
pximds_val = partitionByIndex(ds,val);
pximds_test = partitionByIndex(ds,test);




%%


options = trainingOptions('adam','InitialLearnRate',1e-3, 'Shuffle', 'every-epoch', ...
    'MaxEpochs',4,'VerboseFrequency',10, 'MiniBatchSize', 4,'ExecutionEnvironment','auto',...
    'Plots', 'training-progress', 'ValidationData', pximds_val, 'ValidationFrequency', 500);



%%
%net = trainNetwork(ds,lgraph,options)

doTraining = true; 
if doTraining     
    [net,info] = trainNetwork(pximds_train,lgraph,options); 
%     [net,info] = trainNetwork(pximds_train,net.Layers,options); 
else 
    load(fullfile(imageDir,'trainedUnet','multispectralUnet.mat'));
end

%%
options = trainingOptions('adam','InitialLearnRate',1e-3, 'Shuffle', 'every-epoch', ...
    'MaxEpochs',2,'VerboseFrequency',10, 'MiniBatchSize', 4,'ExecutionEnvironment','auto',...
    'ValidationData', pximds_val, 'ValidationFrequency', 450);

%%

for i = 1:5
   lgraph = layerGraph(net);
   [net,info] = trainNetwork(pximds_train,lgraph,options);  
   save(strcat('unet_epoch_', int2str(8+i*2),'.mat'), 'net', 'info');
end