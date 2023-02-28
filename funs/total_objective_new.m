function temobj = total_objective_new(W,X,Y)
% X: d x n
% Y: c x n
% W: d x c
    [d,n] = size(X);
    H = eye(n,n)-ones(n,1)*ones(1,n)/n;
    temobj = trace((W'*X*H-Y*H)'*(W'*X*H-Y*H));
    
end