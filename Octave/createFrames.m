function [vectorFrames,numberSlices] = createFrames(x,hop,windowSize) 
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
% * Inputs:  x               Vector                                       * 
% *          hop             Number of samples between adjacent windows   * 
% *          windowSize      Size of each window                          *
% *                                                                       *
% * Outputs: vectorFrames    Resulting matrix made of all the frames      * 
% *          numberSlices    Number of frames in the matrix               *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
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