function [signif_map, subordinate_list, data] = func_dominant_pass(img_wavedata, threshold, scan);
%
%  img_wavedata: wavelet coefficients, if this step is not using the initial theshold
%            the returned 'data' from the previous step should be used (to
%            correctly process already processed coefficients)
%  threshold: threshold to use for this step, initial threshold should be
%            pow2(floor(log2(max(max(abs(img_wavedata))))))
%  scan: scan order to use when processing img_wavedata matrix
%        (currently only Morton scan order supported)
%
%  signif_map: returned string containing the significance info for the data in
%              img_wavedata using 'threshold' as threshold
%              'p' significant positive
%              'n' significant negative
%              'z' isolated zero
%              't' zerotree root
%  subordinate_list: list containing the coefficients that are detected significant
%                    in _this_ step
%                    first row is the original coefficient
%                    second row is first reconstruction value of this coefficient
%  data: new wavelet coefficients to use in the next step
%
%  Copyright 2002  Paschalis Tsiaflakis, Jan Vangorp


% wavelet coefficients are saved to undo bookkeeping actions
data = img_wavedata;
dim = size(img_wavedata,1);

% significance map
signif_map = [];
signif_index = 1;

% subordinate list
subordinate_list = [];
subordinate_index = 1;

for element = 1:dim*dim;
    % get matrix index for element
    row = scan(element,1)+1;
    column = scan(element,2)+1;

    % check whether element should be processed
    if(~isnan(data(row, column)) & data(row, column) < realmax),
        % determine type of element
        if(data(row,column) >= threshold), % element is significant positive
            signif_map(signif_index) = 'p';
            signif_index = signif_index + 1;
            
            subordinate_list(1, subordinate_index) = data(row, column);
            % first reconstructed value
            subordinate_list(2, subordinate_index) = threshold + threshold/2;
            subordinate_index= subordinate_index + 1;
            
            % mark element as processed
            data(row, column) = 0;   
            
        elseif(data(row,column) <= -threshold), % element is significant negative
            signif_map(signif_index) = 'n';
            signif_index = signif_index+ 1;
            
            subordinate_list(1, subordinate_index) = data(row, column);
            % first reconstructed value
            subordinate_list(2, subordinate_index) = -threshold - threshold/2;
            subordinate_index= subordinate_index + 1;
            
            % mark element as processed
            data(row, column) = 0;
            
        else % determine wether element is zerotree root
            % select EZW tree for element
            if(row<dim/2 | column<dim/2),
                mask = func_treemask(row,column,dim);
            else % shortcut treemask processing (element has no tree under it)
                if(abs(data(row, column)) < threshold),
                    % element is zerotree root
                    signif_map(signif_index) = 't';
                    signif_index = signif_index + 1;
                
                    % mark elements as processed (only for this pass!)
                    data(row, column) = realmax;
                else % element is isolated zero
                    signif_map(signif_index) = 'z';
                    signif_index = signif_index + 1;
                end
            end
            masked = data .* mask;
        
            % compare data to threshold
            if(isempty(find(abs(masked) >= threshold))),
                % element is zerotree root
                signif_map(signif_index) = 't';
                signif_index = signif_index + 1;
                
                % mark elements as processed (only for this pass!)
                data = data +  (mask*realmax);
            else % element is isolated zero
                signif_map(signif_index) = 'z';
                signif_index = signif_index + 1;
            end
        end
    end
end

index = find(data == realmax);
data(index) = img_wavedata(index);
