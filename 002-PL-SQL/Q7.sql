-- Q7)
-- Write a stored procedure named employee_works_here to print the retail employee number, employee Last name and job title.(USING WHILE LOOP)
-- If the value of the job title is null or does not exist, display “no job title”.

CREATE OR REPLACE procedure employee_works_here AS
    rws INT := 0;
    m_empnumber retailemployees.employeenumber%type;
    m_lastname retailemployees.lastname%type;
    m_title retailemployees.jobtitle%type;
    CURSOR rp_cursor IS
        SELECT employeenumber, lastname, jobtitle
        FROM retailemployees;
BEGIN
    SELECT COUNT(*) INTO rws FROM retailemployees;
    OPEN rp_cursor;
    WHILE rws > 0 LOOP
        FETCH rp_cursor INTO m_empnumber, m_lastname, m_title;
        IF m_title IS NULL
            THEN DBMS_OUTPUT.PUT_LINE('No Job title');
        END IF;
        DBMS_OUTPUT.PUT_LINE('Employee #: ' || m_empnumber);
        DBMS_OUTPUT.PUT_LINE('Last Name: ' || m_lastname);
        DBMS_OUTPUT.PUT_LINE('Job Title: ' || m_title);
        DBMS_OUTPUT.PUT_LINE(' ');
        rws := rws - 1;
    END LOOP;
    CLOSE rp_cursor;
EXCEPTION
    WHEN INVALID_CURSOR
        THEN DBMS_OUTPUT.PUT_LINE('Invalid Cursor');
    WHEN OTHERS
        THEN DBMS_OUTPUT.PUT_LINE('Error!');
END;

SET SERVEROUTPUT ON;
BEGIN
    employee_works_here();
END;