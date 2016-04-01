Polynomial Regression
=====================

I tried to fit a polynomial model for the data provided in problem1.mat. After attempting various choices of d - the degree of polynomial I found that the optimal value is 8 for the given model. 


Files
-----
polyfit.m:- Loads problem1.mat dataset and invokes polyreg.m to find the loss across various polynomial degree values and plot the same. It also finds the minimum loss at a particular value of polynomial degree. Values of d in the range of 8 to 20 are reasonable as the risk minimizes in that range as seen in the image below.

crossvalidate.m:- Splits the dataset in problem1.mat in to 2 halves and treats one half as train data and the other half as test. Then it finds the optimal value of degree of polynomial d which doesn't overfit the data and the loss on test data is minimum.

testcrossvalidate.m:- Used to launch crossvalidate.m and run cross validation on problem1.mat dataset. Marks the minimum testing error and corresponding lamda across 100 iterations on the regularized risk and testing risk plot After executing testcrossvalidate.m we get the below two graphs and the minimum error of 9.3712e+20 at d = 8.

