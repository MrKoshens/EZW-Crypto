%Read the image
originalImage = imread('lena256.bmp'); 
temp = originalImage;

%%%%% DWT %%%%%
wavelet = 'db9';
%type = 'db9';

n = size(originalImage, 1);
n_log = log2(n); 
level = n_log;
% [LL1,LH1,HL1,HH1] = dwt2(temp,wavelet);

[Lo_D,Hi_D,Lo_R,Hi_R] = wfilters(wavelet);
[img_wavedata, S] = func_DWT(originalImage, level, Lo_D, Hi_D);



% [LL1,LH1,HL1,HH1] = dwt2(temp,wavelet);
% [LL2,LH2,HL2,HH2] = dwt2(LL1,wavelet);
% [LL3,LH3,HL3,HH3] = dwt2(LL2,wavelet);

% Display the decomposed parts
% figure;
% subplot(2, 2, 1);
% imshow(LL3, []);
% title('LL3');
% 
% subplot(2, 2, 2);
% imshow(LH3, []);
% title('LH3');
% 
% subplot(2, 2, 3);
% imshow(HL3, []);
% title('HL3');
% 
% subplot(2, 2, 4);
% imshow(HH3, []);
% title('HH3');

% Save the files
% imwrite(LL1, 'LL1_part.bmp');
% imwrite(LH1, 'LH1_part.bmp');
% imwrite(HL1, 'HL1_part.bmp');
% imwrite(HH1, 'HH1_part.bmp');


%%%%%%%%%%%%%%%%% log Transformation %%%%%%%%%%%%%%%%%%%
% % median of LL3
% median_LL3 = median(LL3(:));
% 
% % finding log(base=median)(argument=LL3)
% log_LL3 = log(LL3+ median_LL3) / log(median_LL3);
% data = log_LL3;

%%%%%%%%%%%%%%%%% Float to Fraction algorithm %%%%%%%%%%%%%%% 
% % Initialize matrices to store numerators and denominators (Madhav ka code)
% numerators = zeros(size(data));
% denominators = zeros(size(data));
% 
% for i = 1:size(data, 1)
%        for j = 1:size(data, 2)
% 
%         [numerator, denominator] = float_to_fraction(data(i, j));
% 
%         numerators(i, j) = numerator; 
%         denominators(i, j) = denominator;
%     end
% end
% 
% %%% we see that new and LH3 are both same so it definately works %%%
% new = numerators ./ denominators;


% % Convert detailed coefficients into fraction (Sir ka code)
% apprx_rat_LH1 = applyFractionConvert(data);
% apprx_rat_LH1 = applyFractionConvert(LH3);
% apprx_rat_HL1 = applyFractionConvert(HL1);
% apprx_rat_HH1 = applyFractionConvert(HH1);
% apprx_rat_LH2 = applyFractionConvert(LH2);
% apprx_rat_HL2 = applyFractionConvert(HL2);
% apprx_rat_HH2 = applyFractionConvert(HH2);
% apprx_rat_LH3 = applyFractionConvert(LH3);
% apprx_rat_HL3 = applyFractionConvert(HL3);
% apprx_rat_HH3 = applyFractionConvert(HH3);

%%%% EZW encoding %%%%
%Encode LL3 using EZW algorithm the image we want to encode
% image = [4 5; 7 6];
% image = LL3;
threshold = 30;

% ezw_encoding_threshold = 5;
max_coeff = max(abs(img_wavedata));
% ezw_encoding_threshold = power(2,floor(log2(max_coeff)));

ezw_encoding_threshold = threshold;

[LL1_enc_significance_map, LL1_enc_refinement] = func_ezw_enc(img_wavedata, ezw_encoding_threshold);
LL1_ezw_stream_bit = func_huffman_encode(LL1_enc_significance_map, LL1_enc_refinement);
LL1_numeric_array = double(LL1_ezw_stream_bit) - 48;
LL1_matrix_size = [1, length(LL1_numeric_array)];
LL1_encoded_bitstreams = reshape(LL1_numeric_array, LL1_matrix_size);


% %Save the binary sequence to a file
% fid = fopen('LL1_encoded_bitstreams.bin', 'wb');
% fwrite(fid, LL1_encoded_bitstreams, 'ubit1');
% fclose(fid);
%%%% EZW encoding ends %%%%

%%% Perform Huffman encoding %%%%
symbols = unique(LL1_encoded_bitstreams(:));
probabilities = histcounts(LL1_encoded_bitstreams(:), [symbols; inf]) / numel(LL1_encoded_bitstreams);
[dict, avglen] = custom_huffmandict(symbols, probabilities);
LL1_encoded_data = custom_huffmanenco(LL1_encoded_bitstreams(:), dict);
%%% Huffman encoding ends %%%%

% Save the binary sequence to a file
fid = fopen('LL1_encoded_bitstreams.bin', 'wb');
fwrite(fid, LL1_encoded_data, 'ubit1');
fclose(fid);