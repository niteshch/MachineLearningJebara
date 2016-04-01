function [errMin,d,errTrain,errTest] = crossvalidate(x,y,maxdeg)
% Problem 1
% crossvalidate.m splits the dataset in problem1.mat in to 2 halves
% and treats one half as train data and the other half as test.
% The it finds the optimal value of degree of polynomial d which doesn't
% overfit the data and the loss on test data is minimum.
%      
%       function [d] = crossvalidate(filename,maxdeg)
%
% filename = file name containing dataset to be loaded
% maxdeg = maximum value of degree of polynomial to check crossvalidation
% d = best choice of degree of polynomial for no overfitting
% errTrain = Training error
% errTest = Testing error
% errMin = Minimum testing error
%
% Example Usage:
%
% [errMin,d,errTrain,errTest] = crossvalidate(x,y,50)

errTrain = zeros(maxdeg,1);
errTest = zeros(maxdeg,1);
polydeg = zeros(maxdeg,1);
[Train, Test] = crossvalind('HoldOut', size(x,1), 0.5);
xTrain = x(Train);
yTrain = y(Train);
xTest = x(Test);
yTest = y(Test);
for D = 1:maxdeg
   [errTrain(D,1),model,errTest(D,1)] = polyreg(xTrain,yTrain,D,xTest,yTest);
   polydeg(D,1) = D;
end
[errMin,d] = min(errTest);
end