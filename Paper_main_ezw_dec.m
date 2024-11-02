fid = fopen('decrypted_data.bin', 'rb');
decoded_data = fread(fid, '*ubit1');
fclose(fid);

numeric_array_reverse = reshape(decoded_data, 1, []);
char_stream_reverse = char(numeric_array_reverse + 48);
stream_bit = char(char_stream_reverse);




treshold = pow2(floor(log2(max(max(abs(img_wavedata))))));

[LL1_dec_significance_map, LL1_dec_refinement] = func_huffman_decode(stream_bit);

img_wavedata_dec = func_ezw_dec(n, treshold, LL1_dec_significance_map, LL1_dec_refinement);

img_reconstruct = func_InvDWT(img_wavedata_dec, S, Lo_R, Hi_R, level);
%[reconstructed_LL1, reconstructed_LH1, reconstructed_HL1, reconstructed_HH1] = deal(LL1, LH1, HL1, HH1);
% reconstructed_image = idwt2(LL1_wavedata_dec, LH1, HL1, HH1, 'haar');


figure;
subplot(2, 2, 1);
imshow(originalImage, []);
title('Original Lena image');

subplot(2, 2, 2);
imshow(img_reconstruct, []);
title('Reconstructed Image');

reconstructed_uint8 = im2uint8(reconstructed_image);
imwrite(reconstructed_uint8, 'reconstructed_image.bmp');

% imshow(originalImage);
% imshow(uint8(img_reconstruct));
