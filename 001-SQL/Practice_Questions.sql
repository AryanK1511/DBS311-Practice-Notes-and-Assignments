-- Q1) Write a SQL statement using multi-row functions to display the total number of customers and total credit limit given to all RETAILCUSTOMERS.
SELECT COUNT(customernumber) AS "Total Customers", SUM(creditlimit) AS "Total Credit Limit"
FROM retailcustomers;

-- Q2) Write a SQL statement using multi-row functions to display the minimum credit limit, maximum credit limit and average credit limit for all RETAILCUSTOMERS 
SELECT MIN(creditlimit) AS "Minimum Credit Limit", MAX(creditlimit) AS "Maximum Credit Limit", ROUND(AVG(creditlimit), 2) AS "Average Credit Limit"
FROM retailcustomers;

-- Q3) Write a SQL statement using multi-row functions to display the total distinct order dates and total distinct status in RETAILORDERS table
SELECT COUNT(DISTINCT orderdate) AS "DISTINCT ORDER DATES", COUNT(DISTINCT status) AS "DISTINCT STATUS"
FROM retailorders;

-- Q4) Write a SQL statement using multi-row functions to display the customer number and customer name who recently ordered from RETAILORDERS table
SELECT customernumber, customername
FROM retailorders
INNER JOIN retailcustomers
USING(customernumber)
WHERE orderdate = (
    SELECT MAX(orderdate) 
    FROM retailorders
);

-- Q5) Write a SQL statement using multi-row functions to display RETAILEMPLOYEES who go first in line by firstname and last in line by firstname
SELECT MIN(firstname) AS "First in Line", MAX(firstname) AS "Last in Line"
FROM retailemployees;

-- Q6) Write a SQL statement using multi-row functions to display the distinct lastnames in RETAILEMPLOYEES that end with letter ‘G’ and also display the count of distinct lastnames that end with letter ‘G’  in the same query using “Over () function”
SELECT DISTINCT lastname, COUNT(DISTINCT lastname) OVER() AS "Lastname Count"
FROM retailemployees
WHERE LOWER(lastname) LIKE '%g';

-- Q7) Write a SQL statement using group functions to display the salesrep id and the count of salesrepid in RETAILCUSTOMERS table
SELECT salesrepemployeenumber, COUNT(salesrepemployeenumber) AS "COUNT"
FROM retailcustomers
WHERE salesrepemployeenumber IS NOT NULL
GROUP BY salesrepemployeenumber;

-- Q8) Write a SQL statement using group functions to display the sum and average of the price of each item in ORDERDETAILS when they are grouped by ordernumber.
SELECT ROUND(SUM(priceeach), 2) AS sum, ROUND(AVG(priceeach), 2) as average
FROM orderdetails
GROUP BY ordernumber
ORDER BY ordernumber;

-- Q9) Write a SQL statement to display RETAILEMPLOYEES’s first name, last name and employees office city and country grouped by their office code and also display how many employees work in each office. 
SELECT firstname, lastname, city, country, COUNT(officecode) OVER(PARTITION BY officecode) AS "Number of Employees in Office"
FROM retailemployees
INNER JOIN retailoffices
USING(officecode)
GROUP BY officecode, firstname, lastname, city, country;

-- Q10) Write a SQL statement using group functions to display customer name and customer number who have same credit limit and limit the display by showing RETAILCUSTOMERS who have credit limit above 4000. Display the above query sorted by customer name in ascending order.
SELECT customername, customernumber, creditlimit
FROM retailcustomers
GROUP BY creditlimit, customername, customernumber, creditlimit
HAVING creditlimit > 4000
ORDER BY creditlimit;

-- Q11) Write a SQL query using subqueries to find all retail customers that have customer number greater than 'Mini Wheels Co.' and whose credit limit are greater than customer number 121 (Hint 2 subqueries are needed and display customer number, credit limit, customer name in the main query)
SELECT customernumber, customername, creditlimit
FROM retailcustomers
WHERE creditlimit > (
    SELECT creditlimit 
    FROM retailcustomers
    WHERE LOWER(customername) = 'mini wheels co.'
)
AND creditlimit > (
    SELECT creditlimit
    FROM retailcustomers
    WHERE customernumber = 121
);

-- Q12) Write a SQL query using subqueries to find all retailemployees that have employeenumber greater than 'Andy Fixter' and whose office code are less than “Barry Jones” (Hint 2 subqueries are needed and display employee number, employee name, office code in the main query)
SELECT employeenumber, firstname || ' ' || lastname AS employeename, officecode
FROM retailemployees
WHERE employeenumber > (
    SELECT employeenumber 
    FROM retailemployees 
    WHERE LOWER(firstname) = 'andy' AND LOWER(lastname) = 'fixter'
)
AND officecode < (
    SELECT officecode
    FROM retailemployees 
    WHERE LOWER(firstname) = 'barry' AND LOWER(lastname) = 'jones'
);

-- Q13) Write a SQL query using subqueries to find all retail customers who have the same credit limit as the maximum credit limit of all retail customers(Hint 1 subquery and group function are needed and display contact full name, customer number and creditlimit in the main query)
SELECT contactfirstname || ' ' || contactlastname AS contactfullname, customernumber, creditlimit
FROM retailcustomers
WHERE creditlimit = (
    SELECT MAX(creditlimit)
    FROM retailcustomers
);

-- Q14) Write a SQL query using subqueries to find all retail orders who have the order date above the minimum order date and who have ordered before order number 10107(Hint 2 subquery and group function are needed and display order number, customer number and order date in the main query)
SELECT ordernumber, customernumber, orderdate
FROM retailorders
WHERE orderdate > (
    SELECT MIN(orderdate)
    FROM retailorders
)
AND orderdate < (
    SELECT orderdate 
    FROM retailorders
    WHERE ordernumber = 10107
);

-- Q15) Write a SQL query using subqueries to display all orders with minimum order date grouped by the customer number and less than customer number 458’s order date (Hint you will have group by clause, group function and 1 subquery to display the customer number and the minimum of order date in retail orders table)
SELECT customernumber, MIN(orderdate) AS "Minimum order date"
FROM retailorders
WHERE orderdate < ALL (
    SELECT orderdate
    FROM retailorders
    WHERE customernumber = 458
)
GROUP BY customernumber
ORDER BY customernumber;

-- Q16) Write a SQL query using subqueries to find the order details whose price of each item are above the average of the lowest price item (Hint use over() function in main query, you will have group by clause, group function in 1 subquery to display the quantity, price, item count of the order number in orders details table)
SELECT quantityordered, priceeach, COUNT(ordernumber) OVER(PARTITION BY ordernumber) AS itemcount
FROM orderdetails
WHERE priceeach > (
    SELECT ROUND(AVG(MIN(priceeach)), 2)
    FROM orderdetails
    GROUP BY ordernumber
)
GROUP BY ordernumber, quantityordered, priceeach;

-- Q17) Display the retail customer's country name of those retail orders who have the newest order date (Hint: group functions and subqueries will be needed)
SELECT country
FROM retailcustomers
INNER JOIN retailorders
USING(customernumber)
WHERE orderdate = (
    SELECT MAX(orderdate) 
    FROM retailorders
);

-- Q18) Display the retail customer name, full name of their contacts along with the credit limit for those who have the minimum credit limit. (Hint: group functions and subqueries will be needed)
SELECT customername, contactfirstname || ' ' || contactlastname AS contactfullname, creditlimit
FROM retailcustomers
WHERE creditlimit = (
    SELECT MIN(creditlimit) 
    FROM retailcustomers
);

-- Q19) Using set operators, display only the orderdetails that are not in retailproduct catalogue with the following information of product code, product vendor, product description, quantity ordered( use predefined values null and zero for any information that are not in the table)
SELECT productcode, NULL as productvendor, NULL as productdescription, quantityordered
FROM orderdetails
MINUS
SELECT NULL as productcode, productvendor, productdescription, NULL as quantityordered
FROM retailproducts;

-- Q20) List the Manager's full name and Manager's employeenumber and their job title. Show only those who manage more than 2. (Using retailemployees table, group by clause and subqueries)
SELECT employeenumber, firstname || ' ' || lastname AS fullname, jobtitle
FROM retailemployees
WHERE employeenumber IN (
    SELECT reportsto
    FROM retailemployees 
    GROUP BY reportsto
    HAVING COUNT(reportsto) > 2
);

-- Q21) Display the customer names and their previous order dates and next order date within a 30 day cycle who have their orders  in 'in process' status and display their name in descending order (Hint: date functions and joins will be needed)
SELECT c.customername, TO_CHAR(o.orderdate - 30, 'fmMM/DD/YY') AS "Previous Order Date", TO_CHAR(o.orderdate + 30, 'fmMM/DD/YY') AS "Next Order Date"
FROM retailcustomers c
INNER JOIN retailorders o
USING(customernumber)
WHERE LOWER(status) = 'in process'
ORDER BY customername DESC;

-- Q22) Display the Retail Employee's full name and their email address for whose work in the 'UK' office or who have been a sales rep for retail customers who live in 'UK' (Hint: subqueries and single row functions will be needed)
SELECT firstname || ' ' || lastname AS fullname, email
FROM retailemployees
INNER JOIN retailoffices
USING(officecode)
WHERE LOWER(country) = 'uk'
OR employeenumber IN (
    SELECT salesrepemployeenumber 
    FROM retailcustomers 
    WHERE LOWER(country) = 'uk'
);

-- Q23) Display the ordernumber, productcode, quantity ordered and price of each of the orders whose order status is 'Shipped' and product line is 'TRAINS' (Hint: using retailorders, retailproduct, subqueries will be needed)
SELECT ordernumber, productcode, quantityordered, priceeach
FROM orderdetails
WHERE ordernumber IN (
    SELECT ordernumber 
    FROM retailorders
    WHERE LOWER(status) = 'shipped'
)
AND productcode IN (
    SELECT productcode 
    FROM retailproducts
    WHERE LOWER(productline) = 'trains'
);

-- Q24) Display each retail customer's number and their total number of retail orders who ordered in the year '2003' and '2004' (Hint: date related functions, group functions and group by clause will be needed)
SELECT customernumber, COUNT(*) AS "Total Number of Retail Orders"
FROM retailcustomers
INNER JOIN retailorders
USING(customernumber)
WHERE EXTRACT(YEAR FROM orderdate) = 2003 OR EXTRACT(YEAR FROM orderdate) = 2004
GROUP BY customernumber
ORDER BY customernumber;

--Q25) Display each retail customer's number and their oldest order date (Hint: group functions and group by clause will be needed)
SELECT customernumber, MAX(orderdate) AS "Oldest Order Date"
FROM retailorders
GROUP BY customernumber; 

-- Q26) Using set operators, display the following information without any duplicates.
/*
a. Using the string ' no order details' for those orders that doesn't have details
b. Use a null date to display orderdates for those orderdetails which doesn't have a date information
c. Make sure the headers have the information given in the screenshot.
*/
SELECT ordernumber, NULL as orderdate, productcode
FROM orderdetails
UNION
SELECT ordernumber, orderdate, 'no order details' AS productcode
FROM retailorders;

-- Q27) Using subqueries, find the retail customer names who have a payment date in April 2005 and who have salesrep who work in San Francisco
SELECT customername 
FROM retailcustomers
WHERE salesrepemployeenumber IN (
    SELECT employeenumber
    FROM retailemployees
    INNER JOIN retailoffices
    USING(officecode)
    WHERE LOWER(city) = 'san francisco'
)
AND customernumber IN (
    SELECT customernumber 
    FROM retailpayments
    WHERE EXTRACT(MONTH FROM paymentdate) = 6
);

-- Q28) Write a SQL query to display employee's name who work with a customer and their name 
SELECT c.customername AS "Customer Name", e.firstname || ' ' || e.lastname AS "Employee Name" 
FROM retailcustomers c
INNER JOIN retailemployees e 
ON c.salesrepemployeenumber = e.employeenumber;

-- Q29) The Retail company’s bank wants to know the range of creditlimit among their retailcustomers
SELECT MIN(creditlimit) AS "Minimum Credit Limit", MAX(creditlimit) AS "Maximum Credit Limit"
FROM retailcustomers;

-- Q30) Find how many weeks an order has been placed at the company? Display the result with “CustomerName” of the customer who placed the order, ordernumber, customernumber and “Weeks Ordered” as second column
SELECT customername, TRUNC((MONTHS_BETWEEN(SYSDATE, orderdate)) * 4) AS "Weeks Ordered", ordernumber, customernumber
FROM retailorders
INNER JOIN retailcustomers
USING(customernumber);

-- Q31) Most of the payments in retailpayment are recurring and are in a 30 day payment cycle. Find out the next payment date for each retailpayment. Display the result with “CheckNumber” , “PaymentDate and “Next Order Date” as third column and “Previous Order Date” as fourth column. Try 'fmDdspth "of" Month YYYY fmHH:MI' for paymentdate and 'fmMM/DD/YY' for previous,next order dates. 
SELECT checknumber, TO_CHAR(paymentdate, 'fmDdspth "of" Month YYYY fmHH:MI') AS "Payment Date", TO_CHAR(paymentdate + 30, 'fmMM/DD/YY') AS "Next Order Date",  TO_CHAR(paymentdate - 30, 'fmMM/DD/YY') AS "Previous Order Date"
FROM retailpayments;

-- Q32) Using Case manipulation and Character Manipulation Functions, display all the product names from retailproducts that ends with “s” or with “r” or  with “p” (Do not use LIKE operator)
SELECT productname 
FROM retailproducts 
WHERE LOWER(SUBSTR(productname, LENGTH(productname))) IN ('r', 's', 'p');

-- Q33) Using round(), trunc(), floor() display the buyprice for retailproducts table 
SELECT ROUND(buyprice), TRUNC(buyprice), FLOOR(buyprice)
FROM retailproducts;

-- Q34) Using lapd() function to display the customernumber in retailcustomers table totalling 10 characters using “*” to fill in the rest of the characters (an example would be ********103) 
SELECT LPAD(customernumber, 10, '*') AS customernumber
FROM retailcustomers;

-- Q35) Using substr(i,n) function display the characters from the third letter in the firstname and lastnames of the retailemployees
SELECT SUBSTR(firstname, 3, LENGTH(firstname)) AS firstname, SUBSTR(lastname, 3, LENGTH(lastname)) AS lastname
FROM retailemployees;

-- Q36) Using NEXT_DAY(), LAST_DAY() functions display the next “SUNDAY” from the order date and the last day of the month in the order date in retailorders table
SELECT NEXT_DAY(orderdate, 'SUNDAY') AS "Next Sunday", LAST_DAY(orderdate) AS "Last day of the month"
FROM retailorders;

-- Q37) Using ADD_MONTHS() function, add 3 months order shipped date in retailorder table and display the results with ordernumber, shipped date and “3months added” column to the result
SELECT ordernumber, shippeddate, ADD_MONTHS(shippeddate, 3) AS "3 Months added"
FROM retailorders
WHERE shippeddate IS NOT NULL;

-- Q38) Using MONTHS_BETWEEN () function, find the number of months from payment date in retailpayments table to todays date and  display the results with customernumber, customer name, , paymentdate and “#months” column.
SELECT customernumber, customername, paymentdate, ROUND(MONTHS_BETWEEN(SYSDATE, paymentdate), 2) AS "#months"
FROM retailpayments
INNER JOIN retailcustomers
USING(customernumber);