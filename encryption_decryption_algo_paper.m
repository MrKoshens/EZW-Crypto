fid = fopen('LL1_encoded_bitstreams.bin', 'rb');
LL1_encoded_data = fread(fid, '*ubit1');
fclose(fid);

seed = 973; % seed or key
num_values = numel(LL1_encoded_data);
random_numbers = custom_rng(seed, num_values);

random_numbers = uint8(random_numbers);

random_numbers = transpose(random_numbers);  

% Now, random_numbers is a column vector


encrypted_data = bitxor(LL1_encoded_data, random_numbers);

fid = fopen('encrypted_data.bin', 'wb');
fwrite(fid, encrypted_data, 'ubit1');
fclose(fid);

% Decrypt the encrypted data using XOR with the same random numbers
decrypted_data = bitxor(encrypted_data, random_numbers);

% Save the decrypted data
fid = fopen('decrypted_data.bin', 'wb');
fwrite(fid, decrypted_data, 'ubit1');
fclose(fid);
