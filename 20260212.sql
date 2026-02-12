-- 1. CREATE : 테이블 생성
-- CREATE TABLE students (
-- 	student_id INT AUTO_INCREMENT PRIMARY KEY,
-- 	full_name VARCHAR(50) NOT NULL,
-- 	email VARCHAR(100) UNIQUE,
-- 	birth_date DATE,
-- 	created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
-- );
-- 
-- 컬럼 추가
-- ALTER TABLE students ADD phone VARCHAR(20);
-- 
-- 컬럼 데이터 타입 수정
-- ALTER TABLE students MODIFY COLUMN full_name VARCHAR(100);
-- 
-- 테이블 삭제
-- DROP TABLE students;
-- 
-- INSERT
-- row 하나만 삽입한 예시
-- INSERT INTO students (full_name, email, birth_date)
--  	VALUES ('김일', 'kim1@test.com', '2026-02-26');
-- 	
-- 여러 rowo를 한꺼번에 삽입
-- INSERT INTO students (full_name, email)
-- 	VALUES ('김이', 'kim2@test.com'),
-- 			 ('김삼', 'kim3@test.com');
-- 			 
-- UPDATE
-- UPDATE students SET birth_date = '1990-01-01'
-- 	WHERE student_id = 2;	
-- 
-- UPDATE students SET phone = '010-8625-7953'
-- 	WHERE student_id = 3;
-- 	
-- DELETE FROM students WHERE student_id = 4;

-- INSERT INTO courses (coures_name, professor, creadits)
-- 	VALUES('데이터베이스기초', '강교수', 3),
-- 			('자바프로그래밍', '이교수', 4),
-- 			('웹디자인', '박교수', 2);
			
-- INSERT INTO enrollments (student_id, course_id, enrollments_date)
-- 	VALUES(1, 1, '2026-02-01'),
-- 			(1, 2, '2026-02-01'),
-- 			(2, 1, '2026-02-02');
			
-- SELECT * FROM students;
-- SELECT * FROM courses;
-- SELECT * FROM enrollments;

-- 김일 학생이 수강하고 있는 과목을 표시하고 등록날짜도 표시하고 그 교수 이름도 출력.
-- SELECT s.full_name, c.coures_name, c.professor, e.enrollments_date 
-- 	FROM students s
-- 	JOIN enrollments e 
-- 	ON s.student_id = e.student_id
-- 	JOIN courses c
-- 	ON c.course_id = e.course_id
-- 	WHERE s.student_id = 1;
	
-- 1-1
-- INSERT INTO students (full_name, email, birth_date, phone)
-- 	VALUES ('박지민', 'park@test.com', '1995-05-05', '010-5555-6666');
	
-- 1-2
-- INSERT INTO courses (coures_name, professor, creadits)
-- 	VALUES ('파이썬 프로그래밍', '최교수', 3)
	
-- 1-3
-- INSERT INTO enrollments (student_id, course_id, enrollments_date)
-- 	VALUES (4, 1, '2026-02-12'),
-- 			(4, 4, '2026-02-12');

-- SELECT * FROM enrollments;

-- 2-1 
SELECT course_name, professor FROM courses
	WHERE professor = '이교수';
	
-- 2-2
SELECT full_name, phone FROM students
	WHERE email LIKE '%test.com';
	
-- 2-3
SELECT s.full_name, c.course_name, e.enrollments_date
	FROM students s
	JOIN enrollments e 
	ON s.student_id = e.student_id
	JOIN courses c
	ON c.course_id = e.course_id
	WHERE course_name = '데이터베이스기초';
	
-- 3-1
-- UPDATE students SET phone = '010-1597-7533'
--  	WHERE student_id = 1;	
 	
-- 3-2
-- UPDATE courses SET professor = '김교수'
--  	WHERE course_id = 3;
 	
-- 3-3
-- UPDATE courses SET creadits = creadits + 1;
-- SELECT * FROM courses;

-- 4-1
-- DELETE FROM students WHERE full_name = '김이';
DELETE FROM enrollments
	WHERE student_id = 1;	

-- nrollments(수강 신청) 테이블에 'kim2' 학생의 학번을 참조하는 데이터가 남아 있기 때문입니다.

-- 4-2
DELETE FROM courses
WHERE course_id NOT IN (
    SELECT DISTINCT course_id 
    FROM enrollments
);

SELECT * FROM courses;