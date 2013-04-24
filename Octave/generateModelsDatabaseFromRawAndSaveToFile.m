function modelsDatabase = generateModelsDatabaseFromRawAndSaveToFile(fileNameList, fileNameDataBase)

    % Generate models
    modelsDatabase = generateModelsDatabaseFromRaw(fileNameList);

    % Save to file
    saveDatabaseToFile(modelsDatabase,fileNameDataBase);
    
return