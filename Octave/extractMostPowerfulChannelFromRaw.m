function [singleChannel] = extractMostPowerfulChannelFromRaw(rawData)

    % Compute mean power for each channel
    meanPower = mean(rawData.^2,2);
    
    % Find most powerful one
    [powerV, powerI] = max(meanPower);
    
    % Return this channel
    singleChannel = rawData(powerI,:);

return