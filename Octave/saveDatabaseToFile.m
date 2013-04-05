function saveDatabaseToFile(varDatabase, fileNameDatabase)

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