function func_ezw_demo_main
%
% main program to run this demo
%
clear all; close all; clc;

fprintf('-----------   Welcome to EZW Matlab Demo!   ----------------\n');

infilename = 'lena256.bmp';
outfilename = 'lena256_reconstruct.bmp';

fprintf('-----------   Load Image   ----------------\n');

img_orig = double(imread(infilename));

fprintf('done!\n');
fprintf('-----------   Wavelet Decomposition   ----------------\n');
n = size(img_orig, 1);
n_log = log2(n); 
level = n_log;  % wavelet decomposition level can be defined by users.

type = 'bior4.4';   %wavelet basis
[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(type);

%img_wavedata: wavelet coefficients of the input image
[img_wavedata, S] = func_DWT(img_orig, level, Lo_D, Hi_D);

fprintf('done!\n');
fprintf('-----------   EZW Encoding   ----------------\n');
ezw_encoding_threshold = 50;

[img_enc_significance_map, img_enc_refinement] = func_ezw_enc(img_wavedata, ezw_encoding_threshold);

img_ezw_stream_bit = func_huffman_encode(img_enc_significance_map, img_enc_refinement);

fprintf('done!\n');
fprintf('-----------   EZW Decoding   ----------------\n');
treshold = pow2(floor(log2(max(max(abs(img_wavedata))))));

[img_dec_significance_map, img_dec_refinement] = func_huffman_decode(img_ezw_stream_bit);

img_wavedata_dec = func_ezw_dec(n, treshold, img_dec_significance_map, img_dec_refinement);

fprintf('done!\n');
fprintf('-----------  Inverse Wavelet Decomposition   ----------------\n');

img_reconstruct = func_InvDWT(img_wavedata_dec, S, Lo_R, Hi_R, level);

fprintf('done!\n');
fprintf('-----------   Performance   ----------------\n');

imwrite(img_reconstruct, gray(256), outfilename, 'bmp');

fprintf('The bitrate is %.2f bpp (with threshold %d in the encoding)\n', length(img_ezw_stream_bit)/size(img_orig,1)/size(img_orig,2), ezw_encoding_threshold);

Q = 255;
MSE = sum(sum((img_reconstruct-img_orig).^2))/size(img_orig,1)/size(img_orig,2);
fprintf('The psnr performance is %.2f dB\n', 10*log10(Q*Q/MSE));
