USE tifosi;

-- ===========================================================
-- Requête 1
-- But : Afficher la liste des noms des focaccias par ordre alphabétique croissant
-- Résultat attendu : Une liste de 8 noms allant de Américaine à Tradizione.
-- Résultat obtenu : (À vérifier lors de l'exécution)
-- ===========================================================
SELECT nom_focaccia 
FROM focaccia 
ORDER BY nom_focaccia ASC;

-- ===========================================================
-- Requête 2
-- But : Afficher le nombre total d'ingrédients
-- Résultat attendu : 25
-- Résultat obtenu : (À vérifier lors de l'exécution)
-- ===========================================================
SELECT COUNT(*) AS nombre_total_ingredients 
FROM ingredient;

-- ===========================================================
-- Requête 3
-- But : Afficher le prix moyen des focaccias
-- Résultat attendu : Un prix autour de 10.37 €
-- Résultat obtenu : (À vérifier lors de l'exécution)
-- ===========================================================
SELECT ROUND(AVG(prix_focaccia), 2) AS prix_moyen 
FROM focaccia;

-- ===========================================================
-- Requête 4
-- But : Afficher la liste des boissons avec leur marque, triée par nom de boisson
-- Résultat attendu : 12 boissons avec le nom de leur marque à côté, triées de C à P.
-- Résultat obtenu : (À vérifier lors de l'exécution)
-- ===========================================================
SELECT b.nom_boisson, m.nom_marque 
FROM boisson b
JOIN marque m ON b.id_marque = m.id_marque
ORDER BY b.nom_boisson ASC;

-- ===========================================================
-- Requête 5
-- But : Afficher la liste des ingrédients pour une Raclaccia
-- Résultat attendu : Base Tomate, Raclette, Cresson, Ail, Champignon, Parmesan, Poivre
-- Résultat obtenu : (À vérifier lors de l'exécution)
-- ===========================================================
SELECT i.nom_ingredient 
FROM ingredient i
JOIN comprend c ON i.id_ingredient = c.id_ingredient
JOIN focaccia f ON c.id_focaccia = f.id_focaccia
WHERE f.nom_focaccia = 'Raclaccia';

-- ===========================================================
-- Requête 6
-- But : Afficher le nom et le nombre d'ingrédients pour chaque focaccia
-- Résultat attendu : Une liste des 8 focaccias avec un chiffre entre 7 et 10 à côté.
-- Résultat obtenu : (À vérifier lors de l'exécution)
-- ===========================================================
SELECT f.nom_focaccia, COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom_focaccia;

-- ===========================================================
-- Requête 7
-- But : Afficher le nom de la focaccia qui a le plus d'ingrédients
-- Résultat attendu : Mozaccia (10 ingrédients)
-- Résultat obtenu : (À vérifier lors de l'exécution)
-- ===========================================================
SELECT f.nom_focaccia, COUNT(c.id_ingredient) AS nombre_ingredients
FROM focaccia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
GROUP BY f.id_focaccia, f.nom_focaccia
ORDER BY nombre_ingredients DESC
LIMIT 1;

-- ===========================================================
-- Requête 8
-- But : Afficher la liste des focaccias qui contiennent de l'ail
-- Résultat attendu : Mozaccia, Gorgonzollaccia, Raclaccia, Paysanne
-- Résultat obtenu : (À vérifier lors de l'exécution)
-- ===========================================================
SELECT f.nom_focaccia 
FROM focaccia f
JOIN comprend c ON f.id_focaccia = c.id_focaccia
JOIN ingredient i ON c.id_ingredient = i.id_ingredient
WHERE i.nom_ingredient = 'Ail';

-- ===========================================================
-- Requête 9
-- But : Afficher la liste des ingrédients inutilisés
-- Résultat attendu : Bacon, chèvre, oeuf, pomme de terre, salami, tomate cerise (selon la logique des données)
-- Résultat obtenu : (À vérifier lors de l'exécution)
-- ===========================================================
SELECT i.nom_ingredient 
FROM ingredient i
LEFT JOIN comprend c ON i.id_ingredient = c.id_ingredient
WHERE c.id_focaccia IS NULL;

-- ===========================================================
-- Requête 10
-- But : Afficher la liste des focaccias qui n'ont pas de champignons
-- Résultat attendu : Hawaienne, Américaine
-- Résultat obtenu : (À vérifier lors de l'exécution)
-- ===========================================================
SELECT nom_focaccia 
FROM focaccia 
WHERE id_focaccia NOT IN (
    SELECT c.id_focaccia 
    FROM comprend c
    JOIN ingredient i ON c.id_ingredient = i.id_ingredient
    WHERE i.nom_ingredient = 'Champignon'
);