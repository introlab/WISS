function saveDatabaseToFile(varDatabase, fileNameDatabase)
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
% *          varDatabase      Structure of the loaded database            *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * This function saves the database to the file.                         *
% *                                                                       *
% *************************************************************************
% 
    fid = fopen(fileNameDatabase,'w');
    
    nModels = size(varDatabase,1);   
    nCentroids = size(varDatabase{1,2},1);
    nDims = size(varDatabase{1,2},2);
    
    % Write number of models
    fprintf(fid,'%i\n',nModels);
    
    % Write number of centroids
    fprintf(fid,'%i\n',nCentroids);
    
    % Write number of dimensions
    fprintf(fid,'%i\n',nDims);
    
    % Write each model
    for iModel = 1:1:nModels
       
        % Write name
        fprintf(fid,'%s\n',varDatabase{iModel,1});
        
        for iCentroid = 1:1:nCentroids

            for iDim = 1:1:nDims

                fprintf(fid,'%10.10f\n',varDatabase{iModel,2}(iCentroid,iDim));

            end

        end
        
    end
    
    fclose(fid);

return