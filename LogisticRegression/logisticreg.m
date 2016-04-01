%
% Problem 4
%
% Used to perform logistic regression on dataset4. Provides 3 plots a)
% Decision boundary over data, b) Risk over the number of iterations and
% c) Number of misclassified points over the number of iterations for data
% in dataset4.
%
load 'dataset4.mat';

theta = rand(size(X,2),1);
    
n = length(Y);
iter = 1;
Remp_history = [];
error_count = [];
eta = 0.76;
epsilon = 10^(-5);
while 1
    z = X*theta;
    sigfn = (1+exp(-z)).^(-1);
    gradRemp = (1/n)*(X'*(sigfn-Y));
    Remp_history(iter,1) = (1/n)*((Y-1)'*log(1-sigfn) - Y'*log(sigfn));
    
    theta = theta - eta*gradRemp;
    
    %misclassification count
    Y_temp = (sigfn > 0.5);
    error_count(iter,1) = numel(find(Y_temp~=Y));
    
    if iter > 1 &&  (abs(Remp_history(iter,1) - Remp_history(iter-1,1)) <= epsilon) 
        break
    end
    iter = iter + 1;
end

fprintf('Number of iterations %d ',iter);
figure();
title('Decision Boundary');
pos = find(Y == 1); 
neg = find(Y == 0);
plot(X(pos, 1), X(pos, 2), 'k+','LineWidth', 2,'MarkerFaceColor','b', 'MarkerSize', 4);
hold on
plot(X(neg, 1), X(neg, 2), 'ko', 'MarkerFaceColor', 'r', 'MarkerSize', 4);

plot_x = [min(X(:,1)),  max(X(:,1))];
plot_y = -(1./theta(2)).*(theta(1).*plot_x + theta(3));
plot(plot_x, plot_y)
legend('Positive','Negative','Decision Boundary');
hold off

figure();
plot(Remp_history,'b');
title('Risk Plot');
xlabel('Number of iterations');
ylabel('Risk');

figure();
title('Binary classification error');
plot(error_count, 'b');
xlabel('Number of iterations');
ylabel('Misclassified Points');