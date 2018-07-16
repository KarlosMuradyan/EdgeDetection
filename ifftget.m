function [k] = ifftget(f)
  
  f1 = abs(f);
  fm = max(f1(:));
  k = f1/fm;
  
end
