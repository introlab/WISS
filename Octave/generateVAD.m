function [va] = generateVAD(xPower, teta, frameSize, ts)
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
% * Inputs:  xPower          Instantaneous power of the signal            *
% *          teta            Prefiltering detection level                 *
% *          frameSize       Number of samples in one frame               *
% *          ts              VAD detection level                          *
% *                                                                       *
% * Outputs: va              Binary vector with voice activity            *
% *                                                                       *
% ************************************************************************* 
% *                                                                       *
% * Description:                                                          * 
% *                                                                       * 
% * The function returns a vector with has values 0 or 1 for each frame   *
% * if voice is detected or not.                                          *
% *                                                                       *
% *************************************************************************
% 
    h_local = generateHanning(floor(frameSize/341));
    h_global = generateHanning(floor(frameSize/34));
    h_frame = generateHanning(frameSize);
    
    zeta_local = zeros(1,frameSize);
    zeta_global = zeros(1,frameSize);
    zeta_frame = zeros(1,frameSize);    
    
    P_local = zeros(1,frameSize);
    P_global = zeros(1,frameSize);
    P_frame = zeros(1,frameSize);
    
    q = zeros(1,frameSize);
    
    qMatrix = zeros(size(xPower,1),frameSize);
        
    for iFrame = 1:1:size(xPower,1)

        framePower = xPower(iFrame,:);
        
        conv_local = conv(h_local',framePower);
        conv_global = conv(h_global',framePower);
        conv_frame = conv(h_frame',framePower);
        
        trunk_local = conv_local((1+1):1:(frameSize+1));
        trunk_global = conv_global((1+15):1:(frameSize+15));
        trunk_frame = conv_frame((1+1023):1:(frameSize+1023));
        
        zeta_local = 0.7 * zeta_local + 0.3 * trunk_local;
        zeta_global = 0.7 * zeta_global + 0.3 * trunk_global;
        zeta_frame = 0.7 * zeta_frame + 0.3 * trunk_frame;        
        
        P_local = 1 ./ (1 + (teta ./ zeta_local) .^ 2);
        P_global = 1 ./ (1 + (teta ./ zeta_global) .^ 2);
        P_frame = 1 ./ (1 + (teta ./ zeta_frame) .^ 2);
        
        q = 1 - P_local .* P_global .* P_frame;
        
        qMatrix(iFrame,:) = q;
        
    end
    
    vaMatrix = 1 - qMatrix;
    
    va = sum(vaMatrix,2) > ts;
    
return