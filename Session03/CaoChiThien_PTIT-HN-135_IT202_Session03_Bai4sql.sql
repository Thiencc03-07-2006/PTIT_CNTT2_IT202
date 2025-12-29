CREATE DATABASE session03Bai04;
USE session03Bai04;
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    date_of_birth DATE,
    email VARCHAR(50) UNIQUE
);
INSERT INTO Student (student_id, full_name, date_of_birth, email)
VALUES 
(1, 'Nguyễn Văn An', '2003-05-12', 'an.nguyen@gmail.com'),
(2, 'Trần Thị Bình', '2002-11-20', 'binh.tran@gmail.com'),
(3, 'Lê Văn Cường', '2003-01-08', 'cuong.le@gmail.com'),
(5, 'Nguyễn Đăng Dương', '2003-03-06', 'duong.nguyen@gmail.com');
SELECT * FROM Student;
SELECT student_id, full_name FROM Student;
UPDATE Student
SET email = 'sv3_moi@gmail.com'
WHERE student_id = 3;
UPDATE Student
SET date_of_birth = '2003-09-15'
WHERE student_id = 2;
DELETE FROM Student
WHERE student_id = 5;
SELECT * FROM Student;
CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(100) NOT NULL,
    credit INT NOT NULL,
    CHECK (credit > 0)
);
INSERT INTO Subject (subject_id, subject_name, credit)
VALUES
(1, 'Cơ sở dữ liệu', 3),
(2, 'Lập trình Java', 4),
(3, 'Mạng máy tính', 3);
UPDATE Subject
SET credit = 5
WHERE subject_id = 1;
UPDATE Subject
SET subject_name = 'Hệ quản trị cơ sở dữ liệu'
WHERE subject_id = 1;
SELECT * FROM Subject;
CREATE TABLE Enrollment (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    enroll_date DATE NOT NULL,
    PRIMARY KEY (student_id, subject_id),
	FOREIGN KEY (student_id)
	REFERENCES Student(student_id),
	FOREIGN KEY (subject_id)
	REFERENCES Subject(subject_id)
);
INSERT INTO Enrollment (student_id, subject_id, enroll_date)
VALUES
(1, 1, '2025-12-28'),
(1, 2, '2025-12-28'),
(2, 2, '2025-12-29'),
(3, 3, '2025-12-30');
SELECT * FROM Enrollment;
SELECT * FROM Enrollment WHERE student_id=1;
CREATE TABLE Score (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    mid_score DECIMAL(4,2),
    final_score DECIMAL(4,2),
    PRIMARY KEY (student_id, subject_id),
	FOREIGN KEY (student_id)
	REFERENCES Student(student_id),
	FOREIGN KEY (subject_id)
	REFERENCES Subject(subject_id),
    CHECK (mid_score >= 0 AND mid_score <= 10),
    CHECK (final_score >= 0 AND final_score <= 10)
);
