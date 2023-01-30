-- Création DB
create database bd_tp2_livres

-- Création tables
create table livre (num_livre serial primary key,
					titre varchar(50),
					nombre_pages int,
					annee_impression int);

create table auteur (num_auteur serial primary key,
					 nom varchar(20),
					 prenom varchar(20));

create table editeur (num_editeur serial primary key,
					  nom varchar(20),
					  ville varchar(20));

create table ecrit (num_livre int references livre(num_livre),
					num_auteur int references auteur(num_auteur));

create table edite (num_livre int references livre(num_livre),
					num_editeur int references editeur(num_editeur));



-- === import des infos tables
\copy livre(num_livre, titre, nombre_pages, annee_impression) from 'C:\Users\59013-42-16\Desktop\afpaJava_230130_BD_TP2_livres\liste_livres.csv' with (format csv, header false);
\copy auteur(num_auteur, nom, prenom) from 'C:\Users\59013-42-16\Desktop\afpaJava_230130_BD_TP2_livres\liste_auteurs.csv' with (format csv, header false);
\copy editeur(num_editeur, nom, ville) from 'C:\Users\59013-42-16\Desktop\afpaJava_230130_BD_TP2_livres\liste_editeurs.csv' with (format csv, header false);
\copy ecrit(num_livre, num_auteur) from 'C:\Users\59013-42-16\Desktop\afpaJava_230130_BD_TP2_livres\liste_ecrit.csv' with (format csv, header false);
\copy edite(num_livre, num_editeur) from 'C:\Users\59013-42-16\Desktop\afpaJava_230130_BD_TP2_livres\liste_edite.csv' with (format csv, header false);




-- ===== Exo 1

-- 1
select annee_impression, count(*) as "nb de livres imprimés" from livre group by annee_impression;

-- 2
select annee_impression, min(nombre_pages), max(nombre_pages) from livre group by annee_impression;

-- 3
select annee_impression, round(avg(nombre_pages)) from livre where annee_impression > 2000 group by annee_impression;

-- 4
select num_auteur, count(*) from ecrit group by num_auteur;

-- 5
select ville, count(*) from editeur group by ville;

-- 6
select num_editeur, count(*) from edite group by num_editeur;



-- ===== Exo 2

-- 1
select annee_impression, count(*) from livre
join ecrit on livre.num_livre = ecrit.num_livre
where ecrit.num_auteur = 2
group by annee_impression;


-- 2
select annee_impression, count(*) from livre
join ecrit  on livre.num_livre = ecrit.num_livre
join auteur on ecrit.num_auteur = auteur.num_auteur
where auteur.nom = 'Himes'
group by annee_impression;

-- 3
select annee_impression, count(*) from livre
join ecrit  on livre.num_livre = ecrit.num_livre
join auteur on ecrit.num_auteur = auteur.num_auteur
where auteur.nom = 'Himes' and livre.annee_impression > 2000
group by annee_impression;

-- 4
select ville, count(*) from edite
join editeur on edite.num_editeur = editeur.num_editeur
group by ville;



-- ===== Exo 3
-- ------------------------- AVEC opérateurs ensemblistes -------------------------
-- 1
select num_livre from livre where nombre_pages > 300
intersect
select num_livre from livre where annee_impression < 2003;

-- 2
select num_livre from livre where nombre_pages > 300
union
select num_livre from livre where annee_impression < 2003;

-- 3
select num_livre from livre where nombre_pages > 300
intersect
select num_livre from livre where not annee_impression < 2003;

-- ------------------------- SANS opérateurs ensemblistes -------------------------
-- 1
select * from livre where nombre_pages>300 and annee_impression < 2003;
--2
select * from livre where nombre_pages>300 or annee_impression < 2003;
-- 3
select * from livre where nombre_pages>300 and annee_impression > 2003;