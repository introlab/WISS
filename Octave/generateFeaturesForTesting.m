function [activeFeatures, activeMask, noiseMask, Hl, Bl] = generateFeaturesForTesting(xSeparated, xPostfiltered, hopSize, frameSize, Fs, window)

    % Parameters
    maskTs = 0.05;
    vadTs = 5;
    
    % Emphasis
    xSeparatedFiltered = filter([1 -0.95],[1],xSeparated);

    % Create frames
    xSeparatedFrames = createFrames(xSeparatedFiltered,hopSize,frameSize);
    
    % Compute power of frames
    xSeparatedPower = 0 * xSeparatedFrames;
    
    for iFrame = 1:1:size(xSeparatedFrames,1)
           
        xSeparatedFrame = window .* xSeparatedFrames(iFrame,:);
        xSeparatedFrameFft = fft(xSeparatedFrame);
        xSeparatedFramePower = abs(xSeparatedFrameFft).^2;

        xSeparatedPower(iFrame,:) = xSeparatedFramePower;
            
    end
    
    xSeparatedPower(:,1) = xSeparatedPower(:,1) * 0;

    % Emphasis
    xPostfilteredFiltered = filter([1 -0.95],[1],xPostfiltered);

    % Create frames
    xPostfilteredFrames = createFrames(xPostfilteredFiltered,hopSize,frameSize);
    
    % Compute power of frames
    xPostfilteredPower = 0 * xPostfilteredFrames;
    
    for iFrame = 1:1:size(xPostfilteredFrames,1)
           
        xPostfilteredFrame = window .* xPostfilteredFrames(iFrame,:);
        xPostfilteredFrameFft = fft(xPostfilteredFrame);
        xPostfilteredFramePower = abs(xPostfilteredFrameFft).^2;

        xPostfilteredPower(iFrame,:) = xPostfilteredFramePower;
            
    end
    
    xPostfilteredPower(:,1) = xPostfilteredPower(:,1) * 0;
    
    % Generate filterbank
    H_m = generateFilterbank(frameSize,Fs);
    
    nDims = size(H_m,2);
    
    % Features of the separated signal
    separatedFeatures = log(xSeparatedPower * H_m + 1E-10);

    % Features of the post-filtered signal
    postfilteredFeatures = log(xPostfilteredPower * H_m + 1E-20);
    
    % Mask
    maskFeatures = (exp(postfilteredFeatures) ./ exp(separatedFeatures)) > maskTs;
        
    % VAD
    sumMask = sum(maskFeatures');
    filterMask = sumMask > vadTs;
    indexesMask = 1:1:size(filterMask,2);
    indexesFilter = indexesMask .* filterMask;
    indexesSorted = sort(indexesFilter);
    indexesSort = indexesSorted((sum(indexesSorted==0)+1):1:length(indexesSorted));
    activeFeatures = separatedFeatures(indexesSort,:);
    activeMask = maskFeatures(indexesSort,:);
    
    % Get mean of features
    activeFeaturesMean = mean(activeFeatures);
    
    % Get noise
    noiseMatrix = (maskFeatures == 0) .* separatedFeatures;
    noiseVector = sum(noiseMatrix);
    noiseDen = sum(maskFeatures == 0);
    noiseFeaturesMean = noiseVector ./ noiseDen;
    
    % Get environment features
    Yl = activeFeaturesMean;
    Bl = noiseFeaturesMean;
    Hl = log(exp(Yl)-exp(Bl));
    YBdiff = Yl - Bl;
    
    noiseMask = YBdiff > 0;
    
    activeFeaturesMasked = activeFeatures .* (ones(size(activeFeatures,1),1) * noiseMask);
    activeFeaturesMean = mean(activeFeaturesMasked,2);
    
    activeFeatures = activeFeatures - activeFeaturesMean * ones(1,nDims);
    
    for iDim = 1:1:nDims
       
        if imag(Hl(iDim)) ~= 0
            Hl(iDim) = -inf;
        end
        
    end
        
return