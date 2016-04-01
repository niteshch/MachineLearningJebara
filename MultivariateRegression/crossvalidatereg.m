function [errMin,lambda,errTrain,errTest,lambdavec] = crossvalidatereg( filename,lambdamax )
% 
% Problem 2
% 
% crossvalidatereg.m splits the dataset in problem2.mat in to 2 halves
% and treats one half as train data and the other half as test.
% The it finds the optimal value of regularization parameter lambda which doesn't
% overfit the data and the loss on test data is minimum.
%      
%       function [lambda] = crossvalidate(filename,lambdamax)
%
% filename = file name containing dataset to be loaded
% lambdamax = maximum value of regularization parameter lambda to check crossvalidation
% errMin = for a particular value of lambda and random split
% lambda = best choice of regularization parameter
% errTrain = regularized training error vector
% errTest = testing error vector
% lambdavec = regularization parameter 'lambda' vector
%
% Example Usage:
%
% [minErr,lambda, errTrain, errTest, lambdaVector] = crossvalidatereg('problem2.mat',1000)
%

d = 0;
load(filename);
errTrain = zeros(lambdamax,1);
errTest = zeros(lambdamax,1);
lambdavec = zeros(lambdamax,1);
[Train, Test] = crossvalind('HoldOut', size(x,1), 0.5);
xTrain = x(Train,:);
yTrain = y(Train,:);
xTest = x(Test,:);
yTest = y(Test,:);

for lambdaval = 1:lambdamax
   [errTrain(lambdaval,1),model,errTest(lambdaval,1)] = multireg(xTrain,yTrain,lambdaval,xTest,yTest);
   lambdavec(lambdaval,1) = lambdaval;
end
[errMin,lambda] = min(errTest);
end

