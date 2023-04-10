-- Q9)
-- Write a PL/SQL stored procedure named order_status to provide a list of retail ORDERS with order id and status using WHILE loop structure.

CREATE OR REPLACE PROCEDURE order_status AS
    rws INT := 0;
    orderid retailorders.ordernumber%type;
    orderstatus retailorders.status%type;
    CURSOR ret_order IS
        SELECT ordernumber, status
        FROM retailorders;
BEGIN
    SELECT COUNT(*)
    INTO rws
    FROM retailorders;
    
    OPEN ret_order;
    WHILE rws > 0 LOOP
        FETCH ret_order INTO orderid, orderstatus;
        rws := rws - 1;
        DBMS_OUTPUT.PUT_LINE('ORDER NUMBER: ' || orderid);
        DBMS_OUTPUT.PUT_LINE('ORDER STATUS: ' || orderstatus);
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
    CLOSE ret_order;
EXCEPTION
    WHEN INVALID_CURSOR
        THEN DBMS_OUTPUT.PUT_LINE('Invalid Cursor');
    WHEN NO_DATA_FOUND
        THEN DBMS_OUTPUT.PUT_LINE('Data not found!');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE('Some error occured!');
END;

SET SERVEROUTPUT ON;
BEGIN
    order_status();
END;