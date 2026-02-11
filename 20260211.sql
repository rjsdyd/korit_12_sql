SELECT * FROM users u CROSS JOIN orders o ORDER BY u.id;

-- 연습문제 1.
SELECT 
	u.id AS 회원아이디,
	u.username AS 이메일, 
	u.city AS 거주도시, 
	u.country AS 거주국가,
	s.first_name AS 성,
	s.last_name AS 이름
	FROM users u JOIN staff s ON u.id = s.user_id;
	
-- 연습문제 2.
SELECT 
	s.id AS 직원아이디,
	s.first_name AS 성,
	o.id AS 주문아이디,
	o.order_date AS 주문일자
	FROM 
    staff s
	JOIN 
    orders o ON s.id = o.staff_id
	WHERE 
    s.id IN (3, 5);
    
-- 연습문제 3.
SELECT 
    u.country AS 국가,
    COUNT(o.id) AS 주문건수
FROM 
    users u
JOIN 
    orders o ON u.id = o.user_id
GROUP BY 
    u.country
ORDER BY 
    주문건수 DESC;
    
-- 연습문제 4.
SELECT
	o.user_id AS 회원아이디,
	round(SUM(p.price * od.quantity)) AS 총정상가,
	round(SUM(p.discount_price * od.quantity)) AS 총할인가
	FROM orders o
	JOIN orderdetails od ON o.id = od.order_id
	JOIN products p ON od.product_id = p.id
	GROUP BY o.user_id
	ORDER BY 총정상가 DESC;
    
(SELECT * FROM users) UNION ALL (SELECT * FROM users);

-- 문제 : users에서 거주 국가가 한국인 회원 정보만 추출하고, 
-- MEXICO인 회원정보만 추출하여 _결합_ 하시오.
-- (단, 회원 아이디, 연락처, 거주도시, 거주국가만 출력하고, 거주국가 기준 알파벳 오름차순으로 작성하시오.)
SELECT
 id,
 phone,
 city,
 country
 FROM users
 WHERE country = 'Korea'
 UNION ALL
 SELECT  
 id,
 phone,
 city,
 country
 FROM users
 WHERE country = 'Mexico'
 ;

SELECT *
	FROM orders
	WHERE order_date >= '2015-10-01' AND order_date < '2015-11-01'
	UNION ALL
SELECT *
	FROM orders
	WHERE order_date >= '2015-12-01' AND order_date < '2016-01-01'
	ORDER BY order_date DESC;

SELECT 
	id AS 회원아이디,
	phone AS 전화번호,
	country AS 국가,
	city AS 도시,
	is_marketing_agree AS 마케티수신동의
	FROM users
	WHERE country = 'USA' AND is_marketing_agree = 1
	UNION all
SELECT 
	id,
	phone,
	country,
	city,
	is_marketing_agree
	FROM users
	WHERE country = 'France' AND is_marketing_agree = 0
	ORDER BY 국가 ASC;
	
SELECT * FROM orderdetails o
	LEFT JOIN products p
	ON o.product_id = p.id
	UNION
SELECT * FROM orderdetails o
	RIGHT JOIN products p 
	ON o.product_id = p.id;
	
SELECT 
	name, 
	price, 
	(SELECT ROUND(AVG(price), 2)
	FROM products) AS 평균가격 
	FROM products;
	
SELECT ROUND(AVG(price), 2) AS 평균가격 FROM products;

SELECT name, price, AVG(price) AS 평균가격 FROM products;

SELECT AVG(price) FROM products;

SELECT 
	city,
	COUNT(DISTINCT id) AS 회원수
	FROM users
	GROUP BY city
	HAVING COUNT(DISTINCT id) > 2
	ORDER BY 회원수 DESC;
	
-- 서브쿼리 사용 버전
SELECT * 
	FROM (SELECT city, COUNT(DISTINCT id) AS 도시별회원수
		FROM users
		GROUP BY city
	) a
	WHERE 도시별회원수 >= 3
	ORDER BY 도시별회원수 DESC;
	
SELECT * FROM orders WHERE staff_id IN (SELECT id FROM staff WHERE last_name IN('Kyle', 'Scott'));

SELECT * FROM staff;

SELECT * FROM products WHERE discount_price IN (SELECT MAX(discount_price) FROM products);

-- 문제 : ORDERS에서 주문 월이 2015년 7월인 주문 정보를, 주문 상세 정보 테이블 ORDERDETAILS에서 개별 주문
-- 수량이 50 이상인 정보를 각각 서브 쿼리로 작성하고, INNER JOIN하여 출력
SELECT 
    *
FROM 
    (SELECT * FROM orders
     WHERE order_date >= '2015-07-01' AND order_date <= '2015-07-31') o
INNER JOIN 
    (SELECT * FROM orderdetails 
     WHERE quantity >= 50) d
ON o.id = d.order_id;
-- -------------------------------------------------------------------------
-- -------------------------------------------------------------------------
SELECT *, ROUND(discount_price / (SELECT MAX(discount_price) FROM products), 3) AS ratioPerMaxPrc FROM products;

SELECT u.id, u.phone, u.country, s.id, s.last_name, s.first_name, s.birth_date
  FROM (
    SELECT * FROM users WHERE country IN ('Korea', 'Italy')
  ) u
  INNER JOIN
  (
    SELECT * FROM staff WHERE birth_date < '1990-01-01'
  ) s
  ON u.id = s.user_id;

SELECT * FROM ( SELECT country, COUNT(DISTINCT id) AS 국가별회원수 FROM users GROUP BY country ) u
WHERE 국가별회원수 > 4
ORDER BY 국가별회원수 DESC;

SELECT * FROM products WHERE price IN ( SELECT MIN(price) FROM products) ;

SELECT * FROM users WHERE id IN ( SELECT user_id FROM orders WHERE SUBSTR(order_date, 1, 4) = '2016' );

SELECT * FROM users WHERE id IN ( SELECT user_id FROM orders WHERE order_date BETWEEN '2016-01-01' AND '2016-12-31');