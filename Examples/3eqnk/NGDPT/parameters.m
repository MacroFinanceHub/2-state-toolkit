% Parameters
% Calibration: Eggertsson and Woodford (2003)

param.NS      = 3;

param.theta   = 7.87;
param.kappa   = 0.02;
param.mu      = 0.9;
param.beta    = 0.99;
param.sigma   = 0.5;
param.phi_pi  = 100;
param.phi_x   = param.phi_pi;

param.lagr_x  = param.kappa/param.theta;
param.lagr_pi = 1;

param.rl      = -0.005;
param.rh      = 1/param.beta-1;

param.sl = [param.rh;param.rl];
param.sh = [param.rh;param.rh];