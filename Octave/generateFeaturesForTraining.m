function [features] = generateFeaturesForTraining(x, hopSize, frameSize, Fs, window)

    % Emphasis
    xFiltered = filter([1 -0.95],[1],x);

    % Create frames
    xFrames = createFrames(xFiltered,hopSize,frameSize);
    
    % Compute power of frames
    xPower = 0 * xFrames;
    
    for iFrame = 1:1:size(xFrames,1)
           
        xFrame = window .* xFrames(iFrame,:);
        xFrameFft = fft(xFrame);
        xFramePower = abs(xFrameFft).^2;

        xPower(iFrame,:) = xFramePower;
            
    end
    
    xPower(:,1) = xPower(:,1) * 0;
    
    % Generate filterbank
    H_m = generateFilterbank(frameSize,Fs);
    
    % Generate features
    xFeatures = log(xPower * H_m + 1E-10);
    
    % Voice activity detection made simple
    vadLevel = 3;
    ts = 10;
    va = generateVAD(xPower, mean(mean(xPower)) * vadLevel, frameSize, ts);
    
    % Get mask
    filterMask = transpose(va);
    
    % Apply
    indexesMask = 1:1:size(filterMask,2);
    indexesFilter = indexesMask .* filterMask;
    indexesSorted = sort(indexesFilter);
    indexesSort = indexesSorted(sum(indexesSorted==0)+1:1:length(indexesSorted));
    
    % Get only active features
    activeFeatures = xFeatures(indexesSort,:);
        
    % And normalize
    activeFeaturesNorm = activeFeatures - ones(size(activeFeatures,1),1) * mean(activeFeatures);
    
    % Return
    features = activeFeaturesNorm;
    
return