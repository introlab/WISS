function [activeFeatures, activeMask, noiseMask, Hl, Bl] = generateFeaturesForTesting(xSeparated, xPostfiltered, hopSize, frameSize, Fs, window)
%
% *************************************************************************
% *                                                                       *
% * Project: WISS                                                         *
% * Author: François Grondin                                              *
% * Version: 1.0.0                                                        *
% * Date: 24/04/2013                                                      *
% *                                                                       *
% *************************************************************************
% *                                                                       *
% * License:                                                              *
% *                                                                       *
% * WISS is free software: you can redistribute it and/or modify it under *
% * the terms of the GNU General Public License as published by the Free  *
% * Software Foundation, either version 3 of the License, or (at your     *
% * option) any later version. WISS is distributed in the hope that it    *
% * will be useful, but WITHOUT ANY WARRANTY; without even the implied    *
% * warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See  *
% * the GNU General Public License for more details. You should have      *
% * received a copy of the GNU General Public License along with WISS.    *
% * If not, see http://www.gnu.org/licenses/.                             *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Inputs:  xSeparated      Vector with separated audio stream           *
% *          xPostfiltered   Vector with post-filtered audio stream       *
% *          hopSize         Size of the hop in samples                   *
% *          frameSize       Size of the frame in samples                 *
% *          Fs              Sample rate (Samples/sec)                    *
% *          window          Vector witch holds the analysis window       *
% *                                                                       *
% * Outputs: activeFeatures  Matrix with generated features               *
% *          activeMask      Matrix with generated mask                   *
% *          noiseMask       Matrix with generated noise mask             *
% *          Hl              Vector with estimated convolutive noise      *
% *          Bl              Vector with estimated additive noise         *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * This generates the features used for testing.                         *
% *                                                                       * 
% *************************************************************************
% 

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