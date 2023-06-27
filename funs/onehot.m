function [y_matrix] = onehot(y)
    n = size(y,1);
    unique_y = unique(y);
    c = size(unique_y,1);
    y_matrix = zeros(n,c);
    for i = 1:c
        y_matrix(y == unique_y(i),i) = 1;
    end
end

