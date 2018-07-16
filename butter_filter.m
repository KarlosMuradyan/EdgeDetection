function [out] = butter_filter( image, d, n )
  
  disp(d);
  height = size(image,1);
  width = size (image, 2);
  [x,y] = meshgrid ( -floor(width/2):floor((width-1)/2), -floor(height/2):floor((height-1)/2));
  out = 1./(1. + (d./(x.^2 + y.^2).^0.5).^(2*n));
  
end
