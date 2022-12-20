clear;
close all;

% Load data and calib
load('data.mat', 'data')
load('calib.mat', 'calib')

% Robust PS
[XYZ,N,rho,Phi,S,ambient,mask,tab_nrj] = robust_ps_V2(data,calib);