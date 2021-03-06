%% TRUNCATED TAYLOR RULE (TTR). CONTEMPORANEOUS INFLATION AND OUTPUT GAP
% (C) Eggertsson G., Egiev S., Lin A., Platzer J. and Riva L.

clc;
close all;
addpath('../../../Source')


%% SPECIFY MODEL AND CALIBRATION
variables  % vector of variables [Z_t P_(t-1)]'
equations  % name equations
parameters % model parameters
matrices   % model matrices (A, B)


%% SPECIFY SOLVER CONFIGURATION
config.taumax       = 400; % declare the maximum contingency
config.max_length_2 = 50;  % declare the maximum length of regime 2
config.bound        = 0;   % declare the bound for the variable subject to it
config.mono         = 1;   % switch for monotone k-vector


%% SOLVE
[D_3,G_3,D_3a] = regime3(AAA,BBB,param);
[D_2,G_2]      = regime2(AAA,BBB,D_3a,param,config);
[D_1,G_1, ResM, max_k,k,T_tilde] = regime1(AAA,BBB,D_3a,D_3,D_2,G_3,G_2,param,config);


%% COMPUTE ADDITIONAL VARIABLES
vars.p     = param.NY + 1; % price level
vars.ngdp  = param.NY + 2; % nominal GDP

for it = 1:size(ResM,1)  
    ResM(it,vars.p,:) = sum(ResM(1:it,vars.pi,:),1);
end
clearvars it
 
ResM(:,vars.ngdp,:) = ResM(:,vars.x,:)+ResM(:,vars.p,:);
param.NY = numel(fieldnames(vars));


%% COMPUTE IMPULSE RESPONSES
impulseresponse


%% PLOT IMPULSE RESPONSES
graphing(IR,vars,25,'variables',{'i','pi','x'},'cont_data',ResM,'cont_num',1:20)