# BE PI3D : Estimation de la réflectance par RTI

# Outils
 - [Editeur Markdown](https://stackedit.io/)

# Ressources
 - [Mémoire de fin d'études : Étude et modélisation de la réflectance de la surface d'objets réels](https://domurado.pagesperso-orange.fr/Memoire/)
 - [Dataset RTI](https://sharedocs.huma-num.fr/wl/?id=W4u65Lh4fWGCcrc9aKAIsnqWcu0meKym)
 - [Yvain Quéau GitHub (normal_integration + robust_ps)](https://github.com/yqueau)

# Séances

 - Abbreviations :  BE (Bureau d'études); JDD (Jean-Denis Durou); JM (Jean Mélou); PS (Photometric stereo)
 - 09/12 : Découverte du sujet
	 - Amar est désigné comme POC (Point of Contact). La plateforme Discord sera utilisée.
	 - Le problème du BE consiste à aborder la difficulté d'obtenir la reflectance pour les matériaux opaques non-Lambertien (i.e., brillant)
		 - Notions de BRDF (Bidirectional Reflectance Distribution Function)
			 - La BRDF décrit la réémission de la lumière par une surface
			 - Elle possède 5 paramètres (theta_e, phi_e, theta_sigma, phi_sigma, lambda)
			 - Cadre Lambertien => BRDF = albedo (R ou R^3)
		 - **Première solution** : estimer les paramètres d'une BRDF (avec composante spéculaire) serait d'utiliser les données réels (connues)
		 - ToDo
			 - Comprendre la notion de BRDF (voir : HDR de JDD + [Mémoire de fin d'études : Étude et modélisation de la réflectance de la surface d'objets réels](https://domurado.pagesperso-orange.fr/Memoire/))
 - 13/12 : Définition formelle de la première approche
	 - Précision sur le titre du BE : **Estimation de la reflectance par PS avec des données de RTI**
	 - Remarques de JDD + JM
		 - Commencer par travailler sur les images en nuances de gris (rgb2gray)
		 - dataset silex : vérifier la cohérence du repère (ex. z toujours négatif et x/y cohérent par rapport à la direction de S
		 - Le sujet de BE se rapproche à du rendu différentiable
		 - Estimation de la composante spéculaire dans le cas du modèle de Phong (attention v et sigma sont inversés sur le petit schéma en haut de page) :
<p align="center">
  <img width="50%" src="res/resolution.jpg" />
</p>

 - 05/01 : Implémentation de la reflectance du modèle de Phong + critères d'estimation
	 -  améliorations :
		 - appliquer un masque binaire pour isoler le sujet (à faire avant robust_ps_v2)
		 - soustraire l'éclairage ambient aux images  RTI
	 - argument ln négatifs :
		 - `I - rho_d * dot(n,s) <= eps`
			 - Le résidu peut-être positif ou négatif
			 - Solution :
				 -  `max(0,dot(n,s))`
				 - garder uniquement les éclairages associées aux résidus positifs
			 - Si des points dans le masque sont associées à des résidus négatifs pour les toujours éclairages --> enquêter (ex. afficher ces points)
		 - `dot(r,v) <= eps`
			 -  Le produit scalaire peut-être négatif pour plusieurs scénarios
			 - Solutions :
				 - fixer `alpha`
				 - chercher comment ce problème est résolu en rendu
