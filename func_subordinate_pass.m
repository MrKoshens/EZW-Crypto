function [encoded, subordinate_list] = func_subordinate_pass(subordinate_list, threshold);
%
%  subordinate_list: current subordinate list containing coefficietns that are
%                    alreday detected as significant
%                    first row is the original coefficient
%                    second row is current reconstruction value of this coefficient
%                    this list should be in the correct scan order to reduce complexity
%                    of decoder (Morton)
%  threshold: current threshold to use when comparing
%
%  encoded: matrix containing 0's and 1's for refinement of the suborinate list
%  subordinate_list: new subordinate_list (second row containing reconstruction values
%                    is updated to the include refinement -> new reconstuction values)
%
%  Copyright 2002  Paschalis Tsiaflakis, Jan Vangorp
%  Revision 1.0  9/11/2002 19.00u


% compare to threshold + threshold/2; bigger = 1, smaller = 0
encoded = zeros(1,size(subordinate_list,2));
encoded(find(abs(subordinate_list(1,:)) > abs(subordinate_list(2,:)))) = 1;

% update subordinate_list(2,:) (reconstructed values)
for i = 1:length(encoded),
    if(encoded(i) == 1),
        if(subordinate_list(1,i) > 0),
            subordinate_list(2,i) = subordinate_list(2,i) + threshold/4;
   	    else
      	    subordinate_list(2,i) = subordinate_list(2,i) - threshold/4;
        end
    else
   	    if(subordinate_list(1,i) > 0),
          	subordinate_list(2,i) = subordinate_list(2,i) - threshold/4;
   	    else
      	    subordinate_list(2,i) = subordinate_list(2,i) + threshold/4;
   	    end
    end
end
