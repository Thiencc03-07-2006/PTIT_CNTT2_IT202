create database session02Bai01;
use session02Bai01;
CREATE TABLE Class (
    class_id INT PRIMARY KEY,
    class_name VARCHAR(50) NOT NULL,
    school_year VARCHAR(9) NOT NULL
);
CREATE TABLE Student (
    student_id INT PRIMARY KEY,
    full_name VARCHAR(50) NOT NULL,
    date_of_birth DATE NOT NULL,
    class_id INT NOT NULL,
	FOREIGN KEY (class_id) REFERENCES Class(class_id)
);
