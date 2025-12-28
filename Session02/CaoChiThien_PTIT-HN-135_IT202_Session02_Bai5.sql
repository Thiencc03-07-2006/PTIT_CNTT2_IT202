create database session02Bai05;
use session02Bai05;
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL
);
CREATE TABLE Subject (
    subject_id INT PRIMARY KEY,
    subject_name VARCHAR(50) NOT NULL,
    credit INT NOT NULL,
    CHECK (credit > 0)
);
CREATE TABLE Enrollment (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    enroll_date DATE NOT NULL,
    PRIMARY KEY (student_id, subject_id),
	FOREIGN KEY (student_id) REFERENCES Student(student_id),
	FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);
CREATE TABLE Teacher (
    teacher_id INT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    email VARCHAR(50) NOT NULL UNIQUE
);
ALTER TABLE Subject
ADD teacher_id INT NOT NULL,
ADD FOREIGN KEY (teacher_id) REFERENCES Teacher(teacher_id);
CREATE TABLE Score (
    student_id INT NOT NULL,
    subject_id INT NOT NULL,
    mid_score DECIMAL(4,2) NOT NULL,
    final_score DECIMAL(4,2) NOT NULL,
    PRIMARY KEY (student_id, subject_id),
	CHECK (mid_score >= 0 AND mid_score <= 10),
	CHECK (final_score >= 0 AND final_score <= 10),
	FOREIGN KEY (student_id) REFERENCES Student(student_id),
	FOREIGN KEY (subject_id) REFERENCES Subject(subject_id)
);