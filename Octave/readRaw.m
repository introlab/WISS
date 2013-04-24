function rawData = readRaw(fileName, nChannels)
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
% * Inputs:  fileName        File name of the raw file                    *
% *          nChannels       Number of channels in the raw file           *
% *                                                                       *
% * Outputs: rawData         Table of raw data                            *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          *
% *                                                                       *
% * Takes the samples from the raw file and loads them in a table.        *
% *                                                                       *
% *             +---------------------------------------------------+     *
% *  File       | 01 | 02 | 03 | 04 | 05 | 06 | ... | 31 | 32 | ... |     *
% *             +---------------------------------------------------+     *
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
% *************************************************************************
% 

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