-- Q5)
-- Create a tempPayment table from retailpayments. The company needs a report that shows three categories of payment based on their amount. The company needs to know if the payment amount is cheap, fair, or expensive. Let us assume that
-- - If the amount is less than the (average amount – minimum amount) divided by 2 The product’s payment is LOW.
-- - If the amount is greater than the maximum less the average divided by 2 The product’ payment is HIGH.
-- - If the amount is between
-- o (average amount – minimum amount) / 2 AND (maximum amount – average amount) / 2
-- INCLUSIVE
-- The product’s payment is fair.
-- Write a procedure named payment_report_123456789 where 123456789 is replaced by your student number. to show the number of payments in each payment category:
-- The following is a sample output of the procedure if no error occurs:
--    Low:  10
--    Fair: 50
--    High: 18
-- The values in the above examples are just random values and may not match the real numbers in your result.
-- The procedure has no parameter. First, you need to find the average, minimum, and maximum prices (amount) in your database and store them into variables avg_amt, min_amt, and max_amt.

-- Method 1 using cursors
CREATE OR REPLACE PROCEDURE payment_report_145282216 AS
    avg_amount temppayment.amount%type;
    min_amount temppayment.amount%type;
    max_amount temppayment.amount%type;
    m_amount temppayment.amount%type;
    low_count INT := 0;
    high_count INT := 0;
    fair_count INT := 0;
    
    CURSOR c1 IS
        SELECT amount FROM temppayment;
BEGIN
    SELECT AVG(amount), MIN(amount), MAX(amount)
    INTO avg_amount, min_amount, max_amount
    FROM temppayment;
    
    OPEN c1;
    LOOP
        FETCH c1 INTO m_amount;
        EXIT WHEN c1%notfound;
        IF m_amount < ((avg_amount - min_amount) / 2) 
            THEN low_count := low_count + 1;
        ELSIF m_amount > ((max_amount - avg_amount) / 2)
            THEN high_count := high_count + 1;
        ELSIF m_amount BETWEEN ((avg_amount - min_amount) / 2) AND ((max_amount - avg_amount) / 2)
            THEN fair_count := fair_count + 1;
        END IF;
    END LOOP;
    DBMS_OUTPUT.PUT_LINE('Low: ' || low_count);
    DBMS_OUTPUT.PUT_LINE('Fair: ' || fair_count);
    DBMS_OUTPUT.PUT_LINE('High: ' || high_count);
EXCEPTION
    WHEN NO_DATA_FOUND
        THEN
            DBMS_OUTPUT.PUT_LINE ('No Data Found!');
    WHEN OTHERS
        THEN
            DBMS_OUTPUT.PUT_LINE('ERROR!');
END;

-- Method 2 without using cursors
CREATE OR REPLACE PROCEDURE payment_report_145282216 AS
    avg_amt DECIMAL DEFAULT 0;
    min_amt DECIMAL DEFAULT 0;
    max_amt DECIMAL DEFAULT 0;
    low_count NUMBER DEFAULT 0;
    high_count NUMBER DEFAULT 0;
    fair_count NUMBER DEFAULT 0;
BEGIN
    SELECT AVG(amount), MIN(amount), MAX(amount) 
        INTO avg_amt, min_amt, max_amt 
        FROM retailpayments;
    SELECT COUNT(*)
        INTO low_count
        FROM tempPayment
        WHERE amount < ((avg_amt - min_amt) / 2);
    SELECT COUNT(*)
        INTO high_count
        FROM tempPayment
        WHERE amount > ((max_amt - avg_amt) / 2);
    SELECT COUNT(*)
        INTO fair_count
        FROM tempPayment
        WHERE amount BETWEEN ((avg_amt - min_amt) / 2) AND ((max_amt - avg_amt) / 2);
        
    DBMS_OUTPUT.PUT_LINE('Low: ' || low_count);
    DBMS_OUTPUT.PUT_LINE('Fair: ' || fair_count);
    DBMS_OUTPUT.PUT_LINE('High: ' || high_count);
    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN
                DBMS_OUTPUT.PUT_LINE ('No Data Found!');
        WHEN OTHERS
            THEN
                DBMS_OUTPUT.PUT_LINE('ERROR!');
END;

SET SERVEROUTPUT ON;
BEGIN
    payment_report_145282216();
END;