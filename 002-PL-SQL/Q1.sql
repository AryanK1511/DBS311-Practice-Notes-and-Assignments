-- Q1)
-- Write a stored procedure that gets an integer number and prints
-- The number is divisible by 100.
-- If a number is divisible by 100.
-- Otherwise, it prints
-- The number is not divisible by 100.

create or replace PROCEDURE divisibleBy100 (
    n IN INT
) AS 
BEGIN
    IF mod(n, 100) = 0
        THEN DBMS_OUTPUT.PUT_LINE('The number is divisible by 100.');
    ELSE DBMS_OUTPUT.PUT_LINE('The number is not divisible by 100.');
    END IF;
END divisibleBy100;

SET SERVEROUTPUT ON;

BEGIN
    divisibleBy100(200);
END;