CREATE TABLE sv_tre_hon_sv001 (
  ma_sv         VARCHAR(20),
  ten_sinh_vien VARCHAR(100),
  date_of_birth DATE
);

CREATE TABLE thu_khoa_tieng_anh (
  ten_sinh_vien VARCHAR(100),
  ma_sv         INT,
  diem          DECIMAL(4,1)
);

CREATE TABLE sv_chua_dang_ky (
  ma_sv         INT,
  ten_sinh_vien VARCHAR(100)
);

SELECT
  id            AS ma_sv,
  full_name     AS ten_sinh_vien,
  date_of_birth
FROM  students
WHERE date_of_birth > (
  SELECT date_of_birth
  FROM   students
  WHERE  id = 'SV001'
);

SELECT
  s.full_name AS ten_sinh_vien,
  s.id        AS ma_sv,
  e.score     AS diem
FROM      enrollments e
JOIN      students    s ON e.student_id = s.id
JOIN      courses     c ON e.course_id  = c.id
WHERE     c.course_name = 'Tiếng Anh Giao Tiếp'
  AND     e.score = (
    SELECT MAX(e2.score)
    FROM   enrollments e2
    JOIN   courses     c2 ON e2.course_id = c2.id
    WHERE  c2.course_name = 'Tiếng Anh Giao Tiếp'
  );
  
SELECT
  s.id        AS ma_sv,
  s.full_name AS ten_sinh_vien
FROM  students s
WHERE NOT EXISTS (
  SELECT 1
  FROM   enrollments e
  WHERE  e.student_id = s.id
);


DELETE FROM enrollments
WHERE course_id = (
  SELECT id
  FROM   courses
  WHERE  course_name = 'Triết học'
);


DELETE FROM courses
WHERE course_name = 'Triết học';