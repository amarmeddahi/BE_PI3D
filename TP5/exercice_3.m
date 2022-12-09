clear;
close all;

load donnees;
load eclairages;

[~,I] = interpolation(images,theta,phi);
N = normales(I,theta,phi);

x_affichage = 255*(N(:,1) + 1)/2;
y_affichage = 255*(N(:,2) + 1)/2;
z_affichage = 255*(N(:,3));

interieur = find(masque>0);		% Interieur du domaine de reconstruction
exterieur = find(masque==0);		% Exterieur du domaine de reconstruction

N_affichage = reshape([x_affichage,y_affichage,z_affichage],[size(masque,1),size(masque,2),3]);

% Intégration du champ de normales :
N(exterieur,3) = 1;			% Pour éviter les divisions par 0
p_estime = reshape(-N(:,1)./N(:,3),size(masque));
p_estime(exterieur) = 0;
q_estime = reshape(-N(:,2)./N(:,3),size(masque));
q_estime(exterieur) = 0;
z_estime = integration_SCS(-q_estime,p_estime);

% Ambiguïté concave/convexe :
if (z_estime(floor(size(masque,1)/2),floor(size(masque,2)/2))<z_estime(1,1))
	z_estime = -z_estime;
end
z_estime(exterieur) = NaN;

% Affichage du résultat :
figure;
h = surfl(fliplr(z_estime));
title('Relief estime','FontSize',15);
zdir = [1 0 0];
rotate(h,zdir,90);
zdir = [0 1 0];
rotate(h,zdir,180);
zdir = [1 0 0];
rotate(h,zdir,-90);
shading flat;
colormap gray;
axis equal;
axis off;

view(0,90);				% Direction de l'éclairage
hc = camlight('headlight','infinite');
view(-44,42);				% Direction d'observation
