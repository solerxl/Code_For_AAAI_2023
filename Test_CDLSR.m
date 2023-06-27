function [index,W,obj,obj_curv,spend_time] = Test_CDLSR(X,Y,k,W_init,A,B)
%% Coordinate Descent Test code
% X: d x n
% Y: c x n

ind = find(W_init(:,1)~=0);
temp = eye(size(W_init,1));
S_init = temp(:,ind);
V_init = W_init(ind,:);
[W,index,obj_curv,spend_time] = Algorithm_CDLSR(X,Y,k,S_init,V_init,A,B);
obj = total_objective_new(W,X,Y);