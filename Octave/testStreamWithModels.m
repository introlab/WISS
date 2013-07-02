function [choices,scores] = testWStreamWithModels(separated_data, postfiltered_data, modelStructure)
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
% *          modelStructure  Structure of the model                       *
% *                                                                       *
% * Outputs: choices         List of potential people identified          *
% *          scores          Confidence level for each potential person   *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * Using the pretrained model, this function returns a list of people    *
% * that match the model given separated and post-filtered files for the  *
% * source of interest and a list with the confidence level associated    * 
% * with each identification                                              *
% *                                                                       *
% *************************************************************************
% 
    
    % Load separated wave
    xSeparated = separated_data;
    
    % Load post-filtered wave
    xPostfiltered = postfiltered_data;
    
    % Load models
    modelsDatabase = modelStructure;
    
    % Make sure both streams are equal in size and not empty
    if (length(xSeparated) == length(xPostfiltered)) && (length(xSeparated) ~= 0)
    
        % Parameters
        frameSize = 1024;
        hopSize = 512;
        Fs = 48000;
        window = generateWindow(frameSize)';
        
        % Generate features 
        [activeFeatures, activeMask, noiseMask, Hl, Bl] = generateFeaturesForTesting(xSeparated, xPostfiltered, hopSize, frameSize, Fs, window);
        
        % Generate score
        [choicesIndex,scores] = generateScore(modelsDatabase, activeFeatures, activeMask, noiseMask, Hl, Bl);   
        
        nModels = size(choicesIndex,1);
        choices = cell(nModels,1);
        
        for iModel = 1:1:nModels
            
            choices{iModel} = modelsDatabase{choicesIndex(iModel),1};
            
        end
    
    else
    
        nModels = size(modelsDatabase, 1);
        choices = cell(nModels,1);
        scores = zeros(nModels,1);
    
        for iModel = 1:1:nModels
            
            choices{iModel} = modelsDatabase{iModel,1};
            
        end
    
    end
    
return
