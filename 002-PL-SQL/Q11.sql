-- Q11)
-- Write a PL/SQL procedure called “employee_display ” to display employee id 1002 retailemployee's first name and lastname  using simple loop structure

CREATE OR REPLACE PROCEDURE employee_display AS
    m_num retailemployees.employeenumber%type;
    m_firstname retailemployees.firstname%type;
    m_lastname retailemployees.lastname%type;
    CURSOR re IS
        SELECT employeenumber, firstname, lastname
        FROM retailemployees;
BEGIN
    OPEN re;
    LOOP
        FETCH re INTO m_num, m_firstname, m_lastname;
        EXIT WHEN re%notfound;
        IF m_num = 1002
        THEN
            DBMS_OUTPUT.PUT_LINE('f: '  || m_firstname);
            DBMS_OUTPUT.PUT_LINE('l: '  || m_lastname);
        END IF;
    END LOOP;
END;

SET SERVEROUTPUT ON;
BEGIN
    employee_display();
END;