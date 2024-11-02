function r = custom_rng(seed, num_values)
    r = zeros(1, num_values);
    a = 725459;     % Scaling factor
    b = 364563;
    c = pi;         % Parameter
    m = 2^32;       % Modulus
    
    
    for i = 1:num_values
        seed1 = mod((a * seed * c), m);
        seed2 = mod(((a * seed1 + b * seed) * c),m);
        seed = seed1;
        seed2 = seed1;

        r(i) = mod(seed2, 256) ;
    end
end
