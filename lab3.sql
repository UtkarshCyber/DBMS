CREATE TABLE supplier(sid int, sname char(30), address char(30), PRIMARY KEY(sid));
CREATE TABLE parts(pid int, pname char(30), color char(30), PRIMARY KEY(pid));
CREATE TABLE catalog(sid int, pid int, cost int, foreign key(sid) references supplier(sid), foreign key(pid) references parts(pid));

INSERT INTO supplier VALUES(110,'Ananad pvt ltd','Jamshedpur');
INSERT INTO supplier VALUES(123,'Shrinivas hardware','Bangalore');
INSERT INTO supplier VALUES(785,'Raghav industries','Vellore');
INSERT INTO supplier VALUES(345,'Bablu enterpries','Delhi');
INSERT INTO supplier VALUES(876,'Ramnihal motoparts','Bombay');

INSERT INTO parts VALUES(01,'Screw','red');
INSERT INTO parts VALUES(02,'Bearing','red');
INSERT INTO parts VALUES(03,'Nut','grey');
INSERT INTO parts VALUES(10,'Bolt','red');
INSERT INTO parts VALUES(27,'panner','grey');
INSERT INTO parts VALUES(32,'rubbergrip',red);
INSERT INTO parts VALUES(89,'rubbergrip','grey');

INSERT INTO catalog VALUES(110,01,23),(110,02,45),(110,03,86),(110,10,73),(110,27,93),(110,32,20),(110,89,120);
INSERT INTO catalog VALUES(123,01,43),(123,02,18),(123,10,33),(123,32,32);
INSERT INTO catalog VALUES(785,01,13),(785,32,62);
INSERT INTO catalog VALUES(345,01,53),(345,27,45),(345,32,82),(345,89,109);
INSERT INTO catalog VALUES(876,02,25),(876,03,72),(876,32,23);

Queries:
1) SELECT DISTINCT P.pname FROM parts P, catalog C WHERE P.pid = C.pid;
2) SELECT S.sname FROM supplier S WHERE NOT EXISTS ((SELECT P.pid FROM parts P) EXCEPT(SELECT C.pid FROM catalog C WHERE C.sid = S.sid ));
3) SELECT S.sname FROM supplier S WHERE NOT EXISTS((SELECT P.pid FROM parts P WHERE P.color='red') EXCEPT (SELECT C.pid FROM catalog C, parts P WHERE C.sid = S.sid AND C.pid = P.pid AND P.color = 'red'));
4) SELECT DISTINCT pname FROM catalog x, parts y, supplier z WHERE(z.sname='Ananad pvt ltd' AND z.sid=x.sid);
5)  SELECT DISTINCT c.sid FROM catalog c WHERE c.cost>(SELECT AVG(c1.cost) FROM catalog c1 WHERE c1.pid=c.pid);
6) SELECT P.pid, S.sname FROM parts P, supplier S, catalog C WHERE C.pid = P.pid AND C.sid = S.sid AND C.cost = (SELECT MAX(C1.cost) FROM catalog C1 WHERE C1.pid = P.pid);
7) SELECT DISTINCT c.sid FROM catalog c WHERE NOT EXISTS(SELECT * FROM parts p WHERE p.pid=c.pid and p.color<>'red');
