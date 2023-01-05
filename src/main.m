clear;
close all;

% Load images and lights
load('data.mat', 'data')
load('calib.mat', 'calib')

% Load robust_PS data
load('data_ps/N.mat','N')
load('data_ps/rho.mat','rho')
load('data_ps/S.mat','S')

% Phong model
v = [0 0 -1]; % view direction

% Specular directions
normalVectors = reshape(N, [], 3);
numLights = size(S,1);
numPixels = size(normalVectors,1);
specularDirections = zeros([numLights numPixels 3]);
lightDirections = S;
rho_d = rho_d(:);
% Loop over each light
for i = 1:numLights
   specularDirections(i,:,:) = 2 * sum(lightDirections(i, :) .* normalVectors,2) .* normalVectors -  lightDirections(i, :);
end

% Build the system Ax = b
A = zeros([numLights numPixels 2]);
b = zeros([numLights numPixels]);

for i = 1:numLights
    A(i,:,1) = 1;
    A(i,:,2) = log(abs(sum(v .* squeeze(specularDirections(i,:,:)),2))); % add abs (mistake?)
    b(i,:) = log(abs(reshape(data.I(:,:,i),[],1) - rho_d .* sum(lightDirections(i, :) .* normalVectors,2)));
end

% Solving
x = zeros([numLights numPixels 2]);
for i = 1:numLights
    A_i = squeeze(A(i,:,:));
    b_i = b(i,:);
    for j = 1:numPixels
        x(i,j,:) = A_i(j,:)\b_i(j);
    end
end

% Robust estimation of the specular parameters
specularParameters = squeeze(median(x,1));

% Parameters
[r, c, ~] = size(data.I);
albdeo_diff = rho_d(:);
albdeo_spec = exp(specularParameters(:,1));
coeff_spec = specularParameters(:,2);

% Results
I_ref = data.I(:,:,1);
I_diff = reshape(albdeo_diff .* sum(lightDirections(1, :) .* normalVectors,2), [r c]);
I_Phong = I_diff + reshape(albdeo_spec .* (abs(sum(v .* squeeze(specularDirections(1,:,:)),2))).^coeff_spec , [r c]);

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


