function [w] = generateWindow(N)

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