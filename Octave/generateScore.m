function [choices,scores] = generateScore(modelsDatabase, activeFeatures, activeMask, noiseMask, Hl, Bl)

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