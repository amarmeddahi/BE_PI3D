function [theta,phi] = conversion(s)

[~, nb_angles] = size(s);
theta = zeros(nb_angles, 1);
phi = zeros(nb_angles, 1);
for a = 1:nb_angles
    phi(a) = atan2(s(2, a), s(1,a));
    theta(a) = acos(s(3,a)/sqrt(sum(s(:,a).^2)));
end

end

