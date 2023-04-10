-- Q2) 
-- Create a stored procedure named find_Order. This procedure gets an order number and prints the following retail order information:
-- Order Number
-- Order Date
-- Status CustomerNumber
-- The procedure gets a value as the order number of type NUMBER. See the following sample output for order number 10422:
-- Order Number :10422 Order Date : 31-MAY-05 Status :In Progress CustomerNumber :103
-- The procedure displays a proper error message if any error occurs like ordernumber doesn’t exist or invalid.

SET SERVEROUTPUT ON;

CREATE OR REPLACE PROCEDURE find_order (
    m_ordernumber IN retailorders.ordernumber%type
) AS
    m_orderdate retailorders.orderdate%type;
    m_status retailorders.status%type;
    m_customernumber retailorders.customernumber%type;
BEGIN
    SELECT orderdate, status, customernumber
    INTO m_orderdate, m_status, m_customernumber
    FROM retailorders
    WHERE ordernumber = m_ordernumber;
    
    DBMS_OUTPUT.PUT_LINE('Order Number: ' || m_ordernumber);
    DBMS_OUTPUT.PUT_LINE('Order Date: ' || m_orderdate);
    DBMS_OUTPUT.PUT_LINE('Status: ' || m_status);
    DBMS_OUTPUT.PUT_LINE('Customer Number: ' || m_customernumber);

EXCEPTION
    WHEN NO_DATA_FOUND
        THEN DBMS_OUTPUT.PUT_LINE('No data found.');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE('Some error occured');
END;

BEGIN
    find_order(10422);
END;