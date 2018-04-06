# Enunciado del Proyecto 1 Gestión de Datos Grandes

Objetivo del Reto.

Activar un workflow de gestión de datos en Pentaho Data Integration cuyas fuentes de datos son dos DBMSs (MySQL y MongoDB).
Pentaho: http://www.pentaho.com/
MySQL: https://www.mysql.com/
MongoDB: https://www.mongodb.com/

Estado actual de la data.

Los datos estan almacenados en el sitio web kaggle: https://www.kaggle.com/
Los datos se extraen desde: https://www.kaggle.com/netflix-inc/netflix-prize-data/data

### ETAPA 1: DBMSs MySQL y MongoDB

Paso a Paso

1. Todos los equipos deben descargar el archivo movie_titles.csv

2. El equipo numero 1 descargará el archivo combined_data_1.txt, el equipo numero 2 descargará el archivo combined_data_2.txt y asi 
sucesivamente hasta el 4. Es responsabilidad de cada equipo entender los datos contenidos en sus dos archivos y hacer las transformaciones que considere necesarias
para realizar la carga.

3. Cargar los archivos en su correspondiente sistema de base de datos

4. Hacer el tratamiento necesario en su DBMS para normalizar las fuentes de datos.

4.1. Carga a MySQL. Los archivos se convertirán en dos tablas de la siguiente forma:

- La primera tabla llamada "movie_titles" será cargada con la información del archivo movie_titles.csv, esta tabla contará con tres columnas: id_pelicula, año_lanzamiento, nombre_pelicula.

- La segunda tabla llamada "scores_#" será cargada con la información del archivo combined_data_#.txt correspondiente. Esta tabla tendrá las siguientes columnas: 
id_calificacion Autoincremental (PK), id_pelicula (FK), codigo_cliente, calificacion, fecha.

Además, por términos de eficiencia, la tabla "movie_titles" debe contener solo la información correspondiente a las peliculas calificadas en su correspondiente archivo
combined_data, es decir, si el archivo combined_data_1.txt solo tiene las calificaciones de la pelicula 1 a la 2.000, la tabla movie_titles solo debe contener los registros de esas 2.000 peliculas.

4.2. Carga a MongoDB. Los archivos que se subirán a MongoDB se convertirán en dos colecciones (el equivalente a las dos tablas de MySQL) de la siguiente forma:

- La primera coleccion llamada "movie_titles" será cargada con la información del archivo movie_titles.csv, aquí, cada documento (el equivalente a una fila)
tendrá los campos id_pelicula, año_lanzamiento, nombre_pelicula.

- La segunda colección llamada "scores_#" será cargada con la información del archivo combined_data_#.txt correspondiente.
Esta colección tendrá los siguientes formato en cada uno de sus documentos:
{id_pelicula:#, codigo_cliente:#, calificacion: #, fecha:#}

NOTA: Recordar que en mongodb no tenemos el problema de clave primaria, es decir, muchos de los documentos podrian tener el mismo id.

Despues de tener los datos almacenados en los gestores de bases de datos se procederá a usar la plataforma Pentaho Data Integration para 
unificar todas las fuentes de datos en un solo lugar, en esta parte se creará un workflow que nos permita unir los datos y presentarselos al usuario final.

Para esta etapa se debera trabajar de forma colaborativa, es decir, un equipo que tenga el DBMS MySQL se unirá a uno que tenga MongoDB.
Nuevo Equipo 1: Nace de la unión del equipo 1 y 2
Nuevo Equipo 2: Nace de la unión del equipo 3 y 4

### ETAPA 2: Pentaho Data Integration

Paso a Paso

1. Descargar la plataforma Pentaho Data Integration 

1.1. Pentaho es una plataforma muy grande, para este proyecto solo nos interesa el modulo "Data integration", el cual se puede descargar en el siguiente enlace:
http://www.pentaho.com/product/data-integration

1.2. Dar click en el boton Free Trial el cual les permitirá usar pentaho durante 30 dias, no es necesario mas ya que la duración del proyecto es menor a ese lapso.
Al dar click en Free Trial, se los redirigirá a este enlace: http://www.pentaho.com/download

1.3. Descargar los controladores necesarios para conectar MySQL y MongoDB a Pentaho, esto es responsabilidad de cada equipo.

2. Desarrollar un workflow en pentaho data integration unificando los datos almacenados en MySQL y MongoDB:

Despues de activar el workflow debe ser posible realizar las siguientes dos consultas:

1. Se desea conocer toda la información relacionada con una pelicula en una sola vista, de tal manera que pueda visualizar los siguientes campos:
id_pelicula, nombre_pelicula, año_lanzamiento, calificacion, fecha.
Notar que se tienen varias filas por una misma pelicula, ya que hay mas de una calificación por pelicula.

2. Se desea conocer las 5 peliculas mejor calificadas:
id_pelicula, nombre_pelicula, año_lanzamiento, cantidad de usuarios que la calificaron, promedio de calificacion.

NOTA: tener en cuenta que el exito de las consultas reside en que se pueda consultar una información completa y coherente, es decir, una posible consulta sobre una tabla "movie_titles" unificada en pentaho debe permitir visualizar la información de las peliculas que provienen tanto del gestor MySQL y de MongoDB.

PD: Se adjunta un README del dataset de NETFLIX, importante tener en cuenta que no hacemos uso de todos los archivos del dataset.

# Proceso de Solución
### Opciones
1. Insertar en base de datos por medio del conector de Python, identificando el id de la pelicula al que se asocian las respectivas calificaciones, esta solucion no es tan optima por dos razones, primero porque debido a la estructura de datos que utiliza la base de datos la instruccion `insert` de alto nivel es relativamente lenta a la hora de ajecutarla mas de 24 millones de veces. Y segundo, debido a la integracion entre la base de datos y el lenguaje de programacion Python, se tarda mas tiempo en transferencia de datos que en verdadero tiempo de `insert`.

2. Lo primero que hicimos fue hacer un cleaning de la data con python obteniendo solo la cantidad de peliculas de las cuales se tenian registros de calificaciones para que solo estas fueran agregadas a la base de datos. Luego de hacer este parseo se subieron los archivos generados (csv) a la base de datos a traves del comando de mysql `INSERT DATA INFILE file`, con este procedimiento todos los registros se subieron en no mas de 10 minutos.

### Solución
Después de algunas pruebas y comparando el performance de las posibles soluciones se optó por la segunda ya que consumía menos memoria en la ejecución y demoraba menos tiempo en la carga de datos.

### Problemas
