function img_wavedata_dec = func_decode_refine(img_wavedata_dec, refinement, threshold, scan);
%
%  img_wavedata_dec: input wavelet coefficients
%  refinement: string containing refinement data ('0' and '1')
%  threshold: threshold to use during this refinement pass
%  scan: scan order to use (Morton)
%
%  img_wavedata_dec: the refined wavelet coefficients
%

n = size(img_wavedata_dec,1);
index = 1;

for element = 1:n*n;
    % get matrix index for element
    row = scan(element,1)+1;
    column = scan(element,2)+1;
    
    % check whether element should be processed
    if(img_wavedata_dec(row, column) ~= 0),
       % get refinement data
       ref = refinement(index);
       
       % if refinement bit is 1, add T/4 to current value
       % if refinement bit is 0, subtract T/4 from current value
       if(ref == '1'),
          if(img_wavedata_dec(row, column) > 0),
             img_wavedata_dec(row, column) = img_wavedata_dec(row, column) + threshold/4;
          else
             img_wavedata_dec(row, column) = img_wavedata_dec(row, column) - threshold/4;
          end
       else
          if(img_wavedata_dec(row, column) > 0),
             img_wavedata_dec(row, column) = img_wavedata_dec(row, column) - threshold/4;
          else
             img_wavedata_dec(row, column) = img_wavedata_dec(row, column) + threshold/4;
          end
       end
       index = index + 1;
    end
end
