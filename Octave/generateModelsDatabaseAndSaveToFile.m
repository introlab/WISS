function modelsDatabase = generateModelsDatabaseAndSaveToFile(fileNameList, fileNameDataBase)

    % Generate models
    modelsDatabase = generateModelsDatabase(fileNameList);

    % Save to file
    saveDatabaseToFile(modelsDatabase,fileNameDataBase);
    
return