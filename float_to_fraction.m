function [numerator, denominator] = float_to_fraction(x, error)
% due to some pixel values which arise due to noise.
    if nargin < 2
        error = 0.01;
    end

    n = floor(x);
    x = x - n;

    if x < error
        numerator = n;
        denominator = 1;
        fprintf('%d/%d\n', numerator, denominator);
        return;
    elseif 1 - error < x
        numerator = n + 1;
        denominator = 1;
        fprintf('%d/%d\n', numerator, denominator);
        return;
    end

    lower_n = 0;
    lower_d = 1;
    upper_n = 1;
    upper_d = 1;

    while true
        middle_n = lower_n + upper_n;
        middle_d = lower_d + upper_d;

        if middle_d * (x + error) < middle_n
            upper_n = middle_n;
            upper_d = middle_d;
        elseif middle_n < (x - error) * middle_d
            lower_n = middle_n;
            lower_d = middle_d;
        else
            numerator = n * middle_d + middle_n;
            denominator = middle_d;
            fprintf('%d/%d\n', numerator, denominator);
            return;
        end
    end
end
