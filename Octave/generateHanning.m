function window = generateHanning(frameSize)
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
% * Inputs:  frameSize       Size of the frame in samples                 *
% *                                                                       *
% * Outputs: window          Vector with the analysis window              *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * This generates the hann window.                                       *
% *                                                                       * 
% *************************************************************************
% 
    N = frameSize + 2;
    n = 0:1:(N-1);

    w = 0.5 * (1 - cos(2*pi*n/(N-1)));
    window = transpose(w(2:1:(N-1)));

return