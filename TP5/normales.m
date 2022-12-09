function N = normales(I,theta,phi)

[~, ind] = max(I);
N = [theta(ind) phi(ind) ones(size(ind,2), 1)];

end

