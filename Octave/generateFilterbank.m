function [H_m] = generateFilterbank(N,Fs)
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
% *          Fs              Sample rate (Samples/sec)                    *
% *                                                                       *
% * Outputs: H_m             Matrix with filterbank                       *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * This generates the filterbank:                                        *
% *                                                                       *
% *         +----------------------------------------+                    *
% * Band 1  |000XXX0000000000000000000000000000000000|                    *
% *         +----------------------------------------+                    *
% * Band 2  |0000XXXX00000000000000000000000000000000|                    *
% *         +----------------------------------------+                    *
% *                            ...                                        *
% *         +----------------------------------------+                    *
% * Band 24 |0000000000000000000XXXXXXXXXXXXX00000000|                    *
% *         +----------------------------------------+                    *
% *                                                                       * 
% *************************************************************************
% 
    % Number of filters
    M = 24;

    % Matrix with band limits
    bands = zeros(M, 3);

    % Fixed width
    bands(1,:)  = [ 0        50          100];
    bands(2,:)  = [ 100      150         200];
    bands(3,:)  = [ 200      250         300];
    bands(4,:)  = [ 300      350         400];
    bands(5,:)  = [ 390      450         510];
    bands(6,:)  = [ 510      570         630];
    bands(7,:)  = [ 630      700         770];
    bands(8,:)  = [ 760      840         920];
    bands(9,:)  = [ 920      1000        1080];
    bands(10,:) = [ 1070     1170        1270];
    bands(11,:) = [ 1260     1370        1480];
    bands(12,:) = [ 1480     1600        1720];
    bands(13,:) = [ 1700     1850        2000];
    bands(14,:) = [ 1980     2150        2320];
    bands(15,:) = [ 2300     2500        2700];
    bands(16,:) = [ 2650     2900        3150];
    bands(17,:) = [ 3100     3400        3700];
    bands(18,:) = [ 3600     4000        4400];
    bands(19,:) = [ 4300     4800        5300];
    bands(20,:) = [ 5200     5800        6400];
    bands(21,:) = [ 6300     7000        7700];
    bands(22,:) = [ 7500     8500        9500];
    bands(23,:) = [ 9000     10500       12000];
    bands(24,:) = [ 11500    13500       15500];

    % Create a matrix with all filters
    H_m = zeros(M, N);

    % Loop for each filter
    for m = 1:1:M

        % Current frame
        H_m_k = zeros(1,N);

        % Band limits
        lowFreq = bands(m,1);
        centerFreq = bands(m,2);
        highFreq = bands(m,3);

        % For each sample
        for n = 1:1:N

            f = ((n-1) / N) * Fs;

            % Before triangle
            if (f < lowFreq)
                H_m_k(n) = 0;
            end

            % Inside triangle
            if ((f >= lowFreq) && (f <= highFreq))

                % Rising slope
                if (f <= centerFreq)
                    slope = 1 / (centerFreq - lowFreq);
                    H_m_k(n) = slope * (f - lowFreq);
                end

                % Falling slope
                if (f > centerFreq)
                    slope = 1 / (centerFreq - highFreq);
                    H_m_k(n) = slope * (f - centerFreq) + 1;
                end

            end

            % After triangle
            if (f > highFreq)
                H_m_k(n) = 0;            
            end

        end

        H_m(m,:)= H_m_k;

    end

    H_m = transpose(H_m);

return