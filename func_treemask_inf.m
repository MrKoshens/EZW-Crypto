function mask = func_treemask_inf(x, y, dim);

%  x y is the position in the matrix of the node where the EZW tree
%  should start; top left is x=1 y=1
%
%  dim is the dimension of the mask (should be the same dimension as
%  the wavelet data)
%
%  mask is the returnend matrix to select the relevant coefficients
%  from the wavelet coefficient matrix
%  selected = mask .* wavelet_matrix;
%  Copyright 2002  Paschalis Tsiaflakis, Jan Vangorp
%  Revision 1.0  10/11/2002 19.00u

mask = zeros(dim);

x_min = x;
x_max = x;
y_min = y;
y_max = y;

while(x_max <= dim & y_max <= dim),
   mask(x_min:x_max, y_min:y_max) = inf;
   
   % calculate new subset
   x_min = 2*x_min - 1;
   x_max = 2*x_max;
   y_min = 2*y_min - 1;
   y_max = 2*y_max;
end