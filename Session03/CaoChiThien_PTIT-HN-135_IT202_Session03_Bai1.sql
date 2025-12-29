CREATE DATABASE session03Bai01;
USE session03Bai01;
CREATE TABLE Student (
    student_id VARCHAR(10) PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(50) UNIQUE
);
INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES 
('SV001', 'Nguyễn Văn An', '2003-05-12', 'an.nguyen@gmail.com'),
('SV002', 'Trần Thị Bình', '2002-11-20', 'binh.tran@gmail.com'),
('SV003', 'Lê Văn Cường', '2003-01-08', 'cuong.le@gmail.com');
SELECT * FROM Student;
SELECT student_id, full_name FROM Student;
