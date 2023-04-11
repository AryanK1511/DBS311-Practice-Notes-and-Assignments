-- Q13)
-- Write a stored procedure that get an integer number and prints information on whether the number is even or odd. (look at it being divisible by 2) 
CREATE OR REPLACE PROCEDURE ODD_EVEN(NLO IN NUMBER) AS
BEGIN
    IF MOD(NLO,2) = 0
        THEN DBMS_OUTPUT.PUT_LINE(NLO || ' IS EVEN');
    ELSE
        DBMS_OUTPUT.PUT_LINE(NLO || ' IS ODD');
    END IF;
END;

SET SERVEROUTPUT ON;
BEGIN
    ODD_EVEN(100);
END;