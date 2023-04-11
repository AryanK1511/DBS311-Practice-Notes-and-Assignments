-- Q14)
-- You have the PRODUCTS, ORDERS, ORDERDETAIL and CUSTOMERS tables already loaded. Provide a procedure that takes an order number and provides information about the order as shown below. Handle exceptions for this.

CREATE OR REPLACE PROCEDURE ORDERCUSTINFO (
    m_ordernumber IN orders.ordernumber%type
) AS
    m_orderdate orders.orderdate%type;
    m_customername customers.customername%type;
    m_customernumber customers.customernumber%type;
    m_city customers.city%type;
    m_phone customers.phone%type;
    m_creditlimit customers.creditlimit%type;
    m_status orders.status%type;
BEGIN
    SELECT customernumber, customername, city, phone, creditlimit, orderdate, status
    INTO m_customernumber, m_customername, m_city, m_phone, m_creditlimit, m_orderdate, m_status
    FROM customers INNER JOIN orders
    USING(customernumber)
    WHERE ordernumber = m_ordernumber;
    
    DBMS_OUTPUT.PUT_LINE('Order Date: ' || m_orderdate);
    DBMS_OUTPUT.PUT_LINE('Customer: ' || m_customername);
    DBMS_OUTPUT.PUT_LINE('Customer #: ' || m_customernumber);
    DBMS_OUTPUT.PUT_LINE('City: ' || m_city);
    DBMS_OUTPUT.PUT_LINE('Phone: ' || m_phone);
    DBMS_OUTPUT.PUT_LINE('Credit Limit: ' || m_creditlimit);
    DBMS_OUTPUT.PUT_LINE('Order Status: ' || m_status);
    
EXCEPTION
    WHEN NO_DATA_FOUND
        THEN DBMS_OUTPUT.PUT_LINE('No Data Found!');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE('ERROR!');
END;

EXECUTE ORDERCUSTINFO(10424088767);