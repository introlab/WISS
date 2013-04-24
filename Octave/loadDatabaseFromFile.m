function varDatabase = loadDatabaseFromFile(fileNameDatabase)
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
% * Inputs:  fileNameDatabase File which contains the database            *
% *                                                                       *
% * Outputs: varDatabase      Structure of the loaded database            *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * This function loads the database stored in the file.                  *
% *                                                                       *
% *************************************************************************
% 
    fid = fopen(fileNameDatabase,'r');
    
    % Read number of models
    nModels = round(str2num(fgetl(fid)));
    
    % Write number of centroids
    nCentroids = round(str2num(fgetl(fid)));    
        
    % Write number of dimensions
    nDims = round(str2num(fgetl(fid)));    
    
    varDatabase = cell(nModels,2);
    
    % Write each model
    for iModel = 1:1:nModels
       
        % Write name
        
        modelName = fgetl(fid);
        varDatabase{iModel,1} = modelName;
        varDatabase{iModel,2} = zeros(nCentroids,nDims);
        
        for iCentroid = 1:1:nCentroids

            for iDim = 1:1:nDims

                value = str2double(fgetl(fid));
                varDatabase{iModel,2}(iCentroid,iDim) = value;
                
            end

        end
        
    end
    
    fclose(fid);

return