function varDatabase = loadDatabaseFromFile(fileNameDatabase)

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