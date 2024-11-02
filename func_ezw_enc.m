function [significance_map, refinement] = func_ezw_enc(img_wavedata,ezw_encoding_threshold);
%  img_wavedata: wavelet coefficients to encode
%  ezw_encoding_threshold: determine where to stop encoding (a lower
%  threshold value gives better image reconstruction quality)
%
%  significance_map: 
%  a string matrix containing significance data for different passes ('p','n','z','t'), where each row contains data for a different scanning pass.
%  refinement: a strubg matrix containing refinement data for different passes ('0' or '1'), each row contains data for a different scanning pass.
%

subordinate_list = [];
refinement = [];
significance_map = [];
img_wavedata_save = img_wavedata;
img_wavedata_mat = img_wavedata;

% calculate Morton scan order
n = size(img_wavedata,1);
scan = func_morton([0:(n*n)-1],n);

% calculate initial threshold
init_threshold = pow2(floor(log2(max(max(abs(img_wavedata))))));
threshold = init_threshold;

while (threshold >= ezw_encoding_threshold)
    
    [str, list, img_wavedata] = func_dominant_pass(img_wavedata, threshold, scan);
    significance_map = strvcat(significance_map, char(str));
    
    if(threshold == init_threshold),
        subordinate_list = list;
    else
        subordinate_list = func_rearrange_list(subordinate_list, list, scan, img_wavedata_save);
    end
       [encoded, subordinate_list] = func_subordinate_pass(subordinate_list, threshold);
       refinement = strvcat(refinement, strrep(num2str(encoded), ' ', ''));
        
    threshold = threshold / 2;
 end
