
-- the function is called 'ClassInfo' and it takes two parameters, the department and the course number
CREATE OR REPLACE FUNCTION ClassInfo (
p_DEPARTMENT classes.DEPARTMENT%TYPE,
p_COURSE    classes.COURSE%TYPE)

RETURN VARCHAR2 IS

v_CURRENTSTUDENTS NUMBER;
v_MAXSTUDENTSs; NUMBER;
v_PercentFullNUMBER;

BEGIN
  -- Get the current and maximum students for the requested
  -- course.
  SELECT CURRENTSTUDENTS, MAXSTUDENTS
    INTO v_CURRENTSTUDENTS, v_MAXSTUDENTS
    FROM CLASSES
    WHERE department = p_Department
    AND course = p_Course;

  -- Calculate the current percentage.
  v_PercentFull := (v_CURRENTSTUDENTS / v_MAXSTUDENTS) * 100;
  
  CASE
  WHEN v_PercentFull = 100 THEN
    RETURN 'Full';
  WHEN v_PercentFull > 80 THEN
    RETURN 'Some Room';
  WHEN v_PercentFull > 60 THEN
    RETURN 'More Room';
  WHEN v_PercentFull > 0 THEN
    RETURN 'Lots of Room';
  ELSE
    RETURN 'Empty';
  END CASE;
END ClassInfo;
/

