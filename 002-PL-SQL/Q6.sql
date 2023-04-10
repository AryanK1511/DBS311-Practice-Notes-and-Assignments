-- Q6)
-- The company wants to calculate what the new buy price of each retail product would be:
-- Write a stored procedure named calculate_newbuyprice which calculates the new buying price by multiplying the percentage increase for each othe productline given in the table. (Use CASE statements for each productline and FOR loop construct for each retail product).
-- The procedure calculates and prints the product name, old buy price and new price.
-- Sample output:
-- Exception block should handle all error that might occur with custom messages for “If the buy price is 0” product does not exist, the procedure displays a proper message.

CREATE OR REPLACE PROCEDURE calculate_newbuyprice AS
    percent_inc NUMBER(10, 2);
    m_name retailproducts.productname%type;
    m_pl retailproducts.productline%type;
    old_bp retailproducts.buyprice%type;
    new_bp retailproducts.buyprice%type;
    CURSOR rp_cursor IS
        SELECT productname, productline, buyprice
        FROM retailproducts;
BEGIN
    OPEN rp_cursor;
    LOOP
        FETCH rp_cursor INTO m_name, m_pl, old_bp;
        EXIT WHEN rp_cursor%notfound;
        IF old_bp > 0
            THEN CASE
                WHEN LOWER(m_pl) = 'trucks and buses' THEN percent_inc := 1.1;
                WHEN LOWER(m_pl) = 'vintage cars' THEN percent_inc := 1.5;
                WHEN LOWER(m_pl) = 'classic cars' THEN percent_inc := 1.2;
                WHEN LOWER(m_pl) = 'ships' THEN percent_inc := 1.3;
                WHEN LOWER(m_pl) = 'motorcycles' THEN percent_inc := 1.2;
                WHEN LOWER(m_pl) = 'trains' THEN percent_inc := 1.6;
                WHEN LOWER(m_pl) = 'planes' THEN percent_inc := 1.7;
                ELSE DBMS_OUTPUT.PUT_LINE('Product Line does not Exist');
            END CASE;
            new_bp := old_bp + (percent_inc * (old_bp / 100));
            DBMS_OUTPUT.PUT_LINE('PRODUCT NAME: ' || m_name);
            DBMS_OUTPUT.PUT_LINE('OLD BUY PRICE: ' || old_bp);
            DBMS_OUTPUT.PUT_LINE('NEW BUY PRICE: ' || new_bp);
            DBMS_OUTPUT.PUT_LINE(' ');
        ELSE
            DBMS_OUTPUT.PUT_LINE('No Buy Price');
        END IF;
    END LOOP;
    CLOSE rp_cursor;
EXCEPTION
    WHEN NO_DATA_FOUND
        THEN DBMS_OUTPUT.PUT_LINE('Data not found!');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE('Some error occured!');
END;

SET SERVEROUTPUT ON;
BEGIN
    calculate_newbuyprice();
END;