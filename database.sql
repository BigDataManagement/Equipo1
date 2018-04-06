create database netflix;
create table netflix;
use netflix;
create table movie_titles(id_pelicula INT NOT NULL PRIMARY KEY, año_lanzamiento INT NOT NULL, nombre_pelicula VARCHAR(256)NOT NULL);
create table scores_1( id_calificacion INT AUTO_INCREMENT PRIMARY KEY NOT NULL, id_pelicula INT NOT NULL, codigo_cliente VARCHAR(256) NOT NULL, calificacion INT NOT NULL, fecha DATE, FOREIGN KEY (id_pelicula) REFERENCES movie_titles(id_pelicula) ON DELETE CASCADE ON UPDATE CASCADE );

LOAD DATA INFILE '/tmp/movie_titles.csv' INTO TABLE movie_titles COLUMNS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\n';
SET FOREIGN_KEY_CHECKS = 0;
LOAD DATA INFILE '/tmp/scores.csv' INTO TABLE scores_1 COLUMNS TERMINATED BY ',' OPTIONALLY ENCLOSED BY '"' ESCAPED BY '"' LINES TERMINATED BY '\n' (id_pelicula,codigo_cliente,calificacion,fecha);
