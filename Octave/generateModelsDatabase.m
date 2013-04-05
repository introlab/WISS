%
% generateModelDatabase(fileNameList)
%
% fileNameList is a N x 2 cell array, where N matches the number of models
%
% fileNameList{1,1} = '(string id for speaker 1)'
% fileNameList{1,2} = '(path of the wave file used for training speaker 1)';
% fileNameList{2,1} = '(string id for speaker 2)'
% fileNameList{2,2} = '(path of the wave file used for training speaker 2)';
%        ...        =                          ...
% fileNameList{N,1} = '(string id for speaker N)'
% fileNameList{N,2} = '(path of the wave file used for training speaker N)';
function modelsDatabase = generateModelsDatabase(fileNameList)

    % Number of models
    nModels = size(fileNameList,1);
    
    % Check for file path now
    for iModel = 1:1:nModels
       
        if (exist(fileNameList{iModel,2},'file') == 0)
           
            error(strcat('File ',fileNameList{iModel,1},' doest not exist!'));
            
        end
        
    end
    
    % Create cell for database
    modelsDatabase = cell(nModels,2);
    
    disp('Now generating models...');
        
    % Loop for each model
    for iModel = 1:1:nModels
       
        % Save id string
        modelsDatabase{iModel,1} = fileNameList{iModel,1};
        
        % Progress indicator
        progressStr = ['(' num2str(iModel) '/' num2str(nModels) ') '];
        
        % Then generate model
        disp([ progressStr 'Generating the model of ' modelsDatabase{iModel,1},'...']);
        
        % Create model
        modelsDatabase{iModel,2} = generateModelFromWave(char(fileNameList(iModel,2)),length(progressStr));
        
    end

return