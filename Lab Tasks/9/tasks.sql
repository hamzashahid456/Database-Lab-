MariaDB [fb]> create database person;
Query OK, 1 row affected (0.001 sec)

MariaDB [person]> create table summary(id int PRIMARY KEY, total_users int, yahoo int, hotmail int, gmail int);
Query OK, 0 rows affected (0.291 sec)

MariaDB [person]> create table users(user_id int PRIMARY KEY, username varchar(60), password varchar(70), email varchar(70), salary int);
Query OK, 0 rows affected (0.256 sec)

MariaDB [person]> delimiter $$
MariaDB [person]> create procedure pro1(IN var1 int, IN var2 int, IN var3 int, IN var4 int, IN var5 int )
    -> begin
    -> insert into summary(id,total_users,yahoo,hotmail,gmail) values(var1, var2, var3, var4,var5);
    -> end $$
Query OK, 0 rows affected (0.096 sec)

MariaDB [person]> call pro1 (1,2,1,0,1)$$
Query OK, 1 row affected (0.058 sec)

MariaDB [person]> select * from summary$$
+----+-------------+-------+---------+-------+
| id | total_users | yahoo | hotmail | gmail |
+----+-------------+-------+---------+-------+
|  1 |           2 |     1 |       0 |     1 |
+----+-------------+-------+---------+-------+
1 row in set (0.001 sec)




TASK 2:

create procedure pro2(IN var1 int_, IN var2 varchar(60), IN var3 varchar(70), IN var4 varchar(70), IN var5 int ) begin insert into users(user_id,username,password,email,salary) values(var1, var2, var3, var4,var5); end$$



TASK 3:
MariaDB [person]> create procedure total_records(out records int)
    -> begin
    -> select count(user_id) from users;
    -> end $$
Query OK, 0 rows affected (0.084 sec)

MariaDB [person]> call total_records(@records)$$
+----------------+
| count(user_id) |
+----------------+
|              2 |
+----------------+
1 row in set (0.001 sec)









