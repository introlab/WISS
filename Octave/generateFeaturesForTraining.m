function [features] = generateFeaturesForTraining(x, hopSize, frameSize, Fs, window)
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
% * Inputs:  x               Vector with training audio stream            *
% *          hopSize         Size of the hop in samples                   *
% *          frameSize       Size of the frame in samples                 *
% *          Fs              Sample rate (Samples/sec)                    *
% *          window          Vector witch holds the analysis window       *
% *                                                                       *
% * Outputs: features        Matrix with generated features               *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * This generates the features used for training.                        *
% *                                                                       * 
% *************************************************************************
% 
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