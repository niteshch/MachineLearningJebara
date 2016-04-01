Multivariate Regression
=====================

In this problem I tried to perform multivariate regression with regularized risk minimization on problem2.mat. I used two-fold cross validation to find the optimal value of regularization parameter.

Files
-----
multireg.m:- Finds a model to t the multidimensional data using regularization

crossvalidatereg.m:- crossvalidatereg.m splits the dataset in problem2.mat in to 2 halves and treats one half as train data and the other half as test. Then it finds the optimal value of regularization parameter lambda which doesn't overfit the data and the loss on test data is minimum.

testcrossvalidatereg.m:- Used to launch crossvalidatereg and run cross validation on problem2.mat dataset. Marks the minimum testing error and corresponding lamda across 100 iterations on the regularized risk and testing risk plot.
