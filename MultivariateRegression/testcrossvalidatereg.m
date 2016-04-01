%
% Problem 2
%
% Used to launch crossvalidatereg and run cross validation on problem2.mat
% dataset. Marks the minimum testing error and corresponding lamda across
% 100 iterations on the regularized risk and testing risk plot
%
num_iters=100;
errTestVec = zeros(num_iters,1);
lambdaOpt = zeros(num_iters,1);
errTrainParent = cell(num_iters,1);
errTestParent = cell(num_iters,1);
lambdaVecParent = cell(num_iters,1);
for i = 1:num_iters
   [minErr,lambda, errTrain, errTest, lambdaVector] = crossvalidatereg('problem2.mat',1000);
   errTestVec(i,1) = minErr;
   lambdaOpt(i,1) = lambda;
   errTrainParent{i} = errTrain;
   errTestParent{i} = errTest;
   lambdaVecParent{i} = lambdaVector;
end
val = min(errTestVec);
ind = find(errTestVec == val);
lambdamin = lambdaOpt(ind);
disp(val);
disp(lambdamin);
errTrain = errTrainParent{ind};
errTest = errTestParent{ind};
lambdavec = lambdaVecParent{ind};
figure();
plot(lambdavec.^(-1),errTrain,'r');
hold on
plot(lambdavec.^(-1),errTest,'b');
plot(lambdamin^(-1),val,'x','MarkerSize',10);
title('Plot of Risk over the selection of Regularization Parameter');
xlabel('Regularization Parameter(1/lambda)');
ylabel('Risk');
legend('Regularized Training Risk','Testing Risk');