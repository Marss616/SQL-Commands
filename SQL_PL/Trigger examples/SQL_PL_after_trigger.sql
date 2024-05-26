CREATE OR REPLACE TRIGGER ExampleAfterTrigger
AFTER INSERT ON Courses
FOR EACH ROW
DECLARE
    -- Declare any necessary variables here
    v_currentStudents NUMBER;
    v_maxStudents NUMBER;
BEGIN
    -- Example logic: Check if the current number of students exceeds the maximum allowed students
    SELECT currentstudents, maxstudents
    INTO v_currentStudents, v_maxStudents
    FROM Courses
    WHERE course = :NEW.course;
    
    IF v_currentStudents > v_maxStudents THEN
        -- If the number of current students exceeds the maximum, raise an error
        RAISE_APPLICATION_ERROR(-20001, 'Number of students exceeds the maximum allowed for course ' || :NEW.course);
    END IF;

    -- Additional logic can be added here

END ExampleAfterTrigger;
/
