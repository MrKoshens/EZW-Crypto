function [significance_map, refinement] = func_huffman_decode(img_ezw_stream_bit);

%  significance map: a string array containing significace map data ('p','n','z' and 't')
%  refinement: a string array containing refinement data ('0' and '1')
%
%  img_ezw_stream_bit: input bitstream ('0' and '1')
%
%  Copyright 2002  Paschalis Tsiaflakis, Jan Vangorp
%  Revision 1.0  10/11/2002 19.00u

significance_map = [];
refinement = [];

complete = 0;
decode = 1;
index = 1;
significance = [];
refine = [];

while(decode),
    % get bit
    bit = img_ezw_stream_bit(index);
    index = index + 1;
    if(bit == '1'),
        % get next bit
        bit = img_ezw_stream_bit(index);
        index = index + 1;
        if(bit == '1'),
            % get next bit
            bit = img_ezw_stream_bit(index);
            index = index + 1;
            if(bit == '1'),
                % get next bit
                bit = img_ezw_stream_bit(index);
                index = index + 1;
                if(bit == '1'),
                    % seperator detected
                    complete = 1;
                else
                    significance = [significance, 'p'];
                end
            else
                significance = [significance, 'n'];
            end
        else
            significance = [significance, 'z'];
        end
    else
        significance = [significance, 't'];
    end
    
    if(complete),
        complete = 0;
        % get size of refinement data (next 20 bits)
        stringlength = bin2dec(img_ezw_stream_bit(1,index:index+19));
        index = index + 20;
        refine = [refine img_ezw_stream_bit(1,index:index+stringlength-1)];
        index = index + stringlength;

        % update significance map and refinement data
        significance_map = strvcat(significance_map, significance);
        refinement = strvcat(refinement, refine);
        significance = [];
        refine = [];
    end
    
    % check for end of stream ('11111')
    bits = img_ezw_stream_bit(1,index:index+4);
    if(strcmp(bits, '11111')),
        decode = 0;
    end
end