Example of syntax:

CREATE TABLE tableName(  
AttributeName1 type,  
AttributeName2 type, …  
AttributeName5 type,  
…  
PRIMARY KEY(attributeName1),  
FOREIGN KEY(attributeName5)  
REFERENCES tableName(matching-attributeName-in-tableName)  
);

Example:

CREATE TABLE Venues
 (venueID VARCHAR(6) NOT NULL,
 VenueName VARCHAR2(50),
 venueAddress VARCHAR2(70),
 venueCapacity NUMBER(4) NOT NULL,
 costPerDay NUMBER (7,2),
 venueManager VARCHAR2(50),
 managerPhoneNo VARCHAR2(15),
PRIMARY KEY (venueID));

Add data into the Venues:

INSERT INTO Venues
 (venueID, venueName, venueAddress, venueCapacity, costPerDay, venueManager, managerPhoneNo)
VALUES
 ('V0001', 'Town Hall', '15 High St, Local Town', 800, 650.00, 'Sean 0''Riley', '9333 2498');

Show the data in venues database:

ALTER TABLE venues
modify VENUEID Null

ALTER TABLE venues add testColumn varchar2(2) not null --will not work

Update Venues
Set venueName = 'City Hall'
where venueID = 'V0001';

INSERT INTO Venues (VENUEID, VENUENAME, VENUEADDRESS, VENUECAPACITY, COSTPERDAY, VENUEMANAGER, MANAGERPHONENO)
VALUES ('V0003', 'Other Hall', '123 st', 800, 200, 'bob jones', '0498334757');

DELETE
FROM venues
WHERE venueID = 'V0003';

select * from recyclebin;


Select * from Venues 
or
Select venueID, venueName from Venues;