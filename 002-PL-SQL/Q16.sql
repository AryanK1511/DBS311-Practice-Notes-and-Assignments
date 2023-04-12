-- Q16)
-- Write a stored procedure that processes the CUSTOMER table reporting on the number of customers in each country that exceed the number passed to the procedure.  For the example below, Australia with a count of 5 customers is not included in the output. Your procedure should include a COUNTRYIN CHAR(15) and a TOTALCUST NUMBER variable that is loaded with the appropriate country and country total for each line of output. Use %Rowcount to determine the number of rows returned.

CREATE OR REPLACE PROCEDURE CUSTCOUNTRY (cutoff IN INT) AS
    m_country customers.country%type;
    m_country_total INT := 0;
    CURSOR country IS
        SELECT country, COUNT(*) 
        FROM customers
        GROUP BY country
        HAVING COUNT(*) > cutoff
        ORDER BY country;
BEGIN
    OPEN country;
    DBMS_OUTPUT.PUT_LINE('Country    Total Customers');
    LOOP
        FETCH country INTO m_country, m_country_total;
        EXIT WHEN country%notfound;
        DBMS_OUTPUT.PUT_LINE(m_country || '         ' || m_country_total);
    END LOOP;
    CLOSE country;
END;

SET SERVEROUTPUT ON;
EXECUTE CUSTCOUNTRY(6);