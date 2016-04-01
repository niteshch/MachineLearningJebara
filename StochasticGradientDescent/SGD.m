function [P1JwArray,P1error_count,P1timeArray] = SGD(TrainingX,TrainingY,TestX,TestY,p)
    N = size(TrainingX,1);
    rbfKernel = zeros(1000);
    rbfKernelTest = zeros(1000);
    kSquare = 0;
    
    epsilon = 0.0001;
    eta = 0.004;
    lambda = 0.6;
    iter = 1;
    P1timeArray = [];
    P1JwArray = [];
    P1error_count = [];
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
    
    
    pts = randperm(1000);
    indexRange = pts(1:p);
    TrX = TrainingX(indexRange,:);
    TrY = TrainingY(indexRange);
    
    Jw = (-1/N)*(log((1 + exp(-(W'*rbfKernel*TrainingY))).^-1)) + (lambda*W'*W);
    
    misclassCount = 0;
    misclassPts = [];
    misclassPtIndex = [];
    misclassY = [];
    
    for i=1:p
        temp = sigma(W'*rbfKernel(indexRange(i),:)');
        if temp > 0.5
            output = 1;
        else
            output = -1;
        end
        if output ~= TrY(i)
            misclassCount = misclassCount + 1;
            misclassPts = [misclassPts; TrX(i)];
            misclassPtIndex = [misclassPtIndex; indexRange(i)];
            misclassY = [misclassY; TrY(i)];
        end              
    end
    
    
    
    gradJw = zeros(size(W));
    temp = zeros(size(W));
    for i=1:misclassCount
        temp = temp + misclassY(i).*rbfKernel(indexRange(i),:)' - sigma(misclassY(i).*W'*rbfKernel(indexRange(i),:)').*misclassY(i).*rbfKernel(indexRange(i),:)';
    end
    gradJw = gradJw  - temp/N + 2*lambda*W;
    
    P1JwArray(iter,1) = Jw;
    
    Wnew = W - eta*gradJw;
    
    diff = norm(Wnew - W);
    tStart = tic;
    
    while(diff >= epsilon)
        W = Wnew;
        
        Jw = (-1/N)*(log((1 + exp(-(W'*rbfKernel*TrainingY))).^-1)) + (lambda*W'*W);
        misclassCount = 0;
        misclassPts = [];
        misclassPtIndex = [];

        for i=1:p
            temp = sigma(W'*rbfKernel(indexRange(i),:)');
            if temp > 0.5
                output = 1;
            else
                output = -1;
            end
            if output ~= TrY(i)
                misclassCount = misclassCount + 1;
                misclassPts = [misclassPts; TrX(i)];
                misclassPtIndex = [misclassPtIndex; indexRange(i)];
                misclassY = [misclassY; TrY(i)];
            end              
        end


        gradJw = zeros(size(W));
        temp = zeros(size(W));
        for i=1:misclassCount
            temp = temp + misclassY(i).*rbfKernel(indexRange(i),:)' - sigma(misclassY(i).*W'*rbfKernel(indexRange(i),:)').*misclassY(i).*rbfKernel(indexRange(i),:)';
        end
        gradJw = gradJw  - temp/N + 2*lambda*W;
        
        Wnew = W - eta*gradJw;
        
        P1JwArray(iter,1) = Jw;
        
        resultY = sigma(Wnew' * rbfKernelTest);
        resultY = resultY';
        resultY(resultY > 0.5) = 1;
        resultY(resultY <= 0.5) = -1;
        
        P1error_count(iter,1) = numel(find(resultY~=TestY));
        
        iter = iter+1;
        tElapsed = toc(tStart);
        if tElapsed > 20
            break;
        end
        P1timeArray(iter,1) = tElapsed;
    end
    
end