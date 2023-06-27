function XX = standardization(X)
    [n,d] = size(X);
    for i = 1:d
        temp_feature = X(:,i);
        XX(:,i) = (temp_feature-mean(temp_feature))/(std(temp_feature)+eps);
    end
end