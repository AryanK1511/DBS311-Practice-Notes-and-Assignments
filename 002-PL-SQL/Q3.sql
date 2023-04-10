-- Q3)
-- Create a newProduct table from retailproducts with all the data. Every year, the retail company increases the price of all retail products in one product line. For example, the company wants to increase the buying price of retail products of product line ‘Train’ by $500.
-- Write a procedure named update_price_productline to update the buying price of all products in the given product line and the given amount to be added to the current buying price if the price is greater than 30.
-- The procedure shows the number of updated rows if the update is successful. The procedure gets two parameters:
-- • Prod_type IN VARCHAR2 • amount NUMBER(9,2)
-- To define the type of variables that store values of a table column, you can also write:
-- variable_name table_name.column_name%type;
-- The above statement defines a variable of the same type as the type of the table column.
-- Example: productline newProduct.productline%type;
-- Or you need to see the table definition to find the type of the buying price update column. Make sure the type of your variable is compatible with the value that is stored in your variable.
-- To show the number of affected rows the update query, declare a variable named rows_updated of type NUMBER and use the SQL variable sql%rowcount to set your variable. Then, print its value in your stored procedure. (Something like this is in the notes supplied to you)
-- Rows_updated := sql%rowcount;
-- SQL%ROWCOUNT stores the number of rows affected by an INSERT, UPDATE, or DELETE.

CREATE OR REPLACE PROCEDURE update_price_productline (
    prod_type IN VARCHAR2,
    amount NUMBER
) AS
    rows_updated NUMBER;
BEGIN
    UPDATE newproduct
    SET buyprice = buyprice + amount
    WHERE buyprice > 30 AND LOWER(productline) = LOWER(prod_type);
    
    rows_updated := SQL%rowcount;
    
     IF rows_updated > 0
        THEN
            DBMS_OUTPUT.PUT_LINE(rows_updated || ' rows updated.');
    END IF;
    
    EXCEPTION
        WHEN NO_DATA_FOUND
            THEN
                 DBMS_OUTPUT.PUT_LINE('No Data Found!');
        WHEN OTHERS
            THEN
                DBMS_OUTPUT.PUT_LINE('ERROR!');
END;

SET SERVEROUTPUT ON;
BEGIN
    update_price_productline('vintage cars', 200);
END;