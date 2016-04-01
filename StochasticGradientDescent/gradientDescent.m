function [JwArray,error_count,timeArray] = gradientDescent(TrainingX,TrainingY,TestX,TestY)
    N = size(TrainingX,1);
    rbfKernel = zeros(1000);
    rbfKernelTest = zeros(1000);
    kSquare = 0;
    
    error_count = [];
    epsilon = 0.0001;
    eta = 0.04;
    lambda = 1;
    iter = 1;
    timeArray = [];
    W = rand(1000,1);
    
    for i=1:1000
        for j=1:1000
            kSquare = kSquare + ((norm(TrainingX(i,:) - TrainingX(j,:)))^2);
        end
    end
    kSquare = kSquare/(N^2);
    
    for i=1:1000
        for j=1:1000
            v = (norm(TrainingX(i,:) - TrainingX(j,:))^2)/kSquare;
            rbfKernel(i,j) = exp(-v);
        end
    end
    
    for i=1:1000
        for j=1:1000
            v = (norm(TrainingX(i,:) - TestX(j,:))^2)/kSquare;
            rbfKernelTest(i,j) = exp(-v);
        end
    end
    
    Jw = (-1/N)*(log((1 + exp(-(W'*rbfKernel*TrainingY))).^-1)) + (lambda*W'*W);
    gradJw = zeros(size(W));
    temp = zeros(size(W));
    for i=1:N
        temp = temp + TrainingY(i).*rbfKernel(i,:)' - sigma(TrainingY(i).*W'*rbfKernel(i,:)').*TrainingY(i).*rbfKernel(i,:)';
    end
    gradJw = gradJw  - temp/N + 2*lambda*W;
    
    JwArray(iter,1) = Jw;
    
    Wnew = W - eta*gradJw;
    
    diff = norm(Wnew - W);
    tStart = tic;
    while(diff >= epsilon)
        W = Wnew;
        
        Jw = (-1/N)*(log((1 + exp(-(W'*rbfKernel*TrainingY))).^-1)) + (lambda*W'*W);
        gradJw = zeros(size(W));
        temp = zeros(size(W));
        for i=1:N
           temp = temp + TrainingY(i).*rbfKernel(i,:)' - sigma(TrainingY(i).*W'*rbfKernel(i,:)').*TrainingY(i).*rbfKernel(i,:)';
        end
        
        gradJw = gradJw  - temp/N + 2*lambda*W;
        
        Wnew = W - eta*gradJw;
        
        JwArray(iter,1) = Jw;
        
        resultY = sigma(Wnew' * rbfKernelTest);
        resultY = resultY';
        resultY(resultY > 0.5) = 1;
        resultY(resultY <= 0.5) = -1;
        
        
        
        error_count(iter,1) = numel(find(resultY~=TestY));
        
        iter = iter+1;
        tElapsed = toc(tStart);
        if tElapsed > 20
            break;
        end
        timeArray(iter,1) = tElapsed;
    end
    
end