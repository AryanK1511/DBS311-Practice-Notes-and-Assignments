-- Q15)
-- Copy the script that produces the tables PATIENT4 AND INSURANCE4. We will create a procedure that applies a percentage of the charge according to what the insurance company rate is included.

CREATE OR REPLACE PROCEDURE insurance_pays (
    m_insurancenumber IN patient4.pinsurnum%type,
    m_percentage IN NUMBER
) AS
BEGIN
    UPDATE patient4
    SET insurepays = ((m_percentage / 100) * charge)
    WHERE pinsurnum = m_insurancenumber;
END;

EXECUTE insurance_pays(444, 85);