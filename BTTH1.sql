-- Bảng giảng viên
CREATE TABLE teachers (
  id       INT PRIMARY KEY AUTO_INCREMENT,
  full_name VARCHAR(100) NOT NULL,
  salary   DECIMAL(12,2) NOT NULL CHECK(salary >= 0)
);

-- Bảng khóa học
CREATE TABLE courses (
  id          INT PRIMARY KEY AUTO_INCREMENT,
  course_name VARCHAR(150) NOT NULL,
  teacher_id  INT NULL,          -- NULL = chưa phân công
  credits     INT NOT NULL CHECK(credits > 0),
  tuition_fee DECIMAL(12,2) NOT NULL CHECK(tuition_fee >= 0),
  FOREIGN KEY(teacher_id) REFERENCES teachers(id) ON DELETE SET NULL
);

-- Bảng sinh viên
CREATE TABLE students (
  id            INT PRIMARY KEY AUTO_INCREMENT,
  full_name     VARCHAR(100) NOT NULL,
  date_of_birth DATE         NOT NULL,
  gender        ENUM('Nam','Nữ','Khác') NOT NULL
);

-- Bảng đăng ký
CREATE TABLE enrollments (
  id         INT PRIMARY KEY AUTO_INCREMENT,
  student_id INT  NOT NULL,
  course_id  INT  NOT NULL,
  date       DATE NOT NULL,
  score      DECIMAL(4,1) NULL CHECK(score BETWEEN 0 AND 10),
  FOREIGN KEY(student_id) REFERENCES students(id),
  FOREIGN KEY(course_id)  REFERENCES courses(id)
);

-- 3 giảng viên
INSERT INTO teachers (full_name, salary) VALUES
  ('Nguyễn Văn An',   15000000),
  ('Trần Thị Bình',   18000000),
  ('Lê Hoàng Cường',  12000000);

-- 6 khóa học (1 khóa chưa phân công giảng viên)
INSERT INTO courses (course_name, teacher_id, credits, tuition_fee) VALUES
  ('Lập trình cơ bản',      1, 3, 3000000),
  ('Cơ sở dữ liệu',         1, 3, 3500000),
  ('Mạng máy tính',         2, 3, 3200000),
  ('Trí tuệ nhân tạo',      2, 4, 4500000),
  ('An toàn thông tin',      3, 3, 4000000),
  ('Thiết kế đồ họa',     NULL, 2, 2500000); -- chưa phân công

-- 10 sinh viên
INSERT INTO students (full_name, date_of_birth, gender) VALUES
  ('Phạm Minh Đức',   '2003-05-10', 'Nam'),
  ('Hoàng Thị Lan',   '2003-08-22', 'Nữ'),
  ('Vũ Quốc Bảo',    '2004-01-15', 'Nam'),
  ('Ngô Thị Cẩm',    '2003-11-30', 'Nữ'),
  ('Đinh Văn Hùng',  '2002-07-04', 'Nam'),
  ('Lý Thị Mai',     '2004-03-19', 'Nữ'),
  ('Trịnh Công Sơn', '2003-09-08', 'Nam'),
  ('Bùi Thị Hà',    '2002-12-25', 'Nữ'),
  ('Dương Văn Tài',  '2004-06-11', 'Nam'),
  ('Phan Thị Ngọc',  '2003-02-14', 'Nữ');

-- 15 lượt đăng ký (2 lượt chưa có điểm — score NULL)
INSERT INTO enrollments (student_id, course_id, date, score) VALUES
  (1, 1, '2024-09-01', 8.5),
  (1, 2, '2024-09-01', 7.0),
  (2, 1, '2024-09-02', 9.0),
  (2, 3, '2024-09-02', 6.5),
  (3, 2, '2024-09-03', 7.5),
  (3, 4, '2024-09-03', 8.0),
  (4, 1, '2024-09-04', 6.0),
  (4, 5, '2024-09-04', 9.5),
  (5, 3, '2024-09-05', 7.0),
  (5, 4, '2024-09-05', 8.5),
  (6, 2, '2024-09-06', 5.5),
  (7, 5, '2024-09-07', 7.5),
  (8, 3, '2024-09-08', 8.0),
  (9, 1, '2024-09-09', NULL),  -- chưa thi
  (10,2, '2024-09-10', NULL); -- chưa thi
  
UPDATE teachers
SET    salary = salary * 1.10
WHERE  id IN (
  SELECT DISTINCT teacher_id  -- distinct giúp loại bỏ trùng lặp
  FROM   courses
  WHERE  course_name LIKE '%IT%'
    AND  teacher_id IS NOT NULL
);