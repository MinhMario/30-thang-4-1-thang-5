CREATE TABLE thong_ke_giang_vien (
  ten_giang_vien   VARCHAR(100),
  so_luong_khoa_hoc INT
);

CREATE TABLE doanh_thu_khoa_hoc (
  ten_khoa_hoc VARCHAR(150),
  tong_doanh_thu DECIMAL(15,2)
);

CREATE TABLE sv_nhieu_mon (
  ten_sinh_vien  VARCHAR(100),
  so_luong_mon   INT
);

CREATE TABLE khoa_hoc_chat_luong_kem (
  ten_khoa_hoc  VARCHAR(150),
  diem_trung_binh DECIMAL(4,2)
);

SELECT
  t.full_name        AS ten_giang_vien,
  COUNT(c.id)        AS so_luong_khoa_hoc
FROM       teachers t
LEFT JOIN  courses  c ON c.teacher_id = t.id
GROUP BY  t.id, t.full_name
ORDER BY  so_luong_khoa_hoc DESC;

SELECT
  c.course_name                        AS ten_khoa_hoc,
  COUNT(e.id) * c.tuition_fee          AS tong_doanh_thu
FROM      courses     c
LEFT JOIN enrollments e ON e.course_id = c.id
GROUP BY c.id, c.course_name, c.tuition_fee
ORDER BY tong_doanh_thu DESC;

SELECT
  s.full_name   AS ten_sinh_vien,
  COUNT(e.id)   AS so_luong_mon
FROM      students    s
JOIN      enrollments e ON e.student_id = s.id
GROUP BY s.id, s.full_name
HAVING   COUNT(e.id) >= 3
ORDER BY so_luong_mon DESC;



SELECT
  c.course_name      AS ten_khoa_hoc,
  ROUND(AVG(e.score), 2) AS diem_trung_binh
FROM      courses     c
JOIN      enrollments e ON e.course_id = c.id
WHERE     e.score IS NOT NULL
GROUP BY c.id, c.course_name
HAVING   AVG(e.score) < 5.0
ORDER BY diem_trung_binh ASC;