
listNames = cell(4,2);

listNames{1,1} = 'Dominic Létourneau';
listNames{1,2} = '/media/Data/Maîtrise/Expériences/Experience5/Training/Omni/omnimic_dominic_letourneau.wav';
listNames{2,1} = 'François Ferland';
listNames{2,2} = '/media/Data/Maîtrise/Expériences/Experience5/Training/Omni/omnimic_francois_ferland.wav';
listNames{3,1} = 'François Grondin';
listNames{3,2} = '/media/Data/Maîtrise/Expériences/Experience5/Training/Omni/omnimic_francois_grondin.wav';
listNames{4,1} = 'Mathieu Labbé';
listNames{4,2} = '/media/Data/Maîtrise/Expériences/Experience5/Training/Omni/omnimic_mathieu_labbe.wav';

generateModelsDatabaseAndSaveToFile(listNames, 'tmpModelDatabase.mat');

testFileSeparated = '/media/Data/Maîtrise/Expériences/Vidéo/Separated/loc-separated00045.wav';
testFilePostfiltered = '/media/Data/Maîtrise/Expériences/Vidéo/Separated/loc-postfiltered00045.wav';
testDatabase = 'tmpModelDatabase.mat';

[choices,scores] = testWaveWithModels(testFileSeparated, testFilePostfiltered, testDatabase);