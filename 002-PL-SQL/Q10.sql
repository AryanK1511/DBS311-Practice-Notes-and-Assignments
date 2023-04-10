-- Q10)
-- Create a new table OrderdetailsTmp from orderdetails. Add a new column called new_price. Write a PL/SQL stored procedure named orders_newprice. Using CURSORS update the new column in the orderdetailstmp table called new_price (it is the updated price). Fill the new_price column by the following calculation.
-- If price of each item is below $50 then add $30, if price of each item is between 50 to 100 then add $50, if it is between 200 to 500 then add $150 else add $200. Remember to display the price of each item, new_price and ordernumber before the update happens. Use cursors and case statement.

CREATE OR REPLACE PROCEDURE orders_newprice AS
    ordernumber orderdetailstmp.ordernumber%type;
    old_price orderdetailstmp.priceeach%type;
    new_price orderdetailstmp.priceeach%type;
    CURSOR orderdetail IS
        SELECT ordernumber, priceeach
        FROM orderdetailstmp;
BEGIN
    OPEN orderdetail;
    LOOP
        FETCH orderdetail INTO ordernumber, old_price;
        EXIT WHEN orderdetail%notfound;
        CASE
            WHEN old_price < 50 THEN new_price := old_price + 30;
            WHEN old_price BETWEEN 50 AND 100 THEN new_price := old_price + 50;
            WHEN old_price BETWEEN 200 AND 500 THEN new_price := old_price + 150;
            ELSE new_price := old_price + 200;
        END CASE;
        DBMS_OUTPUT.PUT_LINE('ORDERNUMBER: ' || ordernumber);
        DBMS_OUTPUT.PUT_LINE('OLD PRICE: ' || old_price);
        DBMS_OUTPUT.PUT_LINE('NEW PRICE: ' || new_price);
        DBMS_OUTPUT.PUT_LINE(' ');
    END LOOP;
EXCEPTION
    WHEN NO_DATA_FOUND
        THEN DBMS_OUTPUT.PUT_LINE('No Data was found!');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE('Some Error Occured!');
END;

SET SERVEROUTPUT ON;
BEGIN
    orders_newprice();
END;