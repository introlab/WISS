% ************************************************************************* 
% * Inputs:  x               Vector                                       * 
% *          hop             Number of samples between adjacent windows   * 
% *          windowSize      Size of each window                          * 
% * Outputs: vectorFrames    Resulting matrix made of all the frames      * 
% *          numberSlices    Number of frames in the matrix               * 
% ************************************************************************* 
% * Description:                                                          * 
% *                                                                       * 
% * This function splits a vector in overlapping frames and stores these  * 
% * frames into a matrix:                                                 * 
% *                                                                       * 
% * |------------------Input vector---------------------|                 * 
% *                                                                       * 
% * |------1------|                                                       * 
% *     |------2------|                                                   * 
% *         |------3------|                                               * 
% *             |------4------|                                           * 
% *                      ...                                              * 
% *                                                                       * 
% * Index            Frame                                                * 
% *   1         |------1------|                                           * 
% *   2         |------2------|                                           * 
% *   3         |------3------|                                           * 
% *   4         |------4------|                                           * 
% *  ...              ...                                                 * 
% *                                                                       * 
% *************************************************************************
% 
function [vectorFrames,numberSlices] = createFrames(x,hop,windowSize) 

% Find the max number of slices that can be obtained 
numberSlices = floor((length(x)-windowSize)/hop); 

% Truncate if needed to get only a integer number of hop 
x = x(1:(numberSlices*hop+windowSize)); 

% Create a matrix with time slices 
vectorFrames = zeros(floor(length(x)/hop),windowSize); 

% Fill the matrix 
for index = 1:numberSlices 

    indexTimeStart = (index-1)*hop + 1; 
    indexTimeEnd = (index-1)*hop + windowSize; 

    vectorFrames(index,:) = x(indexTimeStart: indexTimeEnd); 

end 

return