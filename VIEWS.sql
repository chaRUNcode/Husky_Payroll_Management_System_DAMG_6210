SET SERVEROUTPUT ON;

BEGIN
    -- Attempt to drop each view if it exists
    FOR v IN (SELECT 'VIEW_DEPARTMENT' AS view_name FROM dual
              UNION ALL
              SELECT 'VIEW_SUPERVISOR' FROM dual
              UNION ALL
              SELECT 'VIEW_JOBS' FROM dual
              UNION ALL
              SELECT 'VIEW_STUDENT_JOBS' FROM dual
              UNION ALL
              SELECT 'VIEW_STUDENTS' FROM dual
              UNION ALL
              SELECT 'VIEW_ATTENDANCE' FROM dual
              UNION ALL
              SELECT 'VIEW_PAYROLL' FROM dual
              UNION ALL
              SELECT 'CURRENT_SALARY' FROM dual)
    LOOP
        BEGIN
            EXECUTE IMMEDIATE 'DROP VIEW ' || v.view_name;
            DBMS_OUTPUT.PUT_LINE(v.view_name || ' view dropped.');
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE(v.view_name || ' view does not exist. Continuing.');
        END;
    END LOOP;

    -- Recreate views and output a message for each
    EXECUTE IMMEDIATE 'CREATE VIEW VIEW_DEPARTMENT AS SELECT * FROM DEPARTMENT';
    DBMS_OUTPUT.PUT_LINE('VIEW_DEPARTMENT view created.');

    EXECUTE IMMEDIATE 'CREATE VIEW VIEW_SUPERVISOR AS SELECT * FROM SUPERVISOR';
    DBMS_OUTPUT.PUT_LINE('VIEW_SUPERVISOR view created.');

    EXECUTE IMMEDIATE 'CREATE VIEW VIEW_JOBS AS SELECT * FROM JOBS';
    DBMS_OUTPUT.PUT_LINE('VIEW_JOBS view created.');

    EXECUTE IMMEDIATE 'CREATE VIEW VIEW_STUDENT_JOBS AS SELECT * FROM STUDENT_JOBS';
    DBMS_OUTPUT.PUT_LINE('VIEW_STUDENT_JOBS view created.');

    EXECUTE IMMEDIATE 'CREATE VIEW VIEW_STUDENTS AS SELECT * FROM STUDENTS';
    DBMS_OUTPUT.PUT_LINE('VIEW_STUDENTS view created.');

    EXECUTE IMMEDIATE 'CREATE VIEW VIEW_ATTENDANCE AS SELECT * FROM ATTENDANCE';
    DBMS_OUTPUT.PUT_LINE('VIEW_ATTENDANCE view created.');

    EXECUTE IMMEDIATE 'CREATE VIEW VIEW_PAYROLL AS SELECT * FROM PAYROLL';
    DBMS_OUTPUT.PUT_LINE('VIEW_PAYROLL view created.');

    EXECUTE IMMEDIATE 'CREATE VIEW CURRENT_SALARY AS SELECT p.NU_ID, p.JOB_ID, j.HOURLY_WAGE, p.START_DATE, p.END_DATE, (p.HOURS_WORKED * j.HOURLY_WAGE) AS SALARY FROM PAYROLL p JOIN JOBS j ON p.JOB_ID = j.JOB_ID WHERE p.START_DATE <= SYSDATE AND p.END_DATE >= SYSDATE';
    DBMS_OUTPUT.PUT_LINE('CURRENT_SALARY view created.');

    DBMS_OUTPUT.PUT_LINE('All views recreated successfully.');
EXCEPTION
    WHEN OTHERS THEN
        DBMS_OUTPUT.PUT_LINE('An unexpected error occurred: ' || SQLERRM);
END;
/