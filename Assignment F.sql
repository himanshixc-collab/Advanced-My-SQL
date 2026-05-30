CREATE DATABASE assgnF;
USE assgnF;

#function to calculate square of a number

CREATE FUNCTION sq_num (n INT)
RETURNS INT
DETERMINISTIC
RETURN n*n;

SELECT sq_num(7);

#function to check even or odd

CREATE FUNCTION odd_even (n INT)
RETURNS VARCHAR(10)
DETERMINISTIC
RETURN IF(n%2 = 0, 'Even', 'Odd');

SELECT odd_even(9);

#function to calculate simple interest

CREATE FUNCTION interest(p DECIMAL(10,2), r DECIMAL(5,2), t INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN (p*r*t/100);

SELECT interest(5000, 5, 3);

#function to get full name

CREATE FUNCTION full_name(first_name VARCHAR(50), last_name VARCHAR(50))
RETURNS VARCHAR(100)
DETERMINISTIC
RETURN CONCAT(first_name, ' ', last_name);

SELECT full_name('Priya', 'Sharma');

#function to find minimum of two numbers

CREATE FUNCTION find_min(a INT, b INT)
RETURNS INT
DETERMINISTIC
RETURN IF(a < b, a, b);

SELECT find_min(45, 82);

#function to count vowels in a string

CREATE FUNCTION count_vowels(str VARCHAR(255))
RETURNS INT
DETERMINISTIC
RETURN CHAR_LENGTH(str) - CHAR_LENGTH(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(LOWER(str),'a',''),'e',''),'i',''),'o',''),'u',''));

SELECT count_vowels('Artificial Intelligence');

#function to convert kilometers to miles

CREATE FUNCTION km_to_miles(km DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN km * 0.621371;

SELECT km_to_miles(10);

#function to convert celsius to fahrenheit

CREATE FUNCTION cel_to_fahr(c DECIMAL(5,2))
RETURNS DECIMAL(5,2)
DETERMINISTIC
RETURN (c * 9/5) + 32;

SELECT cel_to_fahr(100);

#function to find maximum of two numbers

CREATE FUNCTION find_max(a INT, b INT)
RETURNS INT
DETERMINISTIC
RETURN IF(a > b, a, b);

SELECT find_max(45, 82);

#function to calculate area of a circle

CREATE FUNCTION circle_area(r DECIMAL(10,2))
RETURNS DECIMAL(10,2)
DETERMINISTIC
RETURN 3.14159 * r * r;

SELECT circle_area(7);