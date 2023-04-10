-- Q4)
-- Create newOrderDetails table from orderdetails. Every year, the company increases the price of each product by 1 or 2% (Example of 2% -- priceeach * 1.02) based on if the selling price (priceeach) is less than the average price of all order details table.
-- Write a stored procedure named update_low_prices_123456789 where 123456789 is replaced by your student number.
-- This procedure does not have any parameters. You need to find the average sell price (priceeach) of all products and store it into a variable of the same data type. If the average price is less than or equal to $1000, then update the products selling price(priceeach) by 2% if that products sell price is less than the calculated average.
-- If the average price is greater than $1000, then update products selling price (priceeach) by 1% if the price of the products selling price is less than the calculated average.
-- The query displays an error message if any error occurs. Otherwise, it displays the number of updated rows. An example of an output produced by your code might be the following or perhaps nicer
-- *** OUTPUT update_low_prices_123456789 STARTED ***
-- Number of updates: 27
--ENDED --------

CREATE OR REPLACE PROCEDURE update_low_prices_145282216 AS
    avg_price new_order_details.priceeach%type;
    rows_updated NUMBER;
BEGIN
    SELECT AVG(priceeach) 
    INTO avg_price
    FROM new_order_details;
    
    IF avg_price <= 1000
        THEN 
            UPDATE new_order_details
            SET priceeach = priceeach * 1.02
            WHERE priceeach < avg_price;
    ELSE 
        UPDATE new_order_details
        SET priceeach = priceeach * 1.01
        WHERE priceeach < avg_price;
    END IF;
    
    rows_updated := SQL%rowcount;
    
    IF rows_updated > 0
        THEN DBMS_OUTPUT.PUT_LINE('Number of Updates: ' || rows_updated);
    END IF;
    
EXCEPTION
    WHEN TOO_MANY_ROWS
        THEN DBMS_OUTPUT.PUT_LINE('Error in grouping');
    WHEN NO_DATA_FOUND
        THEN DBMS_OUTPUT.PUT_LINE('No Data Found!');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE('ERROR!');
END;

SET SERVEROUTPUT ON
BEGIN
    update_low_prices_145282216();
END;
