function [choices,scores] = generateScore(modelsDatabase, activeFeatures, activeMask, noiseMask, Hl, Bl)
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
% * Inputs:  modelsDatabase  Database which holds the models              *
% *          activeFeatures  Features to be tested                        *
% *          activeMask      Masks used with features                     *
% *          noiseMask       Noise maks used with features                *
% *          Hl              Convolutive noise estimation                 *
% *          Bl              Additive noise estimation                    *
% *                                                                       *
% * Outputs: choices         List of potential people identified          *
% *          scores          Confidence level for each potential person   *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * Using the pretrained models, this function returns a list of people   *
% * that match the models given the features to test and a list with the  *
% * confidence level associated with each identification                  *
% *                                                                       *
% *************************************************************************
% 
    % Dimensions
    nModels = size(modelsDatabase,1);
    nDims = size(activeFeatures,2);
    nFeatures = size(activeFeatures,1);
    
    % Parameters
    vadTs = 5;
    alpha = 0.02;
    beta = 0.01;    
    
    resultModel = zeros(nModels,1);
    
    % Loop for each model
    for iModel = 1:1:nModels
       
        model = modelsDatabase{iModel,2};
        
        % Modify for the environment
        modifiedModel = log(exp(model + ones(size(model,1),1) * Hl) + exp(ones(size(model,1),1) * Bl));
        modifiedModelMasked = modifiedModel .* (ones(size(modifiedModel,1),1) * noiseMask);
        
        modifiedModelMean = mean(modifiedModelMasked,2);
        
        modifiedModel = modifiedModel - modifiedModelMean * ones(1,nDims);
        
        % Now score        
        sumDiff = 0;
        tmpScore = zeros(nModels,nFeatures);
        
        for iFeature = 1:1:nFeatures
           
            currentFeature = activeFeatures(iFeature,:);
            currentMask = activeMask(iFeature,:) .* noiseMask;
            
            if sum(currentMask) > vadTs
                
                matrixFeature = ones(size(modifiedModel,1),1) * currentFeature;
                matrixMask = ones(size(modifiedModel,1),1) * currentMask;
                
                matrixDiff = (matrixFeature - modifiedModel).^2;
                matrixDiffMasked = matrixDiff .* matrixMask;
                vectorDiff = sqrt(sum(matrixDiffMasked,2));
                
                [minDiff,minIndex] = min(vectorDiff);
                sumDiff = sumDiff + minDiff;
                
                tmpScore(iModel,iFeature) = minDiff;
                
            end
            
        end
        
        % Normalise
        resultModel(iModel) = sumDiff / nFeatures;
        
    end
    
    [sortedMatchesValue,sortedMatchesIndex] = sort(resultModel);
    
    % Get lowest model
    [minV,minI] = min(resultModel);
    
    resultModel(minI) = inf;
    
    [minV2,minI2] = min(resultModel);
    
    diffV = minV2 - minV;
    
    confidence = 1 ./ (1 + exp(-1 * (diffV-alpha)/beta));
       
    choices = sortedMatchesIndex;
    scores = zeros(nModels,1);
    scores(1) = confidence;
    scores(2) = 1 - confidence;
    
return