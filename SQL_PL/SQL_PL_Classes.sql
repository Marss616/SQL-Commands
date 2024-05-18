
-- the function is called 'ClassInfo' and it takes two parameters, the department and the course number
CREATE OR REPLACE FUNCTION ClassInfo (
p_Department classes.department%TYPE,
p_Course     classes.course%TYPE)

RETURN VARCHAR2 IS

v_CurrentStudents NUMBER;
v_MaxStudents; NUMBER;
v_PercentFullNUMBER;

BEGIN
  -- Get the current and maximum students for the requested
  -- course.
  SELECT current_students, max_students
    INTO v_CurrentStudents, v_MaxStudents
    FROM CLASSES
    WHERE department = p_Department
    AND course = p_Course;

  -- Calculate the current percentage.
  v_PercentFull := (v_CurrentStudents / v_MaxStudents) * 100;
  
IF v_PercentFull = 100 THEN
    RETURN 'Full';
  ELSIF v_PercentFull > 80 THEN
    RETURN 'Some Room';
  ELSIF v_PercentFull > 60 THEN
    RETURN 'More Room';
  ELSIF v_PercentFull > 0 THEN
    RETURN 'Lots of Room';
  ELSE
    RETURN 'Empty';
  END IF;
END ClassInfo;
/