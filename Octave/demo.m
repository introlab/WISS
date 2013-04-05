% Demo file

% Here we create a list that will hold four models, identified by a string
% name and a path that matches the wave file
listModels = cell(4,2);

listModels{1,1} = 'Dominic Létourneau';
listModels{1,2} = '../Samples/SoundsForTraining/dominic_letourneau.wav';
listModels{2,1} = 'François Ferland';
listModels{2,2} = '../Samples/SoundsForTraining/francois_ferland.wav';
listModels{3,1} = 'François Grondin';
listModels{3,2} = '../Samples/SoundsForTraining/francois_grondin.wav';
listModels{4,1} = 'Mathieu Labbé';
listModels{4,2} = '../Samples/SoundsForTraining/mathieu_labbe.wav';

% The models are generated, and saved to the file modelDatabase.txt
modelsDatabase = generateModelsDatabaseAndSaveToFile(listModels, 'modelDatabase.txt');

% Here we create a list of file to test, which contains both the paths for
% separated and postfiltered sound streams
nSequences = 12;
listSequences = cell(nSequences,3);

listSequences{1,1} = '../Samples/SoundsForTesting/sequence001-sp-francois_ferland.wav';
listSequences{1,2} = '../Samples/SoundsForTesting/sequence001-pf-francois_ferland.wav';
listSequences{1,3} = 'François Ferland';
listSequences{2,1} = '../Samples/SoundsForTesting/sequence002-sp-francois_grondin.wav';
listSequences{2,2} = '../Samples/SoundsForTesting/sequence002-pf-francois_grondin.wav';
listSequences{2,3} = 'François Grondin';
listSequences{3,1} = '../Samples/SoundsForTesting/sequence003-sp-dominic_letourneau.wav';
listSequences{3,2} = '../Samples/SoundsForTesting/sequence003-pf-dominic_letourneau.wav';
listSequences{3,3} = 'Dominic Létourneau';
listSequences{4,1} = '../Samples/SoundsForTesting/sequence004-sp-francois_ferland.wav';
listSequences{4,2} = '../Samples/SoundsForTesting/sequence004-pf-francois_ferland.wav';
listSequences{4,3} = 'François Ferland';
listSequences{5,1} = '../Samples/SoundsForTesting/sequence005-sp-francois_grondin.wav';
listSequences{5,2} = '../Samples/SoundsForTesting/sequence005-pf-francois_grondin.wav';
listSequences{5,3} = 'François Grondin';
listSequences{6,1} = '../Samples/SoundsForTesting/sequence006-sp-dominic_letourneau.wav';
listSequences{6,2} = '../Samples/SoundsForTesting/sequence006-pf-dominic_letourneau.wav';
listSequences{6,3} = 'Dominic Létourneau';
listSequences{7,1} = '../Samples/SoundsForTesting/sequence007-sp-francois_ferland.wav';
listSequences{7,2} = '../Samples/SoundsForTesting/sequence007-pf-francois_ferland.wav';
listSequences{7,3} = 'François Ferland';
listSequences{8,1} = '../Samples/SoundsForTesting/sequence008-sp-francois_grondin.wav';
listSequences{8,2} = '../Samples/SoundsForTesting/sequence008-pf-francois_grondin.wav';
listSequences{8,3} = 'François Grondin';
listSequences{9,1} = '../Samples/SoundsForTesting/sequence009-sp-dominic_letourneau.wav';
listSequences{9,2} = '../Samples/SoundsForTesting/sequence009-pf-dominic_letourneau.wav';
listSequences{9,3} = 'Dominic Létourneau';
listSequences{10,1} = '../Samples/SoundsForTesting/sequence010-sp-francois_ferland.wav';
listSequences{10,2} = '../Samples/SoundsForTesting/sequence010-pf-francois_ferland.wav';
listSequences{10,3} = 'François Ferland';
listSequences{11,1} = '../Samples/SoundsForTesting/sequence011-sp-francois_grondin.wav';
listSequences{11,2} = '../Samples/SoundsForTesting/sequence011-pf-francois_grondin.wav';
listSequences{11,3} = 'François Grondin';
listSequences{12,1} = '../Samples/SoundsForTesting/sequence012-sp-dominic_letourneau.wav';
listSequences{12,2} = '../Samples/SoundsForTesting/sequence012-pf-dominic_letourneau.wav';
listSequences{12,3} = 'Dominic Létourneau';


% Test each sequence
for iSequence = 1:1:nSequences

    % Get score
    [choices,scores] = testWaveWithModels(listSequences{iSequence,1}, listSequences{iSequence,2}, modelsDatabase);    
    
    % Print result
    disp(['Sound sequence from ' listSequences{iSequence,3} ' recognized as the speaker ' choices{1}]);
    
end


