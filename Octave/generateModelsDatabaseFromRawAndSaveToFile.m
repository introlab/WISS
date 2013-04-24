function modelsDatabase = generateModelsDatabaseFromRawAndSaveToFile(fileNameList, fileNameDataBase)
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
% * Inputs:  fileNameList     List of file paths of raw and model names   *
% *          fileNameDataBase File path where to save the models          *
% *                                                                       *
% * Outputs: modelsDatabase   List of models                              *
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

    % Generate models
    modelsDatabase = generateModelsDatabaseFromRaw(fileNameList);

    % Save to file
    saveDatabaseToFile(modelsDatabase,fileNameDataBase);
    
return