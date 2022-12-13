# BE PI3D : Estimation de la réflectance par RTI

# Outils
 - [Editeur Markdown](https://stackedit.io/)

# Ressources
 - [Mémoire de fin d'études : Étude et modélisation de la réflectance de la surface d'objets réels](https://domurado.pagesperso-orange.fr/Memoire/)
 - [Dataset RTI](https://sharedocs.huma-num.fr/wl/?id=W4u65Lh4fWGCcrc9aKAIsnqWcu0meKym)

# Séances
 - 09/12 : Découverte du sujet + Discussions avec JDD
	 - Communication : Discord (cf. Amar)
	 - Sujet BE
		 - Difficulté des matériaux opaques non-Lambertien
		 - BRDF
			 - définition : description de la réémission de la lumière par la surface
			 - 5 paramètres (theta_e, phi_e, theta_sigma, phi_sigma, lambda)
			 - BRDF Lambert = albedo (R ou R3)
	 - TODO
		 - Comprendre la BRDF (cf. HDR de JDD)
	 - Outputs
		 - Une première piste pour estimer les paramètres d'une BRDF (avec composante spéculaire) serait d'utiliser les données réels (connues) pour minimiser l'écart entre la RTI et les données.
 - 13/12 : Discussions JDD + JM
	 - Problème affiné : **Estimation de la reflectance par PS avec des données de RTI**
	 - Outputs :
		 - Utiliser les données en Grayscale
		 - Vérifier la cohérence du repère pour le dataset Silex (i.e., z toujours négatif et regarder par rapport à la direction de s)
		 - (bonus) notre problème se rapproche (à quel point?) à du rendu différentiable (à investiguer potentiellement)
		 - Solution possible
			 - Idée : Travailler avec la PS sur un modèle type Phong (i.e., albedo scalaire + speculaire scalaire) --> photo gallery à intégrer 
				 - Détails :
					 - On estime la normale n et le rho diffus avec PS, on suppose s connu (éclairage uniforme et //)
			 - Approche
				 - Step 1 : Estimation avec PS Robuste de rho_d et la normale (s connu)
				 - Step 2 : Equation Ax = B à résoudre pour estimer les paramètres (en l'espèce modèle de Phong)
				 - Step 3 : Evaluation
