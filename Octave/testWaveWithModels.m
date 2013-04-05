function [choices,scores] = testWaveWithModels(fileNameWaveSeparated, fileNameWavePostfiltered, modelStructure)

    if (exist(fileNameWaveSeparated,'file') == 0)
       error('File name for separated wave not found!'); 
    end

    if (exist(fileNameWavePostfiltered,'file') == 0)
       error('File name for post-filtered wave not found!'); 
    end
    
    % Load separated wave
    xSeparated = wavread(fileNameWaveSeparated);
    
    % Load post-filtered wave
    xPostfiltered = wavread(fileNameWavePostfiltered);
    
    % Load models
    modelsDatabase = modelStructure;
    
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
    
return