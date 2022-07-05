E6.1:
create view EMPFR AS select * from EMPLOYEE where EMP_NUM = '100';

select * from EMPFR;
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
| EMP_NUM | EMP_TITLE | EMP_LNAME  | EMP_FNAME | EMP_DOB    | EMP_HIRE_DATE | EMP_AREA_CODE | EMP_PHONE | PARK_CODE |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
|     100 | Ms        | Calderdale | Emma      | 1972-06-15 | 1992-03-15    | 0181          | 324-9134  | FR1001    |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+

update EMPFR 
    -> set EMP_PHONE = '324-9652'
    -> where EMP_NUM = '100';

select * from EMPFR;
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
| EMP_NUM | EMP_TITLE | EMP_LNAME  | EMP_FNAME | EMP_DOB    | EMP_HIRE_DATE | EMP_AREA_CODE | EMP_PHONE | PARK_CODE |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+
|     100 | Ms        | Calderdale | Emma      | 1972-06-15 | 1992-03-15    | 0181          | 324-9652  | FR1001    |
+---------+-----------+------------+-----------+------------+---------------+---------------+-----------+-----------+



E6.2:
create view EMP_DETAILS AS
    -> select EMP_NUM, THEMEPARK.PARK_CODE, PARK_NAME, EMP_LNAME,EMP_FNAME, EMP_HIRE_DATE,EMP_DOB  from THEMEPARK join EMPLOYEE on THEMEPARK.PARK_CODE = EMPLOYEE.PARK_CODE;

select * from EMP_DETAILS;
+---------+-----------+--------------+------------+-----------+---------------+------------+
| EMP_NUM | PARK_CODE | PARK_NAME    | EMP_LNAME  | EMP_FNAME | EMP_HIRE_DATE | EMP_DOB    |
+---------+-----------+--------------+------------+-----------+---------------+------------+
|     100 | FR1001    | FairyLand    | Calderdale | Emma      | 1992-03-15    | 1972-06-15 |
|     101 | UK3452    | PleasureLand | Ricardo    | Marshel   | 1996-04-25    | 1978-03-19 |
|     102 | FR1001    | FairyLand    | Arshad     | Arif      | 1990-12-20    | 1969-11-14 |
|     103 | UK3452    | PleasureLand | Roberts    | Anne      | 1994-08-16    | 1974-10-16 |
|     104 | ZA1342    | GoldTown     | Denver     | Enrica    | 2001-10-20    | 1980-11-08 |
|     105 | FR1001    | FairyLand    | Namowa     | Mirrelle  | 2006-11-08    | 1990-03-14 |
|     106 | ZA1342    | GoldTown     | Smith      | Gemma     | 1989-01-05    | 1968-02-12 |
+---------+-----------+--------------+------------+-----------+---------------+------------+

E6.3:
select EMP_FNAME, EMP_LNAME, PARK_NAME from EMP_DETAILS;
+-----------+------------+--------------+
| EMP_FNAME | EMP_LNAME  | PARK_NAME    |
+-----------+------------+--------------+
| Emma      | Calderdale | FairyLand    |
| Marshel   | Ricardo    | PleasureLand |
| Arif      | Arshad     | FairyLand    |
| Anne      | Roberts    | PleasureLand |
| Enrica    | Denver     | GoldTown     |
| Mirrelle  | Namowa     | FairyLand    |
| Gemma     | Smith      | GoldTown     |
+-----------+------------+--------------+

E6.4:
create VIEW TICKET_SALES AS 
    -> select PARK_NAME,min(LINE_PRICE),max(LINE_PRICE),avg(LINE_PRICE) from THEMEPARK join SALES on THEMEPARK.PARK_CODE = SALES.PARK_CODE join SALES_LINE on SALES.TRANSACTION_NO = SALES_LINE.TRANSACTION_NO group by PARK_NAME;
Query OK, 0 rows affected (0.068 sec)

MariaDB [themepark]> select * from TICKET_SALES;
+--------------+-----------------+-----------------+-----------------+
| PARK_NAME    | min(LINE_PRICE) | max(LINE_PRICE) | avg(LINE_PRICE) |
+--------------+-----------------+-----------------+-----------------+
| FairyLand    |           14.99 |          139.96 |       50.232500 |
| GoldTown     |           12.12 |          114.68 |       47.637778 |
| PleasureLand |           21.98 |          168.40 |       60.785714 |
+--------------+-----------------+-----------------+-----------------+



E6.5:

select DISTINCT(DATE_FORMAT(SALE_DATE, '%W-%d-%m %Y' )) from SALES;
+------------------------------------------+
| (DATE_FORMAT(SALE_DATE, '%a %d %m %Y' )) |
+------------------------------------------+
| Fri 18 05 2007                        |
+------------------------------------------+
1 row in set (0.001 sec)


E6.6:
select EMP_FNAME, EMP_LNAME,concat(DATE_FORMAT(EMP_DOB,'%m'),'01',UPPER(SUBSTR(EMP_LNAME,1,6))) as USER_ID from EMPLOYEE;
+-----------+------------+------------+
| EMP_FNAME | EMP_LNAME  | USER_ID    |
+-----------+------------+------------+
| Emma      | Calderdale | 0601CALDER |
| Marshel   | Ricardo    | 0301RICARD |
| Arif      | Arshad     | 1101ARSHAD |
| Anne      | Roberts    | 1001ROBERT |
| Enrica    | Denver     | 1101DENVER |
| Mirrelle  | Namowa     | 0301NAMOWA |
| Gemma     | Smith      | 0201SMITH  |
+-----------+------------+------------+



E6.7:
select EMP_FNAME, EMP_LNAME, EMP_DOB from EMPLOYEE where DATE_FORMAT(EMP_DOB, '%d') = 14;
+-----------+-----------+------------+
| EMP_FNAME | EMP_LNAME | EMP_DOB    |
+-----------+-----------+------------+
| Arif      | Arshad    | 1969-11-14 |
| Mirrelle  | Namowa    | 1990-03-14 |
+-----------+-----------+------------+

E6.8:
select EMP_FNAME, EMP_PHONE,concat(SUBSTR(EMP_PHONE,1,3),LOWER(SUBSTR(EMP_FNAME,1,2))) as USER_PASSWORD from EMPLOYEE;
+-----------+-----------+---------------+
| EMP_FNAME | EMP_PHONE | USER_PASSWORD |
+-----------+-----------+---------------+
| Emma      | 324-9652  | 324em         |
| Marshel   | 324-4472  | 324ma         |
| Arif      | 675-8993  | 675ar         |
| Anne      | 898-3456  | 898an         |
| Enrica    | 504-4434  | 504en         |
| Mirrelle  | 890-3243  | 890mi         |
| Gemma     | 324-7845  | 324ge         |
+-----------+-----------+---------------+




+


