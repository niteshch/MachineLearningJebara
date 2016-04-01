function [err,model,errT] = multireg(x,y,lambda,xT,yT)
%
% Problem 2
% Finds a model to fit the multidimensional data using regularization
%
%    function [err,model,errT] = multireg(x,y,D,xT,yT)
%
% x = vector of input scalars for training
% y = vector of output scalars for training
% lambda = the regularization parameter
% xT = vector of input scalars for testing
% yT = vector of output scalars for testing
% err = average squared loss on training
% model = vector of polynomial parameter coefficients
% errT = average squared loss on testing
%
% Example Usage:
%
xxTrans = x'*x;
regParam = lambda*eye(size(xxTrans));
model = inv(xxTrans + regParam)*(x'*y);
err   = (1/(2*size(x,1)))*sum((y-x*model).^2) + ((lambda/(2*size(x,1)))*(model'*model));

if (nargin==5)
  errT  = (1/(2*size(xT,1)))*sum((yT-xT*model).^2) ;
end

% x = 3*(rand(50,1)-0.5);
% y = x.*x.*x-x+rand(size(x));
% [err,model] = polyreg(x,y,4);
%

