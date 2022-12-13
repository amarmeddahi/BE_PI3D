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
 - 13/12
