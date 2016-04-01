% Problem 1
% Used to launch crossvalidate.m and run cross validation on problem1.mat
% dataset. Marks the minimum testing error and corresponding lamda across
% 100 iterations on the regularized risk and testing risk plot
%
load('problem1.mat');
num_iters=100;
errTestVec = zeros(num_iters,1);
polydegVec = zeros(num_iters,1);
errTrainParent = cell(num_iters,1);
errTestParent = cell(num_iters,1);
for i = 1:num_iters
   [minErr,d,errTrain, errTest] = crossvalidate(x,y,25);
   errTestVec(i,1) = minErr;
   polydegVec(i,1) = d;
   errTrainParent{i} = errTrain;
   errTestParent{i} = errTest;
end
val = min(errTestVec);
ind = find(errTestVec == val);
polydeg = polydegVec(ind);
disp(val);
disp(polydeg);
errTrain = errTrainParent{ind};
errTest = errTestParent{ind};

polyreg(x,y,polydeg);
figure();
plot(errTrain,'r');
hold on
plot(errTest,'b');
title('Plot of Risk over the selection of polynomial degree');
xlabel('Polynomial Degree');
ylabel('Risk');
legend('Training Risk','Testing Risk');