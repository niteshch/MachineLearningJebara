%
% Problem 1
% Loads problem1.mat dataset and invokes polyreg.m to 
% find the loss across various polynomial degree values and plot the same.
% It also finds the minimum loss at a particular value of polynomial degree.
%
load('problem1.mat');
loss = zeros(50,1);
polydeg = zeros(50,1);
for D = 1:50
   [loss(D,1),model] = polyreg(x,y,D); 
   polydeg(D,1) = D;
end
hold off
[minloss,d] = min(loss,[],1);
fprintf('Minimum loss is %0.4f and occurs at polynomial degree d = %d',minloss,d);
figure();
plot(polydeg,loss,'r');
title('Plot of Risk over the selection of polynomial degree');
xlabel('Polynomial Degree'); % x-axis label
ylabel('Risk'); % y-axis label
