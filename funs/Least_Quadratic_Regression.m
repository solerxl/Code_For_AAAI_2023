function [Wt,obj] = Least_Quadratic_Regression(X,Y)
% X; n x d
% Y: n x c
% W: d x c


maxiter = 10000;
alpha = 0.00001;

obj = [];

% Wt = (X'*X)\X'*Y;

Wt = zeros(size(X,2),size(Y,2));

for i = 1:maxiter
    Mt = Wt-alpha*X'*(X*Wt-Y);
    Wt = Mt;
    obj = [obj, objective_function(X,Wt,Y)];
    
    if  i>=3 && abs((obj(i)-obj(i-1))/obj(i-1))<=0.00001
        break
    end
end

    function obj = objective_function(X,W,Y)
        obj = sum(sum((X*W-Y).^2));
    end
end