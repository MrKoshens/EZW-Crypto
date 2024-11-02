function img_wavedata_dec = func_ezw_decode(dim, threshold, significance_map, refinement);
%  dim: dimension of the wavelet matrix to reconstruct
%  threshold: initial threshold used while encoding
%  significance_map: a string matrix containing significance data for
%  different scanning passes ('p','n','z','t'), where each row contains
%  data for a different scanning pass.
%
%  refinement: a string matrix containing refinement data for
%  different scanning passes ('0' or '1'), where each row contains data for
%  a different scanning pass.
%
%  img_wavedata_dec: reconstructed wavelet coefficients
%

img_wavedata_dec = zeros(dim,dim);

% calculate Morton scan order
scan = func_morton([0:(dim*dim)-1],dim);

% number of steps significance map (and refinement data)
steps = size(significance_map,1);

for step = 1:steps,
    % decode significancemap for this step
    img_wavedata_dec = func_decode_significancemap(img_wavedata_dec, significance_map(step,:), threshold, scan);

    img_wavedata_dec = func_decode_refine(img_wavedata_dec, refinement(step,:), threshold, scan);

    threshold = threshold/2;

end