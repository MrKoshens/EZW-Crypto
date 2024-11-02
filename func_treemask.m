function mask = func_treemask(x,y,dim);

%  x, y is the position in the matrix of the node where the EZW tree
%  should start; top left is x=1 y=1
%
%  dim is the dimension of the mask (should be the same dimension as
%  the wavelet data)
%
%  Copyright 2002  Paschalis Tsiaflakis, Jan Vangorp

mask = zeros(dim);

x_min = x;
x_max = x;
y_min = y;
y_max = y;

while(x_max <= dim & y_max <= dim),
   mask(x_min:x_max, y_min:y_max) = 1;
   
   % calculate new subset
   x_min = 2*x_min - 1;
   x_max = 2*x_max;
   y_min = 2*y_min - 1;
   y_max = 2*y_max;
end