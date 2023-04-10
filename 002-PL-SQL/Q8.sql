-- Q8)
-- Write a stored procedure named CUSTOMER_credithistory to provide a list of retail customers name, credit limit
-- and credit level using CURSORS.
-- If credit _limit is below $1000 display as “new customers” in credit level, if between 1000 to 5000 then display as” existing customers”. If above $4000 - $10,000 display as “credit approved for new increase” and others as “Waiting for Approval”

CREATE OR REPLACE PROCEDURE CUSTOMER_credithistory AS
    m_customername retailcustomers.customername%type;
    m_creditlimit retailcustomers.creditlimit%type;
    m_creditlevel VARCHAR(20);
    CURSOR customer IS
        SELECT customername, creditlimit
        FROM retailcustomers;
BEGIN
    OPEN customer;
    LOOP
        FETCH customer INTO m_customername, m_creditlimit;
        EXIT WHEN customer%notfound;
        CASE
            WHEN m_creditlimit < 1000 THEN m_creditlevel := 'new customers';
            WHEN m_creditlimit BETWEEN 1000 AND 5000 THEN m_creditlevel := 'existing customers';
            WHEN m_creditlimit > 4000 AND m_creditlimit <= 10000 THEN m_creditlevel := 'credit approved for new increase';
            ELSE m_creditlevel := 'Waiting for approval';
        END CASE;
        DBMS_OUTPUT.PUT_LINE('CUSTOMER NAME: ' || m_customername);
        DBMS_OUTPUT.PUT_LINE('CREDIT LIMIT: ' || m_creditlimit);
        DBMS_OUTPUT.PUT_LINE('CREDIT LEVEL: ' || m_creditlevel);
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
EXCEPTION
    WHEN INVALID_CURSOR
        THEN DBMS_OUTPUT.PUT_LINE('Invalid Cursor');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE('Error!');
END;

SET SERVEROUTPUT ON;
BEGIN
    CUSTOMER_credithistory();
END;