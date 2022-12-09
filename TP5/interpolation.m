function [A,I] = interpolation(images,theta,phi)

[nb_l, nb_c, m] = size(images);
images = reshape(images, [nb_l * nb_c m]);
I = double(images');

B = [ones(m, 1) theta phi theta.^2 theta .* phi phi.^2];

A = B\I;

end

