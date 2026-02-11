SELECT * FROM users GROUP BY country;

SELECT country, COUNT(DISTINCT id) AS 국가별사용자수 
	FROM users WHERE country IN ('Korea', 'Spain') GROUP BY country;

SELECT count(DISTINCT id) AS 한국동의자수 
	FROM users WHERE country = 'korea' AND is_marketing_agree = 1;
	
SELECT count(DISTINCT id) AS 한국동의자수 
	FROM users WHERE country IN ('korea', 'USA') 
    AND is_marketing_agree = 1;
    
SELECT country AS 국가, is_marketing_agree AS 마케팅수신동의, COUNT(DISTINCT id) AS 회원수 
    FROM users 
	  GROUP BY country, 마케팅수신동의
    ORDER BY country, 회원수 DESC;

SELECT country AS 국가, city AS 도시, COUNT(DISTINCT id) AS 회원수
	FROM users
	GROUP BY country, city
	ORDER BY country, id DESC, city;
	
SELECT SUBSTR(created_at, 1, 7) AS 월별, COUNT(DISTINCT id) AS 회원수
	FROM users
	GROUP BY SUBSTR(created_at, 1, 7)
	ORDER BY created_at DESC;

SELECT order_id AS 주문아이디, SUM(quantity) AS 주문수량
	FROM orderdetails
	GROUP BY order_id
	ORDER BY quantity DESC;
	
SELECT staff_id AS 직원아이디, user_id AS 회원아이디, COUNT(DISTINCT order_date) AS 주문건수
	FROM orders
	GROUP BY staff_id, user_id
	ORDER BY staff_id ASC, 주문건수 DESC;
	
SELECT SUBSTR(order_date, 1, 7)AS 월별  , COUNT(DISTINCT user_id) AS 월별주문회원수
	FROM orders
	GROUP BY SUBSTR(order_date, 1, 7)
	ORDER BY order_date DESC;
	
SELECT country, COUNT(DISTINCT id) AS 국가별회원수 
	FROM users
	WHERE country IN ('Korea','USA','France')
	GROUP BY country;
	
SELECT country, COUNT(DISTINCT id) AS 국가별회원수 
	FROM users
	GROUP BY country
  HAVING COUNT(DISTINCT id) > 7
  ORDER BY id DESC;

SELECT staff_id AS 직원아이디 ,COUNT(DISTINCT id) AS 주문건수, count(distinct user_id) AS 주문회원수
	FROM orders
	GROUP by 직원아이디
	HAVING 주문건수 >= 10 AND 주문회원수 <= 40
	ORDER BY 주문건수 DESC;

SELECT user_id AS 회원별주문건수, COUNT(DISTINCT id) AS 주문건수
	FROM orders
	GROUP BY 회원별주문건수
	HAVING 주문건수 >= 7
	ORDER BY 주문건수 DESC;
	
SELECT country AS 국가, COUNT(DISTINCT city) AS 도시, COUNT(DISTINCT id) AS 회원
	FROM users
	GROUP BY 국가
	HAVING 도시 >= 5 AND 회원 >= 3
	ORDER BY 도시 DESC, 회원 DESC;
	
SELECT country AS 국가, COUNT(DISTINCT id) AS 회원
	FROM users
	GROUP BY 국가
	HAVING 국가 IN ('USA', 'Brazil', 'Korea', 'Argentina', 'Mexico') AND 회원 >= 5
	ORDER BY 회원 DESC;
	
SELECT *
	FROM users u INNER JOIN orders o ON u.id = o.user_id;

SELECT *
	FROM users u LEFT JOIN orders o ON u.id = o.user_id;	
	
SELECT *
	FROM users u INNER JOIN orders o ON u.id = o.user_id ORDER BY o.id;	
	
SELECT 
	u.id AS 유저아이디, 
	u.username, 
	u.created_at, 
	u.phone, 
	u.is_marketing_agree, 
	u.country, 
	u.city, 
	o.id AS 주문아이디, 
	o.staff_id, 
	o.order_date
	FROM users u INNER JOIN orders o ON u.id = o.user_id;
	
SELECT *
	FROM users u LEFT JOIN orders o
	ON u.id = o.user_id;
	
SELECT *
	FROM users u LEFT JOIN orders o
	ON u.id = o.user_id
	WHERE o.id IS NULL;
	
SELECT 
	u.id AS 회원아이디,
	u.username AS 이메일,
	u.phone AS 연락처,
	o.id AS 주문아이디,
	od.product_id AS 제품아이디
FROM users u LEFT JOIN orders o
ON u.id = o.user_id
INNER JOIN orderdetails od
ON o.id = od.order_id;

SELECT *
	FROM users u right JOIN ORDERS O
	ON u.id = o.user_id
	ORDER BY o.id;
	