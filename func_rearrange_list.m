function subordinate_list = func_rearrange_list(orig_list, add_list, scan, wavedata);

%  orig_list: original subordinate list, this is the old subordinate list
%             (in scan order!)
%  add_list: new subordinate list items that should be added to the subordinate
%            list while maintaining scan order
%  scan: scan order to use
%  wavedata: _original_ wavelet coefficients (used to determine correct order
%            for subordinate list
%
%  subordiante_list: new subordiante list in scan order
%
%  Copyright 2002  Paschalis Tsiaflakis, Jan Vangorp
%  Revision 1.0  10/11/2002 19.00u


subordinate_list = [];
o_index = 1; % index original_list
a_index = 1; % index add_list

for element = 1:size(scan,1),
   row = scan(element,1)+1;
   column = scan(element,2)+1;
   
   % test index before list, otherwise you get out of matrix dimensions!!
   if(size(orig_list,2) >= o_index & wavedata(row, column) == orig_list(1,o_index)),
      subordinate_list = [subordinate_list orig_list(:,o_index)];
      o_index = o_index + 1;
   elseif(size(add_list,2) >= a_index & wavedata(row, column) == add_list(1,a_index)),
      subordinate_list = [subordinate_list add_list(:,a_index)];
      a_index = a_index + 1;      
   end
end
