% selected_ind_CD: record of selected features
% W_CD: learned coefficient matrix
% obj_curv_CD: loss value curve
% obj_CD: convergent loss value
% spend_time_CD: record of running time

clear;clc
addpath(genpath('./'))
%% Set Parameters
filename = {'SRBCTML'};
Max_datanum = length(filename);

%% Parameter Setting
maxiter = 40;                       % number of random initialization
init_type_list = 1;                 % initialize flag
fea_list = 1:10;                    % number of selected features
file_list = 1:Max_datanum;          % data file

%% Comparison Methods
sig_Our_CD = 1;

%% Start Comparison
for f_ind = file_list
    clear select_ind_CD W_CD obj_CD obj_curv_CD
    %% Initialize Data
    load(cat(2,filename{f_ind}));
    disp(['***********The test data name is: ***' num2str(f_ind) '***'  filename{f_ind} '****************'])
    if sig_Our_CD
        select_ind_CD = {};
        W_CD = {};
        obj_CD = {};
        idx_tm1_CD = [];
    end
    
    %% Preprocess Data
    Y_ori = Y;
    dict = eye(max(Y));
    YY = dict(Y,:);
    M = standardization(X);
    
    X =M';                                                                      % d x n
    Y =YY';                                                                     % c x n
    
    
    [d,n] = size(X);
    c = size(Y,1);
    H = eye(n,n)-ones(n,1)*ones(1,n)/n;
    A  = X*H*H'*X';
    B = X*H*H'*Y';
    [~,V]=eig(A);
    lambda = max(diag(V));
    
    %% Run Methods
    for init_type = init_type_list
        for k = 1:length(fea_list)
            numfea = fea_list(k);
            if k == 1
                lastnum = 0;
            else
                lastnum = fea_list(k-1);
            end
            
            %% Our_CoordinateDescent
            if sig_Our_CD
                min_obj_CD = inf;
                for i = 1:maxiter
                    [Wt_init,~,~] = gen_initialization(numfea,d,c);
                    [select_ind_CD{numfea,i},W_CD{numfea,i},obj_CD{numfea,i},tempcurv,spend_time_CD{numfea,i}]=Test_CDLSR(X,Y,numfea,Wt_init,A,B);
                    obj_curv_CD{numfea}(i,1:length(tempcurv)) = tempcurv;
                    if min_obj_CD > obj_CD{numfea,i}
                        min_obj_CD = obj_CD{numfea,i};
                    end
                end
                save(cat(2,'Optimization_',filename{f_ind},'_CD_InitType',int2str(init_type),'_',int2str(maxiter),'.mat'),'select_ind_CD','W_CD','obj_CD','obj_curv_CD','spend_time_CD');
                
            end
        end
    end
end


