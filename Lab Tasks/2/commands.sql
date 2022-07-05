create table themepark( park_code varchar(10) primary key, park_name varchar(35) not null,park_city varchar(50) not null, park_country char(2) not null);

create table employee( emp_num numeric(4) primary key, emp_title varchar(4), emp_Lname varchar(15) not null, emp_Fname varchar(15) not null,emp_DOB date not null, emp_hire_date date,emp_area_code varchar(4) not null, emp_phone varchar(12) not null, park_code varchar(10), index (park_code), constraint fk_emp_park foreign key(park_code) references themepark(park_code) );


