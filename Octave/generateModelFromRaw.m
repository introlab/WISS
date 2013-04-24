function model = generateModelFromRaw(rawFilePath, nSpaces)
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
% * Inputs:  rawFilePath     File path for the raw file                   *
% *          nSpaces         Info used for printing progress              *
% *                                                                       *
% * Outputs: model           Generated model                              *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * This generates a model from the most powerful channel in the raw      *
% * file.                                                                 *
% *                                                                       * 
% *************************************************************************
% 
    % Offset
    offsetStr = repmat(' ',1,nSpaces);

    % Open wave file
    disp([offsetStr '(1/3) Loading raw file...']);
    
    nChannels = 8; % Eight channels for now
    rawData = readRaw(rawFilePath, nChannels); 
    waveSignal = extractMostPowerfulChannelFromRaw(rawData);
               
    % Parameters
    hopSize = 512;
    frameSize = 1024;
    Fs = 48000;
    window = transpose(generateWindow(frameSize));
    
    % Generate features
    disp([offsetStr '(2/3) Extracting features...']);
    features = generateFeaturesForTraining(waveSignal, hopSize, frameSize, Fs, window);
    
    % Parameters
    nCentroids = 256;
    
    % Generate model
    disp([offsetStr '(3/3) Training model...']);
    model = generateModel(features, nCentroids);
    
return