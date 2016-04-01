function [ val ] = sigma( matrix )
    val = zeros(size(matrix));
     for i=1:size(matrix,1)
         for j=1:size(matrix,2)
              val(i,j) = 1/(1 + exp(-matrix(i,j)));
         end
     end
end

