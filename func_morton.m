function scan = func_morton(pos,n);

%  The matrix should be n by n
%  For position we start counting from 0
%
%  position = [0:(n*n)-1];
%  scan = morton(position, n);
%  Copyright 2002  Paschalis Tsiaflakis, Jan Vangorp
%  Revision 1.0  10/11/2002 19.00u

bits = log2(n*n); % number of bits needed to represent position
bin = dec2bin(pos(:),bits); % convert position to binary

% odd bits represent row number
% even bits represent column number

scan = [bin2dec(bin(:,1:2:bits-1)), bin2dec(bin(:,2:2:bits))];