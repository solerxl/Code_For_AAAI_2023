function W = gp(M,k)
for dd = 1:size(M,1)
    w(dd) = M(dd,:)*M(dd,:)';
end
w = w';
epsilon = zeros(1,size(w,1));
[num,ind] = sort(w,'descend');
W = zeros(size(M));
W(ind(1:k),:) = M(ind(1:k),:);
end