📘 Library Management System (MySQL)🙏🪷
Overview
This project is a Library Management System implemented in MySQL.
It includes tables for students, books, borrow records, audit logs, triggers, functions, and events to manage library operations such as borrowing, returning, fines, and auditing.

Features🖤🦾
- Students Table: Stores student details (ID, Name, Email, Join Date).
- Books Table: Tracks books, authors, total copies, and available copies.
- Borrow Table: Records borrowing transactions with foreign key constraints.
- Audit Log Table: Logs changes (INSERT, UPDATE) with triggers.
- Indexes: Created for faster lookups on student and book IDs.
- Triggers: Automatically log borrow actions into the audit log.
- Functions: calculate_fine() to compute late return fines.
- Events: Daily fine update for overdue books.
- CSV Import: Load student data from external CSV files.

  
Setup Instructions⚙️
- Clone the repository:
          git clone https://github.com/your-username/library-db.git

- Open MySQL and run:
          SOURCE library.sql;
          
- Ensure local_infile is enabled for CSV import:
          SET GLOBAL local_infile = 1;
  
- Place your students.csv file in the correct path and run:
          LOAD DATA LOCAL INFILE 'D:/mysql/Project/students.csv'
          INTO TABLE students
          FIELDS TERMINATED BY ','
          ENCLOSED BY '"'
          LINES TERMINATED BY '\n'
          IGNORE 1 ROWS;


Example Queries🤔

- View all students:
      SELECT * FROM Students;
  
- View borrowed books:
      SELECT * FROM Borrow;
  
- Calculate fines:
      SELECT Students_id, SUM(fine_amount) AS total_fine
      FROM Borrow
      GROUP BY Students_id;


Future Improvements😊

- Add user authentication for librarians.
- Create stored procedures for borrowing/returning books.
- Build a front-end interface (HTML/CSS/JS or Java).

IMPORTANT POINT
-I only create a 20 students details , and 5 book database , if you want more datas you can be use the code to assign multi values
- And borrowed book fees in null . because  they all the students retuen the before the  due data 

This README gives clarity for anyone who downloads your repo. It explains what’s inside, how to run it, and what features are implemented.
Would you like me to also draft a sample students.csv file format so that others can test your script easily?
