% Demo file

% Here we create a list that will hold four models, identified by a string
% name and a path that matches the wave file
listModels = cell(2,2);

listModels{1,1} = 'François Grondin';
listModels{1,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/training/training_FG.raw';
listModels{2,1} = 'Simon Ouellet';
listModels{2,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/training/training_SO.raw';

% The models are generated, and saved to the file modelDatabase.txt
% If the files are in RAW format (16-bit signed, 8 channels), you can use
% this call instead:
%
modelsDatabase = generateModelsDatabaseFromRawAndSaveToMatFile(listModels, 'modelDatabase.txt');
%
%modelsDatabase = generateModelsDatabaseFromWaveAndSaveToFile(listModels, 'modelDatabase.txt');

% Here we create a list of file to test, which contains both the paths for
% separated and postfiltered sound streams
nSequences = 10;
listSequences = cell(nSequences,3);

listSequences{1,1} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_FG1.raw-separated00002.wav';
listSequences{1,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_FG1.raw-postfiltered00002.wav';
listSequences{1,3} = 'François Grondin';
listSequences{2,1} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_FG2.raw-separated00005.wav';
listSequences{2,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_FG2.raw-postfiltered00005.wav';
listSequences{2,3} = 'François Grondin';
listSequences{3,1} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_FG3.raw-separated00002.wav';
listSequences{3,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_FG3.raw-postfiltered00002.wav';
listSequences{3,3} = 'François Grondin';
listSequences{4,1} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_FG4.raw-separated00004.wav';
listSequences{4,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_FG4.raw-postfiltered00004.wav';
listSequences{4,3} = 'François Grondin';
listSequences{5,1} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_FG5.raw-separated00007.wav';
listSequences{5,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_FG5.raw-postfiltered00007.wav';
listSequences{5,3} = 'François Grondin';

listSequences{6,1} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_SO1.raw-separated00002.wav';
listSequences{6,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_SO1.raw-postfiltered00002.wav';
listSequences{6,3} = 'Simon Ouellet';
listSequences{7,1} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_SO2.raw-separated00003.wav';
listSequences{7,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_SO2.raw-postfiltered00003.wav';
listSequences{7,3} = 'Simon Ouellet';
listSequences{8,1} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_SO3.raw-separated00005.wav';
listSequences{8,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_SO3.raw-postfiltered00005.wav';
listSequences{8,3} = 'Simon Ouellet';
listSequences{9,1} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_SO4.raw-separated00003.wav';
listSequences{9,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_SO4.raw-postfiltered00003.wav';
listSequences{9,3} = 'Simon Ouellet';
listSequences{10,1} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_SO5.raw-separated00004.wav';
listSequences{10,2} = '/media/Data/Collaboration Recherche/Simon Ouellet/test_24_04_2012/recognition/test_FGetSO_SO5.raw-postfiltered00004.wav';
listSequences{10,3} = 'Simon Ouellet';



% Test each sequence
for iSequence = 1:1:nSequences

    % Get score
    [choices,scores] = testWaveWithModels(listSequences{iSequence,1}, listSequences{iSequence,2}, modelsDatabase);    
    
    % Print result
    disp(['Sound sequence from ' listSequences{iSequence,3} ' recognized as the speaker ' choices{1}]);
    
end


