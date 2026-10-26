# Gestion des commandes — Servlet / JSP / JavaBean (MVC)

## Prérequis
JDK 11+, Maven 3.8+, Tomcat **9.x**, MySQL 8.

## Lancer
1. Exécuter `sql/schema.sql` dans MySQL (crée la base `gestion_commandes` + données de test).
2. Adapter `src/main/resources/db.properties` (utilisateur / mot de passe MySQL).
3. `mvn clean package` → `target/gestion-commandes.war`, à déployer dans `tomcat/webapps`
   (ou Eclipse : *Import > Existing Maven Projects*, puis *Run on Server* avec Tomcat 9).
4. Ouvrir http://localhost:8080/gestion-commandes/


## Refonte de l'interface

L'interface JSP a été retravaillée autour d'une identité visuelle cohérente (sidebar, barre supérieure, palette bleu nuit/bleu royal, cartes, badges et formulaires responsives), sans changer la stack Servlet/JSP/JavaBean ni le modèle métier.

- Tableau de bord : raccourcis vers les modules existants, sans indicateurs chiffrés simulés.
- Clients, produits et commandes : tableaux retravaillés avec recherche côté navigateur, états vides et actions existantes.
- Formulaires : champs structurés, aides de saisie, contraintes HTML et états de soumission.
- Commandes : détail réorganisé et ajout/retrait dynamique de lignes conservé.
- Les actions CRUD continuent d'utiliser les servlets et services existants.

La recherche de tableau filtre uniquement les enregistrements déjà chargés dans la page : elle ne remplace pas une recherche serveur ni une pagination. Aucune nouvelle fonctionnalité backend n'a été ajoutée. Le build Maven n'a pas pu être exécuté dans l'environnement de travail car Maven n'y est pas installé ; exécuter `mvn package` localement avant le déploiement.
