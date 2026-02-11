SELECT * FROM users ORDER BY id ASC;		-- 오름 차순
SELECT * FROM users ORDER BY id DESC;		-- 내림 차순

SELECT * FROM users ORDER BY city ASC;
SELECT * FROM users ORDER BY created_at DESC;

SELECT * FROM users ORDER BY 1 DESC;

SELECT username, phone, city, country, id FROM users ORDER BY 1 ASC;	
SELECT username, phone, city, country, id FROM users ORDER BY id ASC;

SELECT city, id FROM users ORDER BY city DESC, id ASC;

-- 1번. products 테이블에서 정상 가격이 비싼 제품부터 순서대로 모든 컬럼 출력
SELECT * FROM products ORDER BY price DESC;

-- 2번. orders에서 주문 일자 기준 최신순으로 정렬하여 모든 컬럼 출력
SELECT * FROM orders ORDER BY order_date DESC;

-- 3번. orderdetails 테이블에서 제품 아이디를 기준으로 내림차순 정렬하고 같은 제품 아이디 기준으로
--   	  판매 수량을 기준으로 오름 차순 정렬하여 모든 컬럼을 출력
SELECT * FROM orderdetails ORDER BY product_id DESC, quantity ASC;

SELECT COUNT(id) AS cnt FROM orderdetails;

SELECT COUNT(country) FROM users;

SELECT COUNT(DISTINCT country) AS countries FROM users;

SELECT DISTINCT country AS countries FROM users;

-- 1. 제품 정보 테이블에서 최저가를 추출하시오 (정상가 기준)
SELECT MIN(price) FROM products;

-- 2. 제품 정보 테이블에서 최대가를 추출하시오 (할인가 기준)
SELECT MAX(discount_price) FROM products;

-- 3. 제품 정보 테이블에서 정상가격의 합계를 추출하시오
SELECT ROUND(SUM(price),2) FROM products;

-- 4. 제품 정보 테이블에서 정상 가격의 평균을 추출하시오 
--    (단, 결과값의 컬럼영을 avgPrice로 변경하고 소수점 둘째 자리까지만 추출)
SELECT ROUND(AVG(price),2) AS avgPrice FROM products;

SELECT SUBSTR(created_at, 1, 10) FROM users;

SELECT SUBSTR(created_at, 1, 10) AS day, SUBSTR(created_at, 1, 7) AS MONTH, created_at FROM users;

SELECT LENGTH(username), username FROM users;

-- 1. products에서 정상 가격을 모두 더한 값을 추출
SELECT ROUND(SUM(price),2) AS '합계' FROM products;

-- 2. products에서 제품 아이디가 30이하인 제품의 정상 가격의 평균 추출(소수점 둘째)
SELECT ROUND(AVG(price), 2) AS '평균' FROM products WHERE id <= 30;

-- 3. users에서 가입일시가 2010-10부터 2010-12까지인 회원 아이디를 중복 없이 센 값을 출력
SELECT COUNT(DISTINCT id) AS '유저수' FROM users WHERE SUBSTR(created_at, 1, 7) BETWEEN '2010-10' AND '2010-12';

-- 4. users에서 이메일의 길이가 17자리 이하인 회원 수를 중복없이 센 값을 출력.
SELECT COUNT(DISTINCT id) AS '유저수' FROM users WHERE LENGTH(username) <= 17;

-- 1. country가 Korea인 애 카운트
-- 2. country가 USA인 애 카운트
SELECT COUNT(id) FROM users WHERE country = 'Korea';
SELECT COUNT(id) FROM users WHERE country = 'USA';
SELECT COUNT(id) FROM users WHERE country IN ('Korea', 'USA');

SELECT country, COUNT(DISTINCT id) AS 국가별유저수 FROM users GROUP BY country;

SELECT COUNT(DISTINCT country) FROM users;

-- 문제 1 : 거주 국가가 한국인 회원중 마케팅 수신에 동의한 회원 수를 추출
SELECT COUNT(country)  FROM users WHERE country = 'Korea' AND is_marketing_agree = 1;
  
-- 문제 2 : 영국인 회원 중 마케팅 수신에 동의한 회원 수를 추출
SELECT COUNT(country) FROM users WHERE country = 'UK' AND is_marketing_agree = 1;

-- 문제 3 : 국가별로 마케팅 수신 동의를 한 회원 수를 국가별 오름차순, 회원수 별 내림차순으로 추출
SELECT 
    country, 
    SUM(is_marketing_agree = 1) AS 동의사용자,
	 SUM(is_marketing_agree = 0) AS 비동의사용자
FROM users 
GROUP BY country 
ORDER BY country ASC, 동의사용자 DESC, 비동의사용자 DESC;

SELECT country, is_marketing_agree AS 동의여부, COUNT(DISTINCT id) AS 동의사용자FROM users GROUP BY country, is_marketing_agree ORDER BY country, 동의사용자 DESC;