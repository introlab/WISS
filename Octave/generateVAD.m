function [va] = generateVAD(xPower, teta, frameSize, ts)

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