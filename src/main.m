clear;
close all;

% Load images and lights
load('data.mat', 'data')
load('calib.mat', 'calib')

% Load robust_PS data
load('data_ps/N.mat','N')
load('data_ps/rho.mat','rho')
load('data_ps/S.mat','S')
load('data_ps/mask.mat','mask')

% Phong model
v = [0 0 -1]; % view direction

% Specular directions
normalVectors = reshape(N, [], 3);
numLights = size(S,1);
numPixels = size(normalVectors,1);
specularDirections = zeros([numLights numPixels 3]);
lightDirections = S;
rho_d = rho(:);
% Loop over each light
for i = 1:numLights
   specularDirections(i,:,:) = 2 * sum(lightDirections(i, :) .* normalVectors,2) .* normalVectors -  lightDirections(i, :);
end

% Build the system Ax = b
A = ones([numLights numPixels 2]);
b = zeros([numLights numPixels]);

for i = 1:numLights
    A(i,:,2) = log(abs(sum(v .* squeeze(specularDirections(i,:,:)),2))); % add abs (mistake?)
    b(i,:) = log(abs(reshape(data.I(:,:,i),[],1) - rho_d .* sum(lightDirections(i, :) .* normalVectors,2)));
end

% Solving
x = zeros([numPixels 2]);
for i = 1:numPixels
    A_i = squeeze(A(:,i,:));
    b_i = b(:,i);
    x(i,:) = A_i\b_i;
end

% Robust estimation of the specular parameters
specularParameters = x;

% Parameters
[r, c, ~] = size(data.I);
albdeo_diff = rho_d(:);
albdeo_spec = exp(specularParameters(:,1));
coeff_spec = specularParameters(:,2);

% Results
I_ref = data.I(:,:,1);
I_diff = reshape(albdeo_diff .* sum(lightDirections(1, :) .* normalVectors,2), [r c]);
I_Phong = I_diff + reshape(albdeo_spec .* (abs(sum(v .* squeeze(specularDirections(1,:,:)),2))).^coeff_spec , [r c]);

% Residuals
method = mean((I_ref - I_diff).^2,"all");
ours = mean((I_ref - I_Phong).^2,"all");

figure;
subplot(1,3,1);
imshow(I_ref);
title('Reference Image', 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'red');
subplot(1,3,2);
imshow(I_diff);
title('Model Diffuse (standard method)', 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'red');
subplot(1,3,3);
imshow(I_Phong);
title('Phong Model (ours)', 'FontSize', 14, 'FontWeight', 'bold', 'Color', 'red');


