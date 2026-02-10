# 📘 Library Management System (MySQL) 🪷

This project is a **Library Management System** implemented in **MySQL**.  
It manages library operations including student records, book inventory, borrowing/returning books, fines, and audit logs.  

This is my **first MySQL project**, where I learned database creation, table relationships, triggers, functions, events, and audit logging.

---

## 🚀 Features 🖤🦾

- **Students Table**: Stores student details (*student_id, name, email, join_date*).  
- **Books Table**: Tracks books (*book_id, book_name, author, total_copies, available_copies*).  
- **Borrow Table**: Records borrowing transactions with foreign keys referencing students and books.  
- **Audit Log Table**: Logs all insert operations into Borrow table via triggers.  
- **Triggers**: Automatically log borrow actions into the audit log.  
- **Functions**: `calculate_fine()` computes fines for overdue returns.  
- **Fine Management**: Update fine amounts based on due date and return date.  
- **Reports**: Track total fines per student and borrowing frequency per book.  
- **CSV Import**: Load student data directly from external CSV files.  

---

## 🛠 Database Schema

### Students
| Column      | Type        | Notes           |
|------------|------------|----------------|
| student_id | INT        | Primary Key    |
| name       | VARCHAR(100) | Student Name |
| email      | VARCHAR(100) | Email Address |
| join_date  | DATE       | Enrollment Date |

### Books
| Column          | Type        | Notes           |
|----------------|------------|----------------|
| book_id        | INT        | Primary Key    |
| book_name      | VARCHAR(100) | Book Title    |
| author         | VARCHAR(100) | Book Author   |
| total_copies   | INT        | Total Copies  |
| available_copies | INT      | Available Copies |

### Borrow
| Column       | Type       | Notes                     |
|-------------|------------|---------------------------|
| borrow_id    | INT AUTO_INCREMENT | Primary Key      |
| student_id   | INT        | Foreign Key → Students    |
| book_id      | INT        | Foreign Key → Books       |
| borrow_date  | DATE       | Borrowed Date             |
| due_date     | DATE       | Due Date                  |
| return_date  | DATE       | Returned Date             |
| fine_amount  | INT        | Default 0                 |

### Audit_Log
| Column      | Type         | Notes                        |
|------------|-------------|-------------------------------|
| log_id     | INT AUTO_INCREMENT | Primary Key              |
| table_name | VARCHAR(50) | Table where action occurred  |
| action     | VARCHAR(20) | Type of action (INSERT/UPDATE) |
| action_time| DATETIME    | Timestamp of action          |
| description| TEXT        | Optional description         |

---

## ⚡ Triggers & Functions

- **Trigger**: `borrow_insert_audit` logs each new borrow record automatically into `Audit_Log`.

```sql
DELIMITER //
CREATE TRIGGER borrow_insert_audit
AFTER INSERT ON Borrow
FOR EACH ROW
BEGIN
    INSERT INTO Audit_Log (table_name, action, action_time)
    VALUES ('borrow', 'INSERT', NOW());
END//
DELIMITER ;
```

-----

📥 Installation / Usage

Library-Management-System/
│
├─ README.md
├─ SQL/
│   ├─ 01_create_database.sql
│   ├─ 02_create_tables.sql
│   ├─ 03_insert_sample_data.sql
│   ├─ 04_triggers.sql
│   └─ 05_functions.sql
├─ CSV/
│   └─ students.csv
└─ ER_Diagram/
    └─ library_er_diagram.png

----

🗂 Folder Structure

Library-Management-System/
│
├─ README.md
├─ SQL/
│   ├─ create_database.sql
│   ├─ create_tables.sql
│   ├─ insert_sample_data.sql
│   ├─ triggers.sql
│   └─ functions.sql
├─ CSV/
│   └─ students.csv
└─ ER_Diagram/
    └─ library_er_diagram.png


---
