function [w] = generateWindow(N)
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
% * Inputs:  N               Size of the frame in samples                 *
% *                                                                       *
% * Outputs: window          Vector with the analysis window              *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * This generates a custom window.                                       *
% *                                                                       * 
% *************************************************************************
% 

    % Empty frame
    w = zeros(N,1);

    for k = 0:1:(N-1)

        % Define the shape of the window
        if (k < N / 4)

            value = 0.5 - 0.5 * cos(1.9979*4*k/N);

        end

        if (k >= (N/4)) && (k < (N/2))

            value = sqrt(1 - (0.5 - 0.5 * cos(1.9979*(2 - 4*k/N)))^2);

        end

        if (k >= (N/2)) && (k < (3*N/4))

            value = sqrt(1 - (0.5 - 0.5 * cos(1.9979*(4*k/N - 2)))^2);

        end

        if (k > (3*N/4))

            value = 0.5 - 0.5 * cos(1.9979*(4 - 4*k/N));

        end

        % Save value
        w(k+1) = value;

    end

return