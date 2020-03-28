-- LAB 3 - 4 - 5
--1
SELECT E1.LAST_NAME NUME, TO_CHAR(E1.HIRE_DATE, 'MONTH') LUNA_ANG, TO_CHAR(E1.HIRE_DATE, 'YYYY') AN_ANG
FROM EMPLOYEES E1, EMPLOYEES E2
WHERE
    UPPER(E2.LAST_NAME) = 'GATES'
    AND E1.DEPARTMENT_ID = E2.DEPARTMENT_ID
    AND UPPER(E1.LAST_NAME) LIKE '%A%'
    AND UPPER(E1.LAST_NAME) <> 'GATES';
    
SELECT E1.LAST_NAME NUME, TO_CHAR(E1.HIRE_DATE, 'MONTH') LUNA_ANG, TO_CHAR(E1.HIRE_DATE, 'YYYY') AN_ANG
FROM EMPLOYEES E1
JOIN EMPLOYEES E2 USING (DEPARTMENT_ID)
WHERE
    UPPER(E2.LAST_NAME) = 'GATES'
    AND INSTR(UPPER(E1.LAST_NAME), 'A') <> 0
    AND UPPER(E1.LAST_NAME) <> 'GATES';

--2
SELECT DISTINCT E1.EMPLOYEE_ID, E1.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E1, EMPLOYEES E2, DEPARTMENTS D
WHERE
    UPPER(E2.LAST_NAME) LIKE '%T%'
    AND E1.DEPARTMENT_ID = E2.DEPARTMENT_ID
    AND E1.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY 2;

SELECT DISTINCT E1.EMPLOYEE_ID, E1.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E1 JOIN EMPLOYEES E2 ON (E1.DEPARTMENT_ID = E2.DEPARTMENT_ID)
                JOIN DEPARTMENTS D ON (E1.DEPARTMENT_ID = D.DEPARTMENT_ID)
WHERE UPPER(E2.LAST_NAME) LIKE '%T%'
ORDER BY 2;

SELECT DISTINCT E.EMPLOYEE_ID, E.LAST_NAME, D.DEPARTMENT_ID, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE
    E.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID FROM EMPLOYEES WHERE UPPER(LAST_NAME) LIKE '%T%')
    AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
ORDER BY 2;

--3
SELECT E1.LAST_NAME, E1.SALARY, J.JOB_TITLE, L.CITY, C.COUNTRY_NAME
FROM EMPLOYEES E1, EMPLOYEES E2, JOBS J, LOCATIONS L, COUNTRIES C, DEPARTMENTS D
WHERE
    UPPER(E2.LAST_NAME) = 'KING'
    AND E1.MANAGER_ID = E2.EMPLOYEE_ID
    AND E1.JOB_ID = J.JOB_ID
    AND E1.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID;
    
SELECT E1.LAST_NAME, E1.SALARY, J.JOB_TITLE, L.CITY, C.COUNTRY_NAME
FROM EMPLOYEES E1 JOIN EMPLOYEES E2 ON (E1.MANAGER_ID = E2.EMPLOYEE_ID)
                JOIN JOBS J ON (E1.JOB_ID = J.JOB_ID)
                JOIN DEPARTMENTS D ON (E1.DEPARTMENT_ID = D.DEPARTMENT_ID)
                JOIN LOCATIONS L ON (D.LOCATION_ID = L.LOCATION_ID)
                JOIN COUNTRIES C ON (L.COUNTRY_ID = C.COUNTRY_ID)
WHERE UPPER(E2.LAST_NAME) = 'KING';
    
SELECT E.LAST_NAME, E.SALARY, J.JOB_TITLE, L.CITY, C.COUNTRY_NAME
FROM EMPLOYEES E, JOBS J, LOCATIONS L, COUNTRIES C, DEPARTMENTS D
WHERE
    E.MANAGER_ID IN (SELECT EMPLOYEE_ID FROM EMPLOYEES WHERE UPPER(LAST_NAME) = 'KING')
    AND E.JOB_ID = J.JOB_ID
    AND E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND D.LOCATION_ID = L.LOCATION_ID
    AND L.COUNTRY_ID = C.COUNTRY_ID;
    
--4
SELECT D.DEPARTMENT_ID, D.DEPARTMENT_NAME, E.LAST_NAME, J.JOB_TITLE, TO_CHAR(E.SALARY, '$99,999.99')
FROM DEPARTMENTS D, EMPLOYEES E, JOBS J
WHERE
    UPPER(D.DEPARTMENT_NAME) LIKE '%TI%'
    AND D.DEPARTMENT_ID = E.DEPARTMENT_ID
    AND E.JOB_ID = J.JOB_ID
ORDER BY D.DEPARTMENT_NAME, E.LAST_NAME;

--5
SELECT E.LAST_NAME, E.DEPARTMENT_ID, D.DEPARTMENT_NAME, L.CITY, J.JOB_TITLE
FROM EMPLOYEES E, DEPARTMENTS D, LOCATIONS L, JOBS J
WHERE
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND D.LOCATION_ID = L.LOCATION_ID
    AND E.JOB_ID = J.JOB_ID
    AND UPPER(L.CITY) = 'OXFORD';

--6
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.SALARY
FROM EMPLOYEES E, JOBS J
WHERE
    E.JOB_ID = J.JOB_ID
    AND SALARY > (J.MAX_SALARY + J.MIN_SALARY)/2
    AND E.DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID
                            FROM EMPLOYEES
                            WHERE UPPER(LAST_NAME) LIKE '%T%');
                            
SELECT E.EMPLOYEE_ID, E.LAST_NAME, E.SALARY
FROM EMPLOYEES E
WHERE
    E.DEPARTMENT_ID IN (SELECT DISTINCT DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE UPPER(LAST_NAME) LIKE '%T%')
    AND E.SALARY > (SELECT AVG(E2.SALARY)
                    FROM EMPLOYEES E2
                    WHERE E.JOB_ID = E2.JOB_ID);

--7
SELECT E.LAST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+);

SELECT E.LAST_NAME, D.DEPARTMENT_NAME
FROM DEPARTMENTS D RIGHT JOIN EMPLOYEES E USING (DEPARTMENT_ID);

--9
SELECT D.DEPARTMENT_NAME, E.LAST_NAME
FROM DEPARTMENTS D, EMPLOYEES E
WHERE D.DEPARTMENT_ID = E.DEPARTMENT_ID(+);

SELECT D.DEPARTMENT_NAME, E.LAST_NAME
FROM DEPARTMENTS D LEFT JOIN EMPLOYEES E USING (DEPARTMENT_ID);

--10
SELECT E.LAST_NAME, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID = D.DEPARTMENT_ID(+)
UNION
SELECT E.LAST_NAME, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E, DEPARTMENTS D
WHERE E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID;

SELECT E.LAST_NAME, E.FIRST_NAME, D.DEPARTMENT_NAME
FROM EMPLOYEES E FULL JOIN DEPARTMENTS D USING (DEPARTMENT_ID);  

--11
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE UPPER(DEPARTMENT_NAME) LIKE '%RE%'
UNION
SELECT D.DEPARTMENT_ID
FROM DEPARTMENTS D, EMPLOYEES E
WHERE
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND E.JOB_ID = 'SA_REP';

--13
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
MINUS
SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEES;

SELECT DISTINCT D.DEPARTMENT_ID
FROM EMPLOYEES E, DEPARTMENTS D
WHERE
    E.DEPARTMENT_ID(+) = D.DEPARTMENT_ID
    AND E.DEPARTMENT_ID IS NULL
ORDER BY 1;

--14
SELECT DEPARTMENT_ID
FROM DEPARTMENTS
WHERE UPPER(DEPARTMENT_NAME) LIKE '%RE%'
INTERSECT
SELECT DISTINCT DEPARTMENT_ID
FROM EMPLOYEES
WHERE UPPER(JOB_ID) = 'HR_REP';

--15
SELECT EMPLOYEE_ID, JOB_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY > 3000
UNION
SELECT E.EMPLOYEE_ID, E.JOB_ID, E.LAST_NAME, E.SALARY
FROM EMPLOYEES E, JOBS J
WHERE
    E.SALARY = (J.MAX_SALARY + J.MIN_SALARY) / 2
    AND J.JOB_ID = E.JOB_ID;
    
--16
SELECT E.LAST_NAME, E.HIRE_DATE
FROM EMPLOYEES E
WHERE E.HIRE_DATE > (SELECT E2.HIRE_DATE
                    FROM EMPLOYEES E2
                    WHERE UPPER(E2.LAST_NAME) = 'GATES');
                    
--17
SELECT E.LAST_NAME, E.SALARY
FROM EMPLOYEES E
WHERE
    E.DEPARTMENT_ID = (SELECT E2.DEPARTMENT_ID
                        FROM EMPLOYEES E2
                        WHERE UPPER(E2.LAST_NAME) = 'GATES')
    AND UPPER(E.LAST_NAME) <> 'GATES';        

SELECT E.LAST_NAME, E.SALARY
FROM EMPLOYEES E, (SELECT DEPARTMENT_ID, EMPLOYEE_ID
                    FROM EMPLOYEES
                    WHERE UPPER(LAST_NAME) = 'GATES') AUX
WHERE
    E.DEPARTMENT_ID = AUX.DEPARTMENT_ID
    AND E.EMPLOYEE_ID <> AUX.EMPLOYEE_ID;
    
--18
SELECT E.LAST_NAME, E.SALARY
FROM EMPLOYEES E
WHERE E.MANAGER_ID = (SELECT E2.EMPLOYEE_ID
                        FROM EMPLOYEES E2
                        WHERE E2.MANAGER_ID IS NULL);

--19
SELECT DISTINCT E.LAST_NAME, E.DEPARTMENT_ID, E.SALARY
FROM EMPLOYEES E, (SELECT E2.DEPARTMENT_ID, E2.SALARY
                    FROM EMPLOYEES E2
                    WHERE E2.COMMISSION_PCT IS NOT NULL) A
WHERE
    E.DEPARTMENT_ID = A.DEPARTMENT_ID
    AND E.SALARY = A.SALARY;
    
SELECT DISTINCT E.LAST_NAME, E.DEPARTMENT_ID, E.SALARY
FROM EMPLOYEES E
WHERE (E.DEPARTMENT_ID, E.SALARY) IN (SELECT E2.DEPARTMENT_ID, E2.SALARY
                                        FROM EMPLOYEES E2
                                        WHERE E2.COMMISSION_PCT IS NOT NULL);

--21
SELECT E.*
FROM EMPLOYEES E
WHERE E.SALARY > ALL (SELECT E2.SALARY
                        FROM EMPLOYEES E2
                        WHERE INSTR(UPPER(E2.JOB_ID), 'CLERK') <> 0)
ORDER BY E.SALARY DESC;
                        
--22
SELECT E.LAST_NAME, D.DEPARTMENT_NAME, E.SALARY, E.COMMISSION_PCT
FROM EMPLOYEES E, DEPARTMENTS D
WHERE
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND E.COMMISSION_PCT IS NULL
    AND E.MANAGER_ID IN (SELECT E2.EMPLOYEE_ID
                            FROM EMPLOYEES E2
                            WHERE E2.COMMISSION_PCT IS NOT NULL);
                            
--23
SELECT E.LAST_NAME, D.DEPARTMENT_NAME, E.SALARY, J.JOB_TITLE
FROM EMPLOYEES E, DEPARTMENTS D, JOBS J
WHERE
    E.DEPARTMENT_ID = D.DEPARTMENT_ID
    AND E.JOB_ID = J.JOB_ID
    AND (E.SALARY, E.COMMISSION_PCT) IN (SELECT SALARY, COMMISSION_PCT
                                        FROM EMPLOYEES
                                        WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                                                                    FROM DEPARTMENTS
                                                                    WHERE LOCATION_ID IN (SELECT LOCATION_ID
                                                                                            FROM LOCATIONS
                                                                                            WHERE UPPER(CITY) = 'OXFORD')));

--24
SELECT E.LAST_NAME, E.DEPARTMENT_ID, E.JOB_ID
FROM EMPLOYEES E
WHERE E.DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                            FROM DEPARTMENTS
                            WHERE LOCATION_ID IN (SELECT LOCATION_ID
                                                    FROM LOCATIONS
                                                    WHERE UPPER(CITY) = 'TORONTO'));