-- =====================================
-- PART 1
-- =====================================

-- Q1.1: Declare variables and print student info + honor status
SET SERVEROUTPUT ON;

DECLARE
    v_student_name VARCHAR2(100) := 'Alice Johnson'; -- student name
    v_gpa NUMBER := 3.8;                             -- GPA value
    v_today DATE := SYSDATE;                         -- current date
    v_honor BOOLEAN;                                 -- honor flag
BEGIN
    v_honor := (v_gpa > 3.5); -- check if GPA qualifies for honor

    DBMS_OUTPUT.PUT_LINE('Student: ' || v_student_name);
    DBMS_OUTPUT.PUT_LINE('GPA: ' || v_gpa);
    DBMS_OUTPUT.PUT_LINE('Date: ' || TO_CHAR(v_today,'DD-MON-YY'));
    DBMS_OUTPUT.PUT_LINE('Honor Roll: ' || CASE 
        WHEN v_honor THEN 'TRUE' ELSE 'FALSE' END);
END;
/

-- Q1.2: Fetch student data from table using SELECT INTO
SET SERVEROUTPUT ON;

DECLARE
    v_first_name students.first_name%TYPE; -- same type as table column
    v_last_name students.last_name%TYPE;
    v_gpa students.gpa%TYPE;
BEGIN
    SELECT first_name, last_name, gpa
    INTO v_first_name, v_last_name, v_gpa
    FROM students
    WHERE student_id = 1005;

    DBMS_OUTPUT.PUT_LINE('Student: ' || v_first_name || ' ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('GPA: ' || v_gpa);
END;
/

-- Q1.3: Calculate salary increment (15%)
SET SERVEROUTPUT ON;

DECLARE
    v_salary employees.salary%TYPE;
    v_incremented_salary NUMBER;
BEGIN
    SELECT salary
    INTO v_salary
    FROM employees
    WHERE employee_id = 7;

    v_incremented_salary := v_salary * 1.15; -- add 15%

    DBMS_OUTPUT.PUT_LINE('Current Salary: ' || v_salary);
    DBMS_OUTPUT.PUT_LINE('15% Increment: ' || v_incremented_salary);
END;
/

-- =====================================
-- PART 2
-- =====================================

-- Q2.1: Classify student based on GPA using IF-ELSIF
SET SERVEROUTPUT ON;

DECLARE
    v_student_name students.first_name%TYPE;
    v_gpa students.gpa%TYPE;
    v_classification VARCHAR2(50);
    v_status_message VARCHAR2(50);
BEGIN
    SELECT first_name || ' ' || last_name, gpa
    INTO v_student_name, v_gpa
    FROM students
    WHERE student_id = 1011;

    IF v_gpa BETWEEN 3.7 AND 4 THEN
        v_classification := 'Summa Cum Laude';
        v_status_message := 'Outstanding performance';
    ELSIF v_gpa BETWEEN 3.3 AND 3.6 THEN
        v_classification := 'Magna Cum Laude';
        v_status_message := 'Outstanding performance';
    ELSIF v_gpa BETWEEN 3.0 AND 3.2 THEN
        v_classification := 'Cum Laude';
        v_status_message := 'Excellent performance';
    ELSIF v_gpa BETWEEN 2.0 AND 2.9 THEN
        v_classification := 'Satisfactory';
        v_status_message := 'Good performance';
    ELSE
        v_classification := 'Academic Probation';
        v_status_message := 'Urgent action required';
    END IF;

    DBMS_OUTPUT.PUT_LINE('Student ' || v_student_name || ' | GPA: ' || v_gpa ||
    ' | Classification: ' || v_classification || ' | ' || v_status_message);
END;
/

-- Q2.2: Determine salary band and program eligibility
SET SERVEROUTPUT ON;

DECLARE
    v_salary employees.salary%TYPE;
    v_dept employees.department%TYPE;
    v_band VARCHAR2(50);
BEGIN
    SELECT salary, department
    INTO v_salary, v_dept
    FROM employees
    WHERE employee_id = 2;

    IF v_salary < 50000 THEN
        v_band := 'Entry Level';
    ELSIF v_salary BETWEEN 50000 AND 69999 THEN
        v_band := 'Mid Level';
    ELSIF v_salary BETWEEN 70000 AND 89999 THEN
        v_band := 'Senior Level';
    ELSE
        v_band := 'Executive Level';
    END IF;

    DBMS_OUTPUT.PUT_LINE('Employee Salary Band: ' || v_band);

    IF v_dept = 'Computer Science' 
       AND (v_band = 'Senior Level' OR v_band = 'Executive Level') THEN
        DBMS_OUTPUT.PUT_LINE('Eligible for Tech Leadership Program');
    END IF;
END;
/

-- Q2.3: Handle NULL and NO_DATA_FOUND exception
SET SERVEROUTPUT ON;

DECLARE
    v_grade enrollments.grade%TYPE;
    v_score enrollments.score%TYPE;
BEGIN
    SELECT grade, score
    INTO v_grade, v_score
    FROM enrollments
    WHERE student_id = 1003
    AND course_id = 103;

    IF v_grade IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Grade: ' || v_grade || ' | Score: ' || v_score);
    ELSE
        DBMS_OUTPUT.PUT_LINE('Grade pending');
    END IF;

EXCEPTION
    WHEN NO_DATA_FOUND THEN
        DBMS_OUTPUT.PUT_LINE('Student not enrolled in this course');
END;
/

-- =====================================
-- PART 3
-- =====================================

-- Q3.1: Convert grade to GPA points using CASE
SET SERVEROUTPUT ON;

DECLARE
    v_grade enrollments.grade%TYPE;
    v_gpa_points NUMBER;
BEGIN
    SELECT grade
    INTO v_grade
    FROM enrollments
    WHERE enrollment_id = 1;

    v_gpa_points := CASE v_grade
        WHEN 'A' THEN 4.0
        WHEN 'B' THEN 3.0
        WHEN 'C' THEN 2.0
        WHEN 'D' THEN 1.0
        WHEN 'F' THEN 0.0
        ELSE NULL
    END;

    DBMS_OUTPUT.PUT_LINE('Enrollment 1 | Grade: ' ||
    NVL(v_grade,'Not yet assigned') ||
    ' | GPA Points: ' ||
    NVL(TO_CHAR(v_gpa_points),'Not yet assigned'));
END;
/

-- Q3.2: Budget and manager evaluation using CASE
SET SERVEROUTPUT ON;

DECLARE
    v_budget departments.budget%TYPE;
    v_manager_id departments.manager_id%TYPE;
    v_budget_status VARCHAR2(100);
    v_manager_status VARCHAR2(50);
BEGIN
    SELECT budget, manager_id
    INTO v_budget, v_manager_id
    FROM departments
    WHERE department_name = 'Computer Science';

    v_budget_status := CASE
        WHEN v_budget > 700000 THEN 'High Budget'
        WHEN v_budget BETWEEN 500000 AND 700000 THEN 'Medium Budget'
        ELSE 'Low Budget'
    END;

    v_manager_status := CASE
        WHEN v_manager_id IS NULL THEN 'No Manager Assigned'
        ELSE 'Has Manager'
    END;

    DBMS_OUTPUT.PUT_LINE('Budget Status: ' || v_budget_status);
    DBMS_OUTPUT.PUT_LINE('Manager Status: ' || v_manager_status);
END;
/
-- Q3.3: Classify course workload based on credits
SET SERVEROUTPUT ON;

DECLARE
    v_course_name courses.course_name%TYPE;
    v_credits courses.credits%TYPE;
    v_instructor courses.instructor%TYPE;
    v_workload VARCHAR2(100);
BEGIN
    SELECT course_name, credits, instructor
    INTO v_course_name, v_credits, v_instructor
    FROM courses
    WHERE course_id = 101;

    v_workload := CASE v_credits
        WHEN 1 THEN 'Light Load'
        WHEN 2 THEN 'Light Load'
        WHEN 3 THEN 'Standard Load'
        WHEN 4 THEN 'Heavy Load'
        WHEN 5 THEN 'Overload — Requires special permission'
        ELSE 'Unknown Load'
    END;

    DBMS_OUTPUT.PUT_LINE(
        'Course: ' || v_course_name ||
        ' | Credits: ' || v_credits ||
        ' | Instructor: ' || v_instructor ||
        ' | Workload: ' || v_workload
    );
END;
/

-- =====================================
-- PART 4
-- =====================================

-- Q4.1: Loop to simulate GPA improvement over semesters
SET SERVEROUTPUT ON;

DECLARE
    v_gpa NUMBER := 2.0;
    v_semester NUMBER := 1;
    v_classification VARCHAR2(50);
BEGIN
    LOOP
        v_classification := CASE
            WHEN v_gpa BETWEEN 3.7 AND 4.0 THEN 'Summa Cum Laude'
            WHEN v_gpa BETWEEN 3.3 AND 3.6 THEN 'Magna Cum Laude'
            WHEN v_gpa BETWEEN 3.0 AND 3.2 THEN 'Cum Laude'
            WHEN v_gpa BETWEEN 2.0 AND 2.9 THEN 'Satisfactory'
            ELSE 'Academic Probation'
        END;

        DBMS_OUTPUT.PUT_LINE('Semester ' || v_semester ||
        ': GPA = ' || TO_CHAR(v_gpa,'9.99') ||
        ' -- ' || v_classification);

        v_gpa := v_gpa + 0.15;
        EXIT WHEN v_gpa > 3.5;
        v_semester := v_semester + 1;
    END LOOP;

    DBMS_OUTPUT.PUT_LINE('Total Semesters Needed: ' || v_semester);
END;
/

-- Q4.2: Cursor loop to analyze scores
SET SERVEROUTPUT ON;

DECLARE
    CURSOR c_scores IS
        SELECT score FROM enrollments
        WHERE course_id = 101 AND score IS NOT NULL;

    v_score NUMBER;
    v_total_students NUMBER := 0;
    v_total_score NUMBER := 0;
BEGIN
    OPEN c_scores;
    LOOP
        FETCH c_scores INTO v_score;
        EXIT WHEN c_scores%NOTFOUND;

        v_total_students := v_total_students + 1;
        v_total_score := v_total_score + v_score;
    END LOOP;
    CLOSE c_scores;

    DBMS_OUTPUT.PUT_LINE('Total Students: ' || v_total_students);
    DBMS_OUTPUT.PUT_LINE('Average Score: ' ||
        (v_total_score / v_total_students));
END;
/
-- PART 5: Full student performance report
SET SERVEROUTPUT ON;

DECLARE
    v_student_name students.first_name%TYPE;
    v_gpa students.gpa%TYPE;
    v_status students.status%TYPE;
    v_enroll_date students.enrollment_date%TYPE;

    v_years_enrolled NUMBER;
    v_continuing_status VARCHAR2(20);

    CURSOR c_courses IS
        SELECT e.course_id, c.course_name, c.credits, e.score, e.grade
        FROM enrollments e
        JOIN courses c ON e.course_id = c.course_id
        WHERE e.student_id = 1007;

    v_course c_courses%ROWTYPE;

    v_total_courses NUMBER := 0;
    v_total_credits NUMBER := 0;
    v_highest_score NUMBER := -1;
    v_best_course VARCHAR2(100) := '';
    v_in_progress NUMBER := 0;

    v_academic_standing VARCHAR2(50);
    v_scholarship_note VARCHAR2(100) := '';

BEGIN
    SELECT first_name || ' ' || last_name, gpa, status, enrollment_date
    INTO v_student_name, v_gpa, v_status, v_enroll_date
    FROM students
    WHERE student_id = 1007;

    v_years_enrolled := ROUND(MONTHS_BETWEEN(SYSDATE, v_enroll_date)/12,1);

    IF v_years_enrolled > 1 THEN
        v_continuing_status := 'Continuing Student';
    ELSE
        v_continuing_status := 'New Student';
    END IF;

    v_academic_standing := CASE
        WHEN v_gpa BETWEEN 3.7 AND 4 THEN 'Summa Cum Laude'
        WHEN v_gpa BETWEEN 3.3 AND 3.6 THEN 'Magna Cum Laude'
        WHEN v_gpa BETWEEN 3.0 AND 3.2 THEN 'Cum Laude'
        WHEN v_gpa BETWEEN 2.0 AND 2.9 THEN 'Satisfactory'
        ELSE 'Academic Probation'
    END;

    IF v_gpa >= 3.5 THEN
        v_scholarship_note := 'May qualify for merit scholarship';
    END IF;

    OPEN c_courses;
    LOOP
        FETCH c_courses INTO v_course;
        EXIT WHEN c_courses%NOTFOUND;

        v_total_courses := v_total_courses + 1;
        v_total_credits := v_total_credits + v_course.credits;

        IF v_course.score IS NOT NULL 
           AND v_course.score > v_highest_score THEN
            v_highest_score := v_course.score;
            v_best_course := v_course.course_name;
        END IF;

        IF v_course.grade IS NULL THEN
            v_in_progress := v_in_progress + 1;
        END IF;

    END LOOP;
    CLOSE c_courses;

    DBMS_OUTPUT.PUT_LINE('===== SEMESTER REPORT =====');
    DBMS_OUTPUT.PUT_LINE('Student: ' || v_student_name);
    DBMS_OUTPUT.PUT_LINE('Status: ' || v_status || ' | ' || v_continuing_status);
    DBMS_OUTPUT.PUT_LINE('GPA: ' || v_gpa || ' | Standing: ' || v_academic_standing);

    IF v_scholarship_note IS NOT NULL THEN
        DBMS_OUTPUT.PUT_LINE('Scholarship: ' || v_scholarship_note);
    END IF;

    DBMS_OUTPUT.PUT_LINE('Courses: ' || v_total_courses);
    DBMS_OUTPUT.PUT_LINE('Credits: ' || v_total_credits);
    DBMS_OUTPUT.PUT_LINE('Best Course: ' || v_best_course || 
                         ' (Score: ' || v_highest_score || ')');
    DBMS_OUTPUT.PUT_LINE('In Progress: ' || v_in_progress);

END;
/