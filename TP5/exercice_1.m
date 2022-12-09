clear;
close all;

load spheres;

nb_lignes = size(spheres,1);
nb_colonnes = size(spheres,2);

centre = [nb_lignes/2 nb_colonnes/2];
rayon = min(nb_colonnes,nb_lignes)/2;

[X,Y] = meshgrid(1:nb_colonnes,1:nb_lignes);
marge_rayon = 5;
exterieur_masque = (X-rayon).^2+(Y-rayon).^2>(rayon-marge_rayon)^2;

s = etalonnage(spheres,exterieur_masque,centre,rayon);

[theta,phi] = conversion(s);
plot(theta,phi,'o','Color','r','LineWidth',4,'MarkerSize',10);
xlabel('$\theta$','Interpreter','Latex','FontSize',20);
ylabel('$\phi$','Interpreter','Latex','FontSize',20);
axis([0,pi/2,-pi,pi]);

save eclairages theta phi;
