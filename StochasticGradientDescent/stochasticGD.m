clear
clc
load('data1.mat');

[JwArray,error_count,timeArray] = gradientDescent(TrainingX,TrainingY,TestX,TestY);
[P1JwArray,P1error_count,P1timeArray] = SGD(TrainingX,TrainingY,TestX,TestY,1);
[P2JwArray,P2error_count,P2timeArray] = SGD(TrainingX,TrainingY,TestX,TestY,100);

figure();
plot(timeArray,error_count);
xlabel('Time');
ylabel('Misclassified Points');
title('Misclassified points over time for gradient descent');

figure();
plot(P1timeArray,P1error_count);
xlabel('Time');
ylabel('Misclassified Points for P = 1');
title('Misclassified points over time for SGD for P = 1');

figure();
plot(P2timeArray,P2error_count);
xlabel('Time');
ylabel('Misclassified Points for P = 100');
title('Misclassified points over time for SGD for P = 100');

figure();
plot(timeArray,JwArray);
xlabel('Time');
ylabel('Cost');
title('Cost over time for gradient descent');

figure();
plot(P1timeArray,P1JwArray);
xlabel('Time');
ylabel('Cost for SGD P = 1');
title('Cost over time for SGD P = 1');

figure();
plot(P2timeArray,P2JwArray);
xlabel('Time');
ylabel('Cost for SGD P = 100');
title('Cost over time for SGD P = 100');

figure();
plot(timeArray,JwArray,'r',P1timeArray,P1JwArray,'b',P2timeArray,P2JwArray,'g');
legend('Gradient Cost','SGD Cost for P = 1','SGD Cost for Pclos = 100');
