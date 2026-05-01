CREATE TABLE ds_khoa_hoc_giang_vien (
  ma_khoa_hoc  INT,
  ten_khoa_hoc VARCHAR(150),
  giang_vien   VARCHAR(100) NULL  -- NULL nếu chưa phân công
);
CREATE TABLE ds_sinh_vien_2005 (
  ma_sv         INT,
  ten_sinh_vien VARCHAR(100),
  date_of_birth DATE
);
CREATE TABLE bang_diem_lap_trinh_web (
  ten_sv   VARCHAR(100),
  ma_sv    INT,
  diem_thi DECIMAL(4,1) NULL  -- NULL nếu chưa thi
);
CREATE TABLE bao_cao_tong_hop (
  ten_sinh_vien VARCHAR(100),
  ten_khoa_hoc  VARCHAR(150),
  giang_vien    VARCHAR(100) NULL  -- NULL nếu khóa chưa có GV
);
SELECT
  c.id           AS ma_khoa_hoc,
  c.course_name  AS ten_khoa_hoc,
  t.full_name    AS giang_vien
FROM      courses  c
LEFT JOIN teachers t ON c.teacher_id = t.id;

SELECT
  id        AS ma_sv,
  full_name AS ten_sinh_vien,
  date_of_birth
FROM  students
WHERE YEAR(date_of_birth) = 2005;

SELECT
  s.full_name AS ten_sv,
  s.id        AS ma_sv,
  e.score     AS diem_thi
FROM      enrollments e
JOIN      students    s ON e.student_id = s.id
JOIN      courses     c ON e.course_id  = c.id
WHERE     c.course_name = 'Lập trình Web'
ORDER BY e.score DESC;

SELECT
  s.full_name AS ten_sinh_vien,
  c.course_name  AS ten_khoa_hoc,
  t.full_name AS giang_vien
FROM      enrollments e
JOIN      students    s ON e.student_id = s.id
JOIN      courses     c ON e.course_id  = c.id
LEFT JOIN teachers    t ON c.teacher_id = t.id
ORDER BY s.full_name;