%% Code to test the net predictions.

YTest = pximds_test.PixelLabelData;

n_imds = imageDatastore(pximds_test.Images);


YPred = semanticseg(n_imds, net,...
            "MiniBatchSize", 4, 'WriteLocation', '../');


pred = pixelLabelDatastore(pximds_test.PixelLabelData, classNames, labelIDs)
metrics = evaluateSemanticSegmentation(YPred, pred)