
-- 1)Create a New Book Record
 -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"
 
 Insert into books(isbn,book_title,category,rental_price,book_status,author,publisher)
   values 
   ('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');
   SELECT * FROM books;
   
-- 2)Update an Existing Member's Address

   Update members
   set address='nalgonda'
   where member_id='C101';
   SELECT * FROM members;
   
-- 3)Delete a Record from the Issued Status Table
 -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.
  
  Delete From issued_status
  where issued_id ='IS121';
  SELECT * FROM issued_status;
  
-- 4)Retrieve All Books Issued by a Specific Employee
-- Objective: Select all books issued by the employee with emp_id = 'E101'.

Select issued_book_name 
 From 
 issued_status
where issued_emp_id='E101';

-- 5) List Members Who Have Issued More Than One Book
-- Objective: Use GROUP BY to find members who have issued more than one book.
 
 Select m.member_name, ist.issued_member_id,count(*)
 From issued_status as ist 
 join members as m
 on ist.issued_member_id =m.member_id
 Group by 1,2
 having count(*)>1;
 
 -- 6: Create Summary Tables: Used CTAS to generate new tables based on query results 
 -- each book and total book_issued_cnt**
 
 Create Table book_issued_cnt as
 Select  b.book_title,count(*) as Total_count
 From issued_status as ist 
 join books as b
 on ist.issued_book_name =b.book_title
 Group by 1;
 
 -- 7:Retrieve All Books in a Specific Category:
 
 Select book_title From 
 books
 where category='classic';
 
 -- 8: Find Total Rental Income by Category:

 Select category,
      sum(rental_price) 
         as Rental_income
 From
 issued_status as ist
 join books as b
 on ist.issued_book_isbn=b.isbn
 group by 1;
 
-- 9:List Members Who Registered in the Last 180 Days:

	Select member_name 
	From members 
	where reg_date >= current_date() - interval 180 Day;

-- 10: List Employees with Their Branch Manager's Name and their branch details:

Select e2.emp_name, b.branch_id,
         b.branch_address,
             b.contact_no
             ,e1.emp_name as manager  From
branch as b
join Employees as e1
on b.manager_id=e1.emp_id
join Employees as e2
on b.branch_id=e2.branch_id;
--  Create a Table of Books with Rental Price Above a Certain Threshold:

	 Create table threshold as
	 select book_title ,rental_price
	 From books
	 where rental_price >=5;
     
--12 Retrieve the List of Books Not Yet Returned

Select ist.issued_book_name as Not_returned
From issued_status as ist
left join return_status as rst
on ist.issued_id=rst.issued_id
where rst.return_id is null
