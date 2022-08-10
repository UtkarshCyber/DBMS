CREATE TABLE ACTOR (
ACT_ID NUMBER (3),
ACT_NAME VARCHAR (20),
ACT_GENDER CHAR (1),
PRIMARY KEY (ACT_ID));

CREATE TABLE DIRECTOR (
DIR_ID NUMBER (3),
DIR_NAME VARCHAR (20),
DIR_PHONE NUMBER (10),
PRIMARY KEY (DIR_ID));

CREATE TABLE MOVIES (
MOV_ID NUMBER (4),
MOV_TITLE VARCHAR (25),
MOV_YEAR NUMBER (4),
MOV_LANG VARCHAR (12),
DIR_ID NUMBER (3),
PRIMARY KEY (MOV_ID),
FOREIGN KEY (DIR_ID) REFERENCES DIRECTOR (DIR_ID));
FOREIGN KEY (DIR_ID) REFERENCES DIRECTOR (DIR_ID));

CREATE TABLE MOVIE_CAST ( ACT_ID
NUMBER (3),
MOV_ID NUMBER(4),
ROLE VARCHAR(10),
PRIMARY KEY (ACT_ID, MOV_ID),
FOREIGN KEY (ACT_ID) REFERENCES ACTOR (ACT_ID), FOREIGN KEY
(MOV_ID) REFERENCES MOVIES (MOV_ID));
CREATE TABLE RATING (
MOV_ID NUMBER (4),
REV_STARS VARCHAR (25),
PRIMARY KEY (MOV_ID),
FOREIGN KEY (MOV_ID) REFERENCES MOVIES (MOV_ID));

INSERT INTO ACTOR VALUES (301,‘ANUSHKA‘,‘F‘);
INSERT INTO ACTOR VALUES (302,‘PRABHAS‘,‘M‘);
INSERT INTO ACTOR VALUES (303,‘PUNITH‘,‘M‘);
INSERT INTO ACTOR VALUES (304,‘JERMY‘,‘M‘); 

INSERT INTO DIRECTOR VALUES (60,'RAJAMOULI', 8751611001);
INSERT INTO DIRECTOR VALUES (61,'HITCHCOCK', 7766138911);
INSERT INTO DIRECTOR VALUES (62,'FARAN', 9986776531);
INSERT INTO DIRECTOR VALUES (63,'STEVEN SPIELBERG', 8989776530); 

INSERT INTO MOVIES VALUES (1001,'BAHUBALI-2', 2017, 'TELAGU', 60);
INSERT INTO MOVIES VALUES (1002,'BAHUBALI-1', 2015,'TELAGU', 60);
INSERT INTO MOVIES VALUES (1003,'AKASH', 2008, 'KANNADA', 61); 
INSERT INTO MOVIES VALUES (1004,'WAR HORSE', 2011, 'ENGLISH', 63);

INSERT INTO MOVIE_CAST VALUES (301, 1002, 'HEROINE'); 
INSERT INTO MOVIE_CAST VALUES (301, 1001, 'HEROINE'); 
INSERT INTO MOVIE_CAST VALUES (303, 1003, 'HERO'); 
INSERT INTO MOVIE_CAST VALUES (303, 1002, 'GUEST'); 
INSERT INTO MOVIE_CAST VALUES (304, 1004, 'HERO'); 

INSERT INTO RATING VALUES (1001, 4);
INSERT INTO RATING VALUES (1002, 2);
INSERT INTO RATING VALUES (1003, 5);
INSERT INTO RATING VALUES (1004, 4);

Q1)List the titles of all movies directed by‘Hitchcock’
SELECT MOV_TITLE
FROM MOVIES
WHERE DIR_ID IN (SELECT DIR_ID
FROM DIRECTOR
WHERE DIR_NAME = 'HITCHCOCK')

Q2)Find the movie names where one or more actors acted in two or more movies.
select distinct m.mov_title,c.act_id from movies m, movie_cast c where m.mov_id=c.mov_id and c.act_id in 
(select act_id from movie_cast group by act_id having count(mov_id)>1)

Q3)List all actors who acted in a movie before 2000 and also in a movie after 2015 (use JOIN operation).
select act_name from Actor where act_id in(select a.act_id from (select act_id from movie_cast natural join movies where mov_year<2000)a
inner join  (select act_id from movie_cast natural join movies where mov_year>2015)b on a.act_id=b.act_id)

Q4)Find the title of movies and number of stars for each movie that has at least one rating and find the highest
number of stars that movie received. Sort the result by movie title.
select mov_title,max(rev_stars) from movies m,rating r where m.mov_id=r.mov_id group by m.mov_title having count(r.rev_stars)>0

Q5)Update rating of all movies directed by ‘Steven Spielberg’ to 5.
update rating set rev_stars=5 where mov_id in (select mov_id from Movies inner join director on movies.dir_id=director.dir_id and director.dir_name='Steven Spielberg')
