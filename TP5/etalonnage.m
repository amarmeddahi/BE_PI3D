function s = etalonnage(spheres,exterieur_masque,centre,rayon)

[nb_l, nb_col, m, nb_sph] = size(spheres);

triangle = @(n)(1+n-abs(-n:n))/n;

taille_noyau = round(rayon/20);
v = [0 0 1];
s = zeros(3,m);

for im = 1:m
    % On récupère l'image associée à chaque sphère
    image_spheres = squeeze(spheres(:,:,im,:));
    for k = 1:nb_sph
        image_sphere = squeeze(image_spheres(:,:,k));
        image_filtree = conv2(triangle(taille_noyau),triangle(taille_noyau),image_sphere,'same');
        % On ne considère que la sphere
        [~, ind] = max(image_filtree .* (1 - exterieur_masque), [], 'all');
        [i, j] = ind2sub([nb_l nb_col], ind);
        x = -(round(nb_col/2) - j);
        y = round(nb_l/2) - i;
        z = sqrt(rayon^2 - x^2 - y^2);
        n = [x y z]/rayon;
        s_k = 2 * dot(v, n) * n  - v;
        s(:,im) = s(:,im) + s_k';
    end
end

s = s/m;

end

