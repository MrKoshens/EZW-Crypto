function img_wavedata_dec = func_decode_significancemap(img_wavedata_dec, significance_map, threshold, scan);

%  img_wavedata_dec: input wavelet coefficients
%  significance_map: string containing the significance map ('p','n','z' and 't')
%  threshold: threshold to use during this decoding pass (dominant pass)
%  scan: scan order to use (Morton)
%
%  img_wavedata_dec: the decoded wavelet coefficients
%

backup = img_wavedata_dec;

n = size(img_wavedata_dec,1);
index = 1;


for element = 1:n*n;
    % get matrix index for element
    row = scan(element,1)+1;
    column = scan(element,2)+1;

    % check whether element should be processed
    if(isfinite(img_wavedata_dec(row, column))),

        % determine type of element
        if(significance_map(index) == 'p'), % element is significant positive
           img_wavedata_dec(row, column) = threshold + threshold/2;
        elseif(significance_map(index) == 'n'), % element is significant negative
           img_wavedata_dec(row, column) = -threshold - threshold/2;
        elseif(significance_map(index) == 'z'), % element is isolated zero
           img_wavedata_dec(row, column) = 0;
        else
           % element is zerotree root ('t')
           img_wavedata_dec(row, column) = 0;
           
           % mark decendants as inf
           mask = func_treemask_inf(row,column,n);
           img_wavedata_dec = img_wavedata_dec + mask;
        end
        index = index + 1;
    end
end

% inf should be restored to 0
img_wavedata_dec(find(img_wavedata_dec > realmax)) = 0;

% original img_wavedata_dec was overwritten with 0: restore
img_wavedata_dec = img_wavedata_dec + backup;
