clear;
close all;

% Load images and lights
load('data_tp5/eclairages.mat')
load('data_tp5/donnees.mat')

% Convert the ligh directions from (phi,theta) to (x,y,z)
[x,y,z] = sph2cart(pi/2 - phi, pi/2 - theta, ones(size(phi)));
calib.S = [x y z];

% Images
data.I = images;

% Robust PS
[~,N,rho_d,~,S,~,~,~] = robust_ps_V2(data,calib);