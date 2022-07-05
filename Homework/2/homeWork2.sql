1:
select max(hisal) from salgrade;
+------------+
| max(hisal) |
+------------+
|      10000 |
+------------+

2:
select empno, ename from emp where deptno = (select deptno from dept where dname = 'Sales');
+-------+--------+
| empno | ename  |
+-------+--------+
|  7499 | Allen  |
|  7521 | Ward   |
|  7654 | Martin |
|  7698 | Blake  |
|  7844 | Turner |
|  7900 | James  |
+-------+--------+

3:
select empno, ename from emp where deptno = (select deptno from dept where location = 'New York');
+-------+--------+
| empno | ename  |
+-------+--------+
|  7782 | Clark  |
|  7839 | King   |
|  7934 | Miller |
+-------+--------+

4:
select count(empno) from emp where deptno = (select deptno from dept where dname = 'Sales')
    -> ;
+--------------+
| count(empno) |
+--------------+
|            6 |
+--------------+

5:
select empno, ename from emp where salary > ALL(select salary from emp where deptno = 30) ;
+-------+-------+
| empno | ename |
+-------+-------+
|  7566 | Jones |
|  7788 | Scott |
|  7839 | King  |
|  7902 | Ford  |
+-------+-------+


6:
select empno, ename from emp where salary > (select min(salary) from emp where deptno = '30' );
+-------+--------+
| empno | ename  |
+-------+--------+
|  7499 | Allen  |
|  7521 | Ward   |
|  7566 | Jones  |
|  7654 | Martin |
|  7698 | Blake  |
|  7782 | Clark  |
|  7788 | Scott  |
|  7813 | David  |
|  7839 | King   |
|  7844 | Turner |
|  7876 | Adams  |
|  7902 | Ford   |
|  7934 | Miller |
+-------+--------+


