%% EXAMPLE 4 - Deterministic AR(1) shock
% The example is based on a simple 3-equation New-Keynesian Model featuring
% a Truncated Taylor rule with backward looking component.
% See readme.md and appendix for additional details.
% (C) Eggertsson G., Egiev S., Lin A., Platzer J. and Riva L.

clear;
clc;
close all;

addpath('../Source')
addpath('ex_4')


%%  0) CONFIGURATION

%   0.1) SPECIFY SOLVER CONFIGURATION
config.taumax       = 2;         % declare the maximum contingency
config.max_length_2 = 5;         % declare the maximum length of regime 2
config.bound        = 0;         % declare the bound for the variable subject to it
config.mono         = 1;         % switch for monotone k-vector
config.trh          = -exp(-14); % declare a numerical threshold for which the constraint is thought as binding. i.e. if i < bound +trh, then lower bound counts as being violated

%   0.2) SPECIFY MODEL AND CALIBRATION
variables  % vector of variables [Z_t P_(t-1)]'
equations  % name equations
parameters % model parameters
matrices   % model matrices (A, B)

%%  1) RUN BASELINE RULE
[D_3,G_3,D_3a]                      = regime3(AAA,BBB,param);
[D_2,G_2]                           = regime2(AAA,BBB,D_3a,param,config);
[D_1,G_1, ResM, max_k,k,T_tilde]    = regime1(AAA,BBB,D_3a,D_3,D_2,G_3,G_2,param,config,'verbose',1);

ResM(:,vars.x,:)     = ResM(:,vars.x,:)*100;
ResM(:,vars.pi,:)    = ResM(:,vars.pi,:)*400;
ResM(:,vars.i,:)     = ResM(:,vars.i,:)*400;
ResM(:,vars.i_imp,:) = ResM(:,vars.i_imp,:)*400;

%	1.1) COMPUTE IMPULSE RESPONSES
impulseresponse

%   1.2) PLOT IMPULSE RESPONSES
graphing(IR,vars,25)