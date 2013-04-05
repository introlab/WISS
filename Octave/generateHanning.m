function window = generateHanning(frameSize)

    N = frameSize + 2;
    n = 0:1:(N-1);

    w = 0.5 * (1 - cos(2*pi*n/(N-1)));
    window = transpose(w(2:1:(N-1)));

return