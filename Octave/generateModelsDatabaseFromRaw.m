function modelsDatabase = generateModelsDatabaseFromRaw(fileNameList)
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
% * Inputs:  fileNameList    List of file paths of raw and model names    *
% *                                                                       *
% * Outputs: modelsDatabase  List of models                               *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * fileNameList is a N x 2 cell array, where N matches the number of     *
% * models                                                                *
% *                                                                       *
% * fileNameList{1,1} = '(string id for speaker 1)'                       *
% * fileNameList{1,2} = '(path of the raw file used for training speaker  *
% *                     1)'                                               *
% * fileNameList{2,1} = '(string id for speaker 2)'                       *
% * fileNameList{2,2} = '(path of the raw file used for training speaker  *
% *                     2)'                                               *
% *        ...        =                          ...                      *
% * fileNameList{N,1} = '(string id for speaker N)'                       *
% * fileNameList{N,2} = '(path of the raw file used for training speaker  *
% *                     N)'                                               *
% *                                                                       *
% * The returned models database has the following structure:             *
% *                                                                       *
% * modelsDatabase{1,1} = '(string id for speaker 1)'                     *
% * modelsDatabase{1,2} = '(model for speaker 1)'                         *
% *                                                                       *
% * modelsDatabase{2,1} = '(string id for speaker 2)'                     *
% * modelsDatabase{2,2} = '(model for speaker 2)'                         *
% *                                                                       *
% *         ...         =                          ...                    *
% *                                                                       *
% * modelsDatabase{N,1} = '(string id for speaker N)'                     *
% * modelsDatabase{N,2} = '(model for speaker N)'                         *
% *                                                                       *
% *************************************************************************
% 

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
        modelsDatabase{iModel,2} = generateModelFromRaw(char(fileNameList(iModel,2)),length(progressStr));
        
    end

return