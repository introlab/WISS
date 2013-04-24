function singleChannel = extractMostPowerfulChannelFromRaw(rawData)
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
% * Inputs:  rawData         Matrix                                       * 
% *                                                                       *
% * Outputs: singleChannel   Vector with the most power channel           * 
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * This extracts the channel which holds the most energy                 * 
% *                                                                       * 
% *             +-------------------------+                               *
% *  Channel 1  | 01 | 09 | 17 | 25 | ... |                               *
% *             +-------------------------+                               *
% *  Channel 2  | 02 | 10 | 18 | 26 | ... |                               *
% *             +-------------------------+                               *
% *  Channel 3  | 03 | 11 | 19 | 27 | ... |                               *
% *             +-------------------------+                               *
% *  Channel 4  | 04 | 12 | 20 | 28 | ... |                               *
% *             +-------------------------+                               *
% *  Channel 5  | 05 | 13 | 21 | 29 | ... |                               *
% *             +-------------------------+                               *
% *  Channel 6  | 06 | 14 | 22 | 30 | ... |                               *
% *             +-------------------------+                               *
% *  Channel 7  | 07 | 15 | 23 | 31 | ... |                               *
% *             +-------------------------+                               *
% *  Channel 8  | 08 | 16 | 24 | 32 | ... |                               *
% *             +-------------------------+                               *
% *                                                                       * 
% * Suppose channel 5 is the one with most energy, the function returns:  * 
% *                                                                       * 
% *                 +-------------------------+                           *
% *  singleChannel  | 05 | 13 | 21 | 29 | ... |                           *
% *                 +-------------------------+                           *
% *                                                                       * 
% *************************************************************************
% 

    % Compute mean power for each channel
    meanPower = mean(rawData.^2,2);
    
    % Find most powerful one
    [powerV, powerI] = max(meanPower);
    
    % Return this channel
    singleChannel = rawData(powerI,:);

return