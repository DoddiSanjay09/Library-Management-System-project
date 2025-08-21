# project--library_management_system

CREATE DATABASE library_db;
USE library_db;
-- creating branch table
CREATE TABLE branch
(
   branch_id varchar(10) primary key,
   manager_id varchar(10),
   branch_address varchar(20),
   contact_no varchar(10)
);

Alter Table branch
Modify contact_no varchar(20);

-- creating Employees table
CREATE TABLE Employees
(
   emp_id varchar(10) primary key,
   emp_name varchar(10),
   position varchar(20),
   salary decimal(10,2),
   branch_id varchar(10),
   Foreign key (branch_id) References branch(branch_id)
);

Alter Table Employees
Modify emp_name varchar(30);

-- creating books table
CREATE TABLE books
(
   isbn varchar(10) primary key,
   book_title varchar(30),
   category varchar(20),
   rental_price decimal(10,2),
   book_status varchar(15),
   author varchar(30),
   publisher varchar(30)
);

Alter Table books
Modify isbn varchar(50);

Alter Table books
Modify book_title varchar(80);

-- creating members table
CREATE TABLE members
(
   member_id varchar(10) primary key,
   member_name varchar(30),
   address varchar(30),
   reg_date DATE
);
-- creating issued_status table
CREATE TABLE issued_status
(
   issued_id varchar(10) primary key,
   issued_member_id varchar(30),
   issued_book_name varchar(50),
   issued_date date,
   issued_book_isbn varchar(50),
   issued_emp_id varchar(10),
   Foreign key (issued_book_isbn) References books(isbn),
   Foreign key (issued_member_id) References members(member_id),
   Foreign key (issued_emp_id) References Employees(emp_id) 
);

Alter Table issued_status
Modify issued_book_name varchar(80);

-- creating return_status table
CREATE TABLE return_status
(
   return_id varchar(10) primary key,
   issued_id varchar(30),
   return_book_name varchar(50),
   return_date date,
   return_book_isbn varchar(50),
   Foreign key (return_book_isbn) References books(isbn),
   FOREIGN KEY (issued_id) REFERENCES issued_status(issued_id) ON DELETE CASCADE
);

