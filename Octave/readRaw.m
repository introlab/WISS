function rawData = readRaw(fileName, nChannels)

    % It is assumed the encoding is 16-bits signed
    
    % Open file
    fid = fopen(fileName,'rb');
    
    % Read data
    allChannels = fread(fid, inf, 'int16');
    
    % Close file
    fclose(fid);

    % Reshape
    rawData = reshape(allChannels, nChannels, floor(length(allChannels)/nChannels)) / 32768;
    
return