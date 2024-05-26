CREATE OR REPLACE TRIGGER ExampleBeforeTrigger
BEFORE INSERT ON CLASSES
FOR EACH ROW
DELCARE
.....

BEGIN
.....
END  ExampleBeforeTrigger;
/


Trigger 2: an after trigger
CREATE OR REPLACE TRIGGER ExampleAfterTrigger
AFTER INSERT ON CLASSES
FOR EACH ROW
DELCARE
.....

BEGIN
.....
END  ExampleAfterTrigger;
/