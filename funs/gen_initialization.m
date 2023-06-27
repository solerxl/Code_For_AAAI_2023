function [W_init,S_init,V_init] = gen_initialization(k,d,c)
    W_init = rand(d,c);
    W_init = gp(W_init,k);
    ind = find(W_init(:,1)~=0);
    temp = eye(size(W_init,1));
    S_init = temp(:,ind);
    V_init = W_init(ind,:);
end