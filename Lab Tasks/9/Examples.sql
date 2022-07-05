MariaDB [sales_co]> CREATE PROCEDURE my_procedure_Local_Variables()
    -> BEGIN
    -> /* declare local variables */
    -> DECLARE a INT DEFAULT 10;
    -> DECLARE b, c INT;
    -> /* using the local variables */
    -> SET a = a + 100;
    -> SET b = 2;
    -> SET c = a + b;
    -> BEGIN
    -> /* local variable in nested block */
    -> DECLARE c INT;
    -> SET c = 5;
    -> /* local variable c takes precedence over the one of the
   /*> same name declared in the enclosing block. */
    -> SELECT a, b, c;
    -> END;
    -> SELECT a, b, c;
    -> END$$
Query OK, 0 rows affected (0.040 sec)




MariaDB [sales_co]> 
MariaDB [sales_co]> delimiter ;
MariaDB [sales_co]> CALL my_procedure_Local_Variables();
+------+------+------+
| a    | b    | c    |
+------+------+------+
|  110 |    2 |    5 |
+------+------+------+
1 row in set (0.001 sec)

+------+------+------+
| a    | b    | c    |
+------+------+------+
|  110 |    2 |  112 |
+------+------+------+










MariaDB [sales_co]> DELIMITER $$
MariaDB [sales_co]> CREATE PROCEDURE my_proc_IN (IN var1 INT)
    -> BEGIN
    -> SELECT * FROM PRODUCT where P_ONHAND = var1;
    -> END$$
Query OK, 0 rows affected (0.064 sec)

MariaDB [sales_co]> DELIMITER ;
MariaDB [sales_co]> call my_proc_IN(8);
+----------+----------------------------------+------------+----------+-------+---------+------------+--------+
| P_CODE   | P_DESCRIPT                       | P_INDATE   | P_ONHAND | P_MIN | P_PRICE | P_DISCOUNT | V_CODE |
+----------+----------------------------------+------------+----------+-------+---------+------------+--------+
| 11QER/31 | Power painter, 15 psi., 3-nozzle | 2003-11-03 |        8 |     5 |  109.99 |          0 |  25595 |
| 2232/QTY | B&D jigsaw, 12-in. blade         | 2003-12-10 |        8 |     5 |  109.92 |       0.05 |  24288 |
| 23114-AA | Sledge hammer, 12 lb.            | 2004-01-20 |        8 |     5 |    14.4 |       0.05 |   NULL |
+----------+----------------------------------+------------+----------+-------+---------+------------+--------+













MariaDB [sales_co]> DELIMITER $$
MariaDB [sales_co]> CREATE PROCEDURE LIMIT_ROW (IN var1 INT)
    -> BEGIN
    -> SELECT * FROM PRODUCT LIMIT var1;
    -> END$$
Query OK, 0 rows affected (0.073 sec)

MariaDB [sales_co]> DELIMITER ;
MariaDB [sales_co]> call LIMIT_ROW (8);
+----------+----------------------------------+------------+----------+-------+---------+------------+--------+
| P_CODE   | P_DESCRIPT                       | P_INDATE   | P_ONHAND | P_MIN | P_PRICE | P_DISCOUNT | V_CODE |
+----------+----------------------------------+------------+----------+-------+---------+------------+--------+
| 11QER/31 | Power painter, 15 psi., 3-nozzle | 2003-11-03 |        8 |     5 |  109.99 |          0 |  25595 |
| 13-Q2/P2 | 7.25-in. pwr. saw blade          | 2003-12-13 |       32 |    15 |   14.99 |       0.05 |  21344 |
| 14-Q1/L3 | 9.00-in. pwr. saw blade          | 2003-11-13 |       18 |    12 |   17.49 |          0 |  21344 |
| 1546-QQ2 | Hrd. cloth, 1/4-in., 2x50        | 2004-01-04 |       15 |     8 |   39.95 |          0 |  23119 |
| 1558-QW1 | Hrd. cloth, 1/2-in., 3x50        | 2004-01-15 |       23 |     5 |   43.99 |          0 |  23119 |
| 2232/QTY | B&D jigsaw, 12-in. blade         | 2003-12-10 |        8 |     5 |  109.92 |       0.05 |  24288 |
| 2232/QWE | B&D jigsaw, 8-in. blade          | 2003-12-24 |        6 |     5 |   99.87 |       0.05 |  24288 |
| 2238/QPD | B&D cordless drill, 1/2-in.      | 2004-01-20 |       12 |     5 |   38.95 |       0.05 |  25595 |
+----------+----------------------------------+------------+----------+-------+---------+------------+--------+









































MariaDB [fb]> DELIMITER $$
MariaDB [fb]> CREATE
    -> TRIGGER `blog_after_insert` AFTER INSERT
    -> ON fb.`blog`
    -> FOR EACH ROW BEGIN
    -> INSERT INTO audit (blog_id, changetype) VALUES (NEW.id, 'NEW');
    -> END
    -> $$




MariaDB [fb]> delimiter $$
MariaDB [fb]> CREATE
    -> TRIGGER `blog_after_update` AFTER UPDATE
    -> ON fb.`blog`
    -> FOR EACH ROW BEGIN
    -> IF NEW.deleted THEN
    -> SET @changetype = 'DELETE';
    -> ELSE
    -> SET @changetype = 'EDIT';
    -> END IF;
    -> INSERT INTO audit (blog_id, changetype) VALUES (NEW.id,
    -> @changetype);
    -> END $$
Query OK, 0 rows affected (0.123 sec)

MariaDB [fb]> delimiter ;





MariaDB [fb]> INSERT INTO blog (title, content) VALUES ('Article One', 'Initial');
Query OK, 1 row affected (0.108 sec)

MariaDB [fb]> select * from blog
    -> ;
+----+-------------+---------+---------+
| id | title       | content | deleted |
+----+-------------+---------+---------+
|  1 | Article One | Initial |       0 |
+----+-------------+---------+---------+





MariaDB [fb]> UPDATE blog SET deleted = 1 WHERE id = 1;
Query OK, 1 row affected (0.215 sec)
Rows matched: 1  Changed: 1  Warnings: 0

MariaDB [fb]> select * from blog;
+----+-------------+---------+---------+
| id | title       | content | deleted |
+----+-------------+---------+---------+
|  1 | Article One | Initial |       1 |
+----+-------------+---------+---------+








