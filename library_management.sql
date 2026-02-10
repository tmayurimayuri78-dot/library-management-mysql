CREATE DATABASE LIB_DICT;
USE LIB_DICT;
CREATE TABLE Students (student_id INT PRIMARY KEY,name VARCHAR(100),email VARCHAR(100),join_date DATE);
SELECT * FROM Students;

CREATE TABLE Books (book_id INT PRIMARY KEY,book_name VARCHAR(100),author VARCHAR(100),total_copies INT,available_copies INT);
SELECT * FROM Books;

CREATE TABLE Borrow (borrow_id INT AUTO_INCREMENT PRIMARY KEY,student_id INT,book_id INT,borrow_date DATE,
    due_date DATE,return_date DATE,fine_amount INT DEFAULT 0,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),FOREIGN KEY (book_id) REFERENCES Books(book_id)
);
SELECT * FROM Borrow;

SELECT * FROM Borrow WHERE return_date IS NULL;

UPDATE Books b JOIN Borrow br ON b.book_id = br.book_id SET b.available_copies = b.available_copies - 1 WHERE br.return_date IS NULL;

SELECT book_id, book_name, total_copies, available_copies FROM Books;
SELECT student_id, fine_amount FROM Borrow WHERE fine_amount > 0;

CREATE TABLE Audit_Log (log_id INT AUTO_INCREMENT PRIMARY KEY,table_name VARCHAR(50),action_type VARCHAR(20),user_name VARCHAR(50),
    action_time DATETIME,description TEXT);
    
SHOW TABLES;
SELECT DATABASE();
USE LIB_DICT;
SHOW TRIGGERS;


DELIMITER //

CREATE TRIGGER borrow_insert_audit
AFTER INSERT ON Borrow
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log
    (table_name, action, action_time)
    VALUES
    ('Borrow', 'INSERT', NOW());
END//

DELIMITER ;

SHOW TRIGGERS;
ALTER TABLE Audit_Log ADD action VARCHAR(20);

DROP TRIGGER IF EXISTS borrow_insert_audit;

DELIMITER //

CREATE TRIGGER borrow_insert_audit
AFTER INSERT ON borrow
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (table_name, action, action_time)
    VALUES ('borrow', 'INSERT', NOW());
END//

DELIMITER ;

DELIMITER //

CREATE TRIGGER borrow_insert_audit_v2
AFTER INSERT ON borrow
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (table_name, action, action_time)
    VALUES ('borrow', 'INSERT', NOW());
END//

DELIMITER ;

SHOW TRIGGERS;

INSERT INTO borrow (student_id, book_id, borrow_date)
VALUES (1, 1, CURDATE());

SELECT * FROM Audit_Log;

DELIMITER //

CREATE FUNCTION calculate_fine(due DATE, ret DATE)
RETURNS INT
DETERMINISTIC
BEGIN
    IF ret > due THEN
        RETURN DATEDIFF(ret, due) * 5;
    ELSE
        RETURN 0;
    END IF;
END//

DELIMITER ;

SHOW FUNCTION STATUS WHERE Name = 'calculate_fine';

SELECT calculate_fine('2026-02-01', '2026-02-05');

UPDATE borrow SET fine_amount = calculate_fine(due_date, return_date) WHERE borrow_id = 1;
SELECT borrow_id, due_date, return_date, fine_amount FROM borrow;

SELECT * FROM Borrow WHERE return_date IS NULL;

SELECT student_id, SUM(fine_amount) AS total_fine FROM Borrow GROUP BY student_id;

SELECT book_id, COUNT(*) AS times_borrowed FROM Borrow GROUP BY book_id;
























