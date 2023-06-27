function [Wt,index,obj,spend_time]= Algorithm_CDLSR(X,Y,k,S_init,V_init,A,B)

[dim,~] = size(X);
[c,~] = size(Y);
temp = eye(dim);

S = S_init;
V = V_init;
index = find(sum(S_init,2));

W_init = zeros(dim,c);

maxite = 1000;

Wt = W_init;
Wt(index,:) = V;
obj = [total_objective_new(Wt,X,Y)];
tic
for ii= 1:maxite
    STAS = A(index,:);
    STAS = STAS(:,index);
    tempS = STAS+0.0000001*eye(k);
    V= (tempS)\B(index,:);
    VVT = V*V';
    for j = 1:k
        index(j) = findmin(V,VVT,A,B,index,j);
    end
    Wt = W_init;
    Wt(index,:) = V;
    obj = [obj,total_objective_new(Wt,X,Y)];
    if(ii>4 && abs((obj(end)-obj(end-1))/(obj(end-1)+eps))<=0.0001 && abs((obj(end-1)-obj(end-2))/(obj(end-2)+eps))<=0.0001 && abs((obj(end-2)-obj(end-3))/(obj(end-3)+eps))<=0.0001)
        break
    end
end
spend_time = toc;

Wt = W_init;
Wt(index,:) = V;



    function temp_obj = objective_S(V,VVT,A,B,p,xi_p,index)
        E = A(index,:);
        E = E(:,index);
        temp_obj = E(p,:)*VVT(:,p)+VVT(p,:)*E(:,p)-VVT(p,p)*E(p,p)-2*B(xi_p,:)*V(p,:)';
    end

    function ind = findmin(V,VVT,A,B,index,j)
        d = size(A,1);
        epsilon = zeros(d,1);                   % epsilon record the selected features 
        epsilon(index) = 1;
        tempind = index(j);
        epsilon(tempind) = 0;
        min_obj = objective_S(V,VVT,A,B,j,tempind,index);
        ind = index(j);
        candidates = find(epsilon==0);
        for i = candidates'
            index(j) = i;
            tem_obj = objective_S(V,VVT,A,B,j,i,index);
            if(tem_obj<=min_obj)
                min_obj = tem_obj;
                ind = i;
            end
        end
    end
end