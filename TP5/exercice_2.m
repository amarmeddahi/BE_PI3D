clear;
close all;

load donnees;
load eclairages;

% Calcul des n fonctions d'interpolation :
[A,I] = interpolation(images,theta,phi);

% Tirage aléatoire d'un pixel:
n = size(images,1)*size(images,2);
ind_test = randi(n);

% Affichage des échantillons de ce pixel :
plot3(theta,phi,I(:,ind_test),'x','Color','r','LineWidth',4,'MarkerSize',10);
hold on;

% Affichage de la fonction d'interpolation de ce pixel :
[phi_affichage,theta_affichage] = meshgrid(-pi:0.1:pi,0:0.05:(pi/2));
z = A(1,ind_test)+A(2,ind_test)*theta_affichage+A(3,ind_test)*phi_affichage+...
	A(4,ind_test)*theta_affichage.^2+A(5,ind_test)*theta_affichage.*phi_affichage+...
		A(6,ind_test)*phi_affichage.^2;
surf(theta_affichage,phi_affichage,z);
xlabel('$\theta$','Interpreter','Latex','FontSize',30);
ylabel('$\phi$','Interpreter','Latex','FontSize',30);
zlabel('$I$','Interpreter','Latex','FontSize',30);
axis([0,pi/2,-pi,pi,0,1]);

input('Tapez un caractere pour lancer la simulation !');

% Simulation d'un éclairage tournant :
close;
theta = 0;
valeurs_phi = -pi:0.2:pi;
for k = 1:length(valeurs_phi)
	phi = valeurs_phi(k);
	l = [1 theta phi theta^2 theta*phi phi^2];
	image_test = max(l*A,0);
	image_test = reshape(image_test,[size(images,1),size(images,2)]);
	imshow(image_test);
	pause(0.01);
end
