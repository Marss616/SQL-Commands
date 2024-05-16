-- DBF S1 2024
-- Schema Definition
-- New Endor Airlines Database

DROP TABLE MODEL                CASCADE CONSTRAINTS;   
DROP TABLE LOCATION             CASCADE CONSTRAINTS;    
DROP TABLE TICKET               CASCADE CONSTRAINTS;    
DROP TABLE ROUTE                CASCADE CONSTRAINTS;    
DROP TABLE AIRCRAFT             CASCADE CONSTRAINTS;        
DROP TABLE STAFF                CASCADE CONSTRAINTS;     
DROP TABLE PILOT                CASCADE CONSTRAINTS;     
DROP TABLE FLIGHT_ATTENDANT     CASCADE CONSTRAINTS;     
DROP TABLE CUSTOMER             CASCADE CONSTRAINTS;     
DROP TABLE FLIGHT               CASCADE CONSTRAINTS;
DROP TABLE ADDITIONAL_PILOT     CASCADE CONSTRAINTS;
DROP TABLE HOSTING              CASCADE CONSTRAINTS;
DROP TABLE PILOT_QUALIFICATION  CASCADE CONSTRAINTS;

      
-- PURGE RECYCLEBIN;
------ CREATE TABLE STATEMENTS ------

CREATE TABLE MODEL                (
modelID 				varchar2(15) not null, 
economySeats 			number(3), 
businessSeats 			number(3), 
firstClassSeats 		number(3), 
cargoCapacity 			number(6), 
fuelCapacity 			number(6), 
planeLength 			number(5), 
wingspan 				number(5),
PRIMARY KEY(modelID)
); 
  
CREATE TABLE LOCATION             (
airportCode 			char(3)  not null, 
country 				varchar2(10), 
address 				varchar2(55), 
phone 					varchar2(15),
PRIMARY KEY(airportCode)
); 

CREATE TABLE ROUTE                (
routeID 				varchar2(5)   not null, 
description 			varchar2(100), 
arriveAirportCode 		char(3)    not null, 
departAirportCode 		char(3)    not null,
PRIMARY KEY(routeID),
FOREIGN KEY(arriveAirportCode) REFERENCES LOCATION(airportCode),
FOREIGN KEY(departAirportCode) REFERENCES LOCATION(airportCode)
);  

CREATE TABLE STAFF                (
staffID 				varchar2(5)  not null, 
name 					varchar2(20), 
address 				varchar2(55), 
email 					varchar2(25), 
phone 					varchar2(15), 
passportNum 			varchar2(10) not null,
PRIMARY KEY(staffID)
); 

CREATE TABLE PILOT                (
staffID 				varchar2(5)  not null, 
prevHrsPilotExp 		number(5), 
PRIMARY KEY(staffID),
FOREIGN KEY(staffID) REFERENCES STAFF(staffID)
); 

CREATE TABLE FLIGHT_ATTENDANT                (
staffID 				varchar2(5)  not null, 
PRIMARY KEY(staffID),
FOREIGN KEY(staffID) REFERENCES STAFF(staffID)
); 

CREATE TABLE AIRCRAFT             (
aircraftID 				varchar2(5) not null, 
modelID 				varchar2(15) not null, 
PRIMARY KEY(aircraftID),
FOREIGN KEY(modelID) REFERENCES MODEL(modelID)
);

CREATE TABLE CUSTOMER             (
customerID     			varchar2(5)   not null, 
name           			varchar2(20), 
address        			varchar2(55), 
country 				varchar2(20), 
email 					varchar2(25), 
phone 					varchar2(15), 
birthdate 				date, 
passportNum 			varchar2(10), 
PRIMARY KEY(customerID)
);   

CREATE TABLE FLIGHT               (
flightID              	 char(9)   not null, 
estDepartureDateTime  	 date, 
actDepartDateTime 		 date, 
actArriveDateTime 		 date,  		 
avgSpeed				 number(6),
avgHeight				 number(6),
estDuration	             number(4),
estFuel					 number(5),
captainStaffID 			 varchar2(5) not null, -- every flight must have captain, first officer, route and aircraft
firstOfficerStaffID 	 varchar2(5) not null,  
routeID 				 varchar2(5) not null, 
aircraftID 				 varchar2(5) not null, 
PRIMARY KEY(flightID),
FOREIGN KEY(captainStaffID) REFERENCES PILOT(staffID),
FOREIGN KEY(firstOfficerStaffID) REFERENCES PILOT(staffID),
FOREIGN KEY(routeID) REFERENCES ROUTE(routeID),
FOREIGN KEY(aircraftID) REFERENCES AIRCRAFT(aircraftID)
);


CREATE TABLE TICKET               (
ticketNum 				varchar2(5) not null, 
luggageLimit 			number(2), -- must be in kilograms
seatNum 				number(3), 
classCode               char(2) CHECK( classCode IN ('E','B','F') ), 
medicalCondition        varchar2(30), 
mealChoice              char(2) CHECK( mealChoice IN ('ST', 'VG') ), --ST for standard and VG for vegan and GF
customerID 				varchar2(5) not null, 
flightID 				char(9)   not null,
PRIMARY KEY(ticketNum),
FOREIGN KEY(customerID) REFERENCES CUSTOMER(customerID),
FOREIGN KEY(flightID) REFERENCES FLIGHT(flightID)
); 
 

CREATE TABLE ADDITIONAL_PILOT     (
staffID 				varchar2(5) not null, 
flightID 				char(9)   not null, 
activityCode 			varchar2(5), 
activityDesc 			varchar2(40),
PRIMARY KEY(staffID, flightID),
FOREIGN KEY(staffID) REFERENCES PILOT(staffID),
FOREIGN KEY(flightID) REFERENCES FLIGHT(flightID)
);
 
CREATE TABLE HOSTING              (
staffID 				varchar2(5) not null, 
flightID 				char(9)   not null, 
PRIMARY KEY(staffID, flightID),
FOREIGN KEY(staffID) REFERENCES FLIGHT_ATTENDANT(staffID),
FOREIGN KEY(flightID) REFERENCES FLIGHT(flightID)
);

CREATE TABLE PILOT_QUALIFICATION  (
qualification 			varchar2(10) not null, 
staffID 				varchar2(5)  not null, 
PRIMARY KEY(qualification, staffID),
FOREIGN KEY(staffID) REFERENCES PILOT(staffID)
);

--modelID, 
--economySeats, 
--businessSeats, 
--firstClassSeats, 
--cargoCapacity,    --kg
--fuelCapacity, 	--L 
--planeLength, 		--cm
--wingspan, 		--cm
INSERT INTO MODEL VALUES ('Boeing 737-800' ,162 ,12		,NULL  	,18125	,26020	,4200 ,4880); 
INSERT INTO MODEL VALUES ('Boeing 747-8'   ,350 ,50		,10		,95000	,238610 ,7625 ,6840); 
INSERT INTO MODEL VALUES ('Boeing 747-400D',660 ,NULL 	,NULL 	,20125	,216840 ,7066 ,6444); 
INSERT INTO MODEL VALUES ('Boeing 787-8'   ,218 ,32		,NULL 	,46120	,126206 ,5672 ,6012); 
INSERT INTO MODEL VALUES ('Airbus A220'    ,108 ,NULL 	,4		,9650	,17630	,3870 ,3510); 


--airportCode, 
--country, 
--address, 
--phone,
INSERT INTO LOCATION VALUES ('LAX', 'USA'		, '1 World Way, Los Angeles, CA 90046, USA'				, '+18554635252'); 
INSERT INTO LOCATION VALUES ('NEX', 'New Endor'	, '20 Lonely Mountain Way, Erebor, ERB 2038, New Endor'	, '+4123456789'); 
INSERT INTO LOCATION VALUES ('NED', 'New Endor'	, '5 Weathertop Street, Eriador, ERD 2446, New Endor'	, '+4234567891'); 
INSERT INTO LOCATION VALUES ('MEL', 'AUS'		, 'Departure Drive, Melbourne, VIC 3045, AUS'			, '+61392971600'); 
INSERT INTO LOCATION VALUES ('LHR', 'UK'		, 'Longford TW6, UK'									, '+448443351801'); 


--routeID, 
--description, 
--arriveAirportCode, 
--departAirportCode,
INSERT INTO ROUTE VALUES ('R0001', 'Refer to navigation plan NE123', 'LAX', 'NEX'); 
INSERT INTO ROUTE VALUES ('R0002', 'Refer to navigation plan NE223', 'NEX', 'LHR');
INSERT INTO ROUTE VALUES ('R0003', 'Refer to navigation plan NE323', 'MEL', 'NED');
INSERT INTO ROUTE VALUES ('R0004', 'Refer to navigation plan NE423', 'NED', 'NED');
INSERT INTO ROUTE VALUES ('R0005', 'Refer to navigation plan NE523', 'LHR', 'NEX');
INSERT INTO ROUTE VALUES ('R0006', 'Refer to navigation plan NE623', 'NED', 'NEX');


--staffID, 
--name, 
--address, 
--email, 
--phone, 
--passportNum, 
INSERT INTO STAFF VALUES ('S0001', 'Evie Jude', 		'20 Kirp Street, Erebor, 2038, New Endor', 		'eviejude@gmail.com', 		 '+4933321531', '92814566');
INSERT INTO STAFF VALUES ('S0002', 'Jackson Jude',  	'20 Kirp Street, Erebor, 2038, New Endor', 		'jacksonjude@gmail.com', 	 '+4936321439', '93812289');
INSERT INTO STAFF VALUES ('S0003', 'Kaya Mahomed', 		'124 Vivid Lane, Fangorn, 2066, New Endor', 	'kayamahomed@gmail.com', 	 '+4934325536', '96855599');
INSERT INTO STAFF VALUES ('S0004', 'Thrain King', 		'14 Bree Road, Durin, 2045, New Endor', 		'thrainking@gmail.com', 	 '+4966329933', '99675599');
INSERT INTO STAFF VALUES ('S0005', 'Michael Sindarin', 	'37 Tenth Street, Durin, 2045, New Endor', 		'michaelsindarin@gmail.com', '+4914828967', '92450599');
INSERT INTO STAFF VALUES ('S0006', 'Rohan Anarion', 	'66 Ninth Street, Gondor, 2046, New Endor', 	'rohanamarion@gmail.com', 	 '+4912325689', '93607519');
INSERT INTO STAFF VALUES ('S0007', 'Susan Deep', 		'19 Hornburg Court, Gondor, 2046, New Endor', 	'susanhornburg@gmail.com', 	 '+4945613423', '90095782');
INSERT INTO STAFF VALUES ('S0008', 'Deepak Tran', 		'74 Valley Road, Isengard, 2236, New Endor', 	'deepaktran@gmail.com', 	 '+4983941250', '96755403');
INSERT INTO STAFF VALUES ('S0009', 'Maria Moria', 		'38 Alliance Way, Isengard, 2236, New Endor', 	'mariamoria@gmail.com', 	 '+4956642500', '95582304');
INSERT INTO STAFF VALUES ('S0010', 'Anna Anduin', 		'53 Black Road, Fangorn, 2066, New Endor', 		'annaanduin@gmail.com', 	 '+4959327465', '94002946');
INSERT INTO STAFF VALUES ('S0011', 'Heidi Hoon', 		'12 Bogus Valley, Fangorn 2066, New Endor', 	'hoon@gmail.com', 	         '+4967712888', '94123456');
INSERT INTO STAFF VALUES ('S0012', 'Zoe Wishwash', 		'53 Pointed Rock Rd, Fangorn, 2066, New Endor', 'wishywashy@gmail.com', 	 '+4952887736', '94234456');
INSERT INTO STAFF VALUES ('S0013', 'Bob Bobby Boom', 	'02 Warming Globe Ave, Durin, 2045, New Endor', 'boomboom@gmail.com', 	     '+4987139009', '91234565');
INSERT INTO STAFF VALUES ('S0014', 'Leeroy Jenkins', 	'42 Meaning Life St, Durin, 2045, New Endor',   'itis42@gmail.com', 	     '+4971237888', '91123445');

--staffID  
--prevHrsPilotExp 
INSERT INTO PILOT VALUES ('S0001', 4030);
INSERT INTO PILOT VALUES ('S0002', 3589);
INSERT INTO PILOT VALUES ('S0006', 2405);
INSERT INTO PILOT VALUES ('S0009', 5250);
INSERT INTO PILOT VALUES ('S0010', 7290);
INSERT INTO PILOT VALUES ('S0011', 1000);
INSERT INTO PILOT VALUES ('S0012', 1000);
INSERT INTO PILOT VALUES ('S0013', 1000);
INSERT INTO PILOT VALUES ('S0014', 4000);

--staffID
INSERT INTO FLIGHT_ATTENDANT VALUES ('S0003');
INSERT INTO FLIGHT_ATTENDANT VALUES ('S0004');
INSERT INTO FLIGHT_ATTENDANT VALUES ('S0005');
INSERT INTO FLIGHT_ATTENDANT VALUES ('S0006');
INSERT INTO FLIGHT_ATTENDANT VALUES ('S0007');
INSERT INTO FLIGHT_ATTENDANT VALUES ('S0008');
INSERT INTO FLIGHT_ATTENDANT VALUES ('S0011');
INSERT INTO FLIGHT_ATTENDANT VALUES ('S0012');
INSERT INTO FLIGHT_ATTENDANT VALUES ('S0013');
INSERT INTO FLIGHT_ATTENDANT VALUES ('S0014');

--aircraftID, 
--modelID, 
INSERT INTO AIRCRAFT VALUES ('A0001', 'Boeing 747-8');
INSERT INTO AIRCRAFT VALUES ('A0002', 'Boeing 737-800');
INSERT INTO AIRCRAFT VALUES ('A0003', 'Boeing 747-400D');
INSERT INTO AIRCRAFT VALUES ('A0004', 'Boeing 787-8');
INSERT INTO AIRCRAFT VALUES ('A0005', 'Airbus A220');
INSERT INTO AIRCRAFT VALUES ('A0006', 'Boeing 747-8');
INSERT INTO AIRCRAFT VALUES ('A0007', 'Airbus A220');

--customerID, 
--name, 
--address, 
--country, 
--email, 
--phone, 
--birthdate, 
--passportNum, 

INSERT INTO CUSTOMER VALUES ('C0001', 'Jonie Jones',   		'50 Lesson Lane, Erebor, New Endor', 	 				'New Endor', 	 			 'joniejones@hotmail.com',   	'+4958364765', to_date('12/05/1956', 'dd/mm/yyyy'), '92736401');
INSERT INTO CUSTOMER VALUES ('C0002', 'Sarah Delaney', 		'22 Time Drive, Arcadia, Gallifrey', 	 				'Gallifrey', 	 			 'sarahdelaney@memail.com', 	'+9283746198', to_date('14/02/1992', 'dd/mm/yyyy'), '83748917');
INSERT INTO CUSTOMER VALUES ('C0003', 'Mark Foster',   		'64 Bond Street, London, UK', 			 				'UK', 		 	 			 'markfoster@gmail.com',    	'+3748264763', to_date('30/12/1989', 'dd/mm/yyyy'), '32764920');
INSERT INTO CUSTOMER VALUES ('C0004', 'Patrick Jolie', 		'18 Park Road, Melbourne', 				 				'AUS', 		     			 'patrickjolie@hotmail.com', 	'+6334495820', to_date('05/05/1946', 'dd/mm/yyyy'), '35270848');
INSERT INTO CUSTOMER VALUES ('C0005', 'Nik Malema',    		'124 Tenth Street, Cape Town, South Africa',			'South Africa',  			 'nikmalema@hotmail.com', 		'+5783749100', to_date('17/06/1988', 'dd/mm/yyyy'), '98562538');
INSERT INTO CUSTOMER VALUES ('C0006', 'Yves de Wever', 		'43 Rue du Méandre, Brussels, Belgium', 				'Belgium', 		 			 'yvesdewever@hotmail.com',  	'+2931155006', to_date('08/11/1978', 'dd/mm/yyyy'), '64010028');
INSERT INTO CUSTOMER VALUES ('C0007', 'Elizabeth Spencer',  '14th Street NW, Washington DC, USA', 					'USA', 						 'elispencer@hotmail.com',   	'+1299388003', to_date('03/07/1969', 'dd/mm/yyyy'), '90012861');
INSERT INTO CUSTOMER VALUES ('C0008', 'Boris Gorbachev', 	'9 Druzhby Street, Moscow, Russia', 					'Russia', 					 'borisgorb@hotmail.com', 	    '+4908665341', to_date('24/09/1976', 'dd/mm/yyyy'), '74610863');
INSERT INTO CUSTOMER VALUES ('C0009', 'Hu Xiaoping', 		'12 Jianguo Road, Beijing, China', 						'China', 		 			 'huxiaoping@gmail.com', 		'+7750926450', to_date('28/04/1996', 'dd/mm/yyyy'), '10226419');
INSERT INTO CUSTOMER VALUES ('C0010', 'Jomo Biwott', 		'39 Kenyatta Avenue, Nairobi, Kenya', 					'Kenya', 		  			 'jomobiwott@kmail.com', 		'+8766001962', to_date('07/12/1982', 'dd/mm/yyyy'), '28801746');
INSERT INTO CUSTOMER VALUES ('C0011', 'Mahmoud Saikal', 	'12 October Street, Kabul, Afghanistan', 				'Afghanistan', 	 			 'msaikal@gmail.com', 			'+1298460019', to_date('30/10/1972', 'dd/mm/yyyy'), '76510026');
INSERT INTO CUSTOMER VALUES ('C0012', 'Besiana Kadare', 	'129 November Avenue, Tirana, Albania', 				'Albania', 		 			 'bkadare@gmail.com', 			'+8944761909', to_date('27/02/1986', 'dd/mm/yyyy'), '48891762');
INSERT INTO CUSTOMER VALUES ('C0013', 'Sabri Boukadoum', 	'96 December Road, Algiers, Algeria', 					'Algeria', 					 'sbouk@gmail.com', 			'+9875510987', to_date('24/12/1939', 'dd/mm/yyyy'), '90086248');
INSERT INTO CUSTOMER VALUES ('C0014', 'Maria del Jesus', 	'20 January Street, Luanda, Angola', 					'Angola', 		 			 'mjesus@gmail.com', 			'+4388096418', to_date('07/11/1987', 'dd/mm/yyyy'), '29864771');
INSERT INTO CUSTOMER VALUES ('C0015', 'Walton Webson', 		'33 Feburary Avenue, St Johns, Antigua and Barbuda', 	'Antigua and Barbuda', 		 'wwebson@gmail.com', 			'+2897710988', to_date('29/06/1982', 'dd/mm/yyyy'), '32855009');
INSERT INTO CUSTOMER VALUES ('C0016', 'Martin Garcia', 		'6 March Way, Buenos Aires, Argentina', 				'Argentina', 		 		 'mgarcia@gmail.com', 			'+8689430112', to_date('16/12/1990', 'dd/mm/yyyy'), '45983710');
INSERT INTO CUSTOMER VALUES ('C0017', 'Mher Margaryan', 	'3 April Avenue, Yerevan, Armenia', 					'Armenia', 		 			 'mher@gmail.com', 				'+6488209811', to_date('13/07/1992', 'dd/mm/yyyy'), '73918600');
INSERT INTO CUSTOMER VALUES ('C0018', 'Gillian Bird', 		'1 May Street, Victoria, Australia', 					'Australia', 		 		 'gbird@gmail.com', 			'+9332871690', to_date('02/02/2002', 'dd/mm/yyyy'), '98276140');
INSERT INTO CUSTOMER VALUES ('C0019', 'Jan Kickert', 		'9 June Road, Vienna, Austria', 						'Austria', 		 			 'jank@gmail.com', 				'+1200987789', to_date('08/03/2000', 'dd/mm/yyyy'), '90008197');
INSERT INTO CUSTOMER VALUES ('C0020', 'Yashar Aliyev', 		'40 July Way, Baku, Azerbaijan', 						'Azerbaijan', 		 		 'yashar@gmail.com', 			'+9762891890', to_date('18/05/1998', 'dd/mm/yyyy'), '98007167');
INSERT INTO CUSTOMER VALUES ('C0021', 'Sheila Carey', 		'8 August Avenue, Nassau, The Bahamas', 				'The Bahamas', 		 		 'shiela@bmail.com', 			'+4098971102', to_date('23/07/1962', 'dd/mm/yyyy'), '81230120');
INSERT INTO CUSTOMER VALUES ('C0022', 'Jamal Alrowaiei', 	'3 September Drive, Manama, Bahrain', 					'Bahrain', 		 			 'jamal@gmail.com', 			'+6671909092', to_date('17/08/1999', 'dd/mm/yyyy'), '12298751');
INSERT INTO CUSTOMER VALUES ('C0023', 'Masud Bin Momen', 	'9 Mile Avenue, Dhaka, Bangladesh', 					'Bangladesh', 		 		 'bin@gmail.com', 				'+9127245641', to_date('09/12/1970', 'dd/mm/yyyy'), '77654001');
INSERT INTO CUSTOMER VALUES ('C0024', 'Henrietta Thompson', '77 Henry Street, Bridgetown, Barbados', 				'Barbados', 		 		 'hen@email.com', 				'+3309807980', to_date('01/04/1989', 'dd/mm/yyyy'), '11980009');
INSERT INTO CUSTOMER VALUES ('C0025', 'Valentin Rybakov', 	'60 George Street, Minsk, Belarus', 					'Belarus', 		 			 'vry@gmail.com', 				'+9008798161', to_date('22/10/1979', 'dd/mm/yyyy'), '90085323');
INSERT INTO CUSTOMER VALUES ('C0026', 'Marc de Buytswerve', '47 Lux Avenue, Brussels, Belgium', 					'Belgium', 		 			 'marcb@gmail.com', 			'+7888609811', to_date('01/12/1982', 'dd/mm/yyyy'), '29001784');
INSERT INTO CUSTOMER VALUES ('C0027', 'Lois Young', 		'10 Bell Street, Belmopan, Belize', 					'Belize', 		 			 'lyoung@gmail.com', 			'+8009861236', to_date('07/02/1992', 'dd/mm/yyyy'), '31012735');
INSERT INTO CUSTOMER VALUES ('C0028', 'Jean-Claude Felix', 	'52 Ocean Road,Porto-Novo, Benin', 						'Benin', 		 			 'jeanc@email.com', 			'+9876162200', to_date('22/05/1977', 'dd/mm/yyyy'), '40097729');
INSERT INTO CUSTOMER VALUES ('C0029', 'Doma Tshering', 		'9 East Avenue, Thimphu, Bhutan', 						'Bhutan', 					 'domat@gmail.com', 			'+8119725541', to_date('06/11/1982', 'dd/mm/yyyy'), '49816500');
INSERT INTO CUSTOMER VALUES ('C0030', 'Sacha Soliz', 		'68 Estado Way, Sucre, Bolivia', 						'Bolivia', 		 			 'ssoliz@kmail.com', 			'+1239876462', to_date('07/12/1982', 'dd/mm/yyyy'), '99871236');


--flightID, 
--estDepartureDateTime, 
--actDepartDateTime, 
--actArriveDateTime, 
--avgSpeed,
--avgHeight,
--estDuration,
--estFuel,
--captainStaffID, 
--firstOfficerStaffID, 
--routeID
--aircraftID
INSERT INTO FLIGHT VALUES ('000000001', to_date('03/11/2023 13:20:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('03/11/2023 13:25:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('03/11/2023 16:25:00', 'dd/mm/yyyy hh24:mi:ss'), 885, 28000, 180, 15050, 'S0001', 'S0002', 'R0006', 'A0002');
INSERT INTO FLIGHT VALUES ('000000002', to_date('06/10/2022 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('06/10/2022 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('06/10/2022 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000003', to_date('08/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('08/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('08/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0001', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000004', to_date('10/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('10/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('10/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000005', to_date('12/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('12/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('12/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0002', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000006', to_date('14/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('14/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('14/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000007', to_date('16/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('16/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('16/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0002', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000008', to_date('18/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('18/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('18/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0001', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000009', to_date('20/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('20/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('20/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000010', to_date('22/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('22/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('22/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000011', to_date('24/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('24/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('24/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0001', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000012', to_date('26/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('26/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('26/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0002', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000013', to_date('28/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('28/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('28/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000014', to_date('30/10/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('30/10/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('30/10/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000015', to_date('06/11/2022 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('06/11/2022 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('06/11/2022 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000016', to_date('08/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('08/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('08/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0001', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000017', to_date('10/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('10/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('10/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000018', to_date('12/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('12/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('12/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0002', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000019', to_date('14/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('14/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('14/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000020', to_date('16/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('16/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('16/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0002', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000021', to_date('18/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('18/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('18/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0001', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000022', to_date('20/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('20/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('20/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000023', to_date('22/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('22/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('22/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000024', to_date('24/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('24/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('24/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0001', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000025', to_date('26/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('26/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('26/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0002', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000026', to_date('28/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('28/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('28/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000027', to_date('30/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('30/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('30/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000028', to_date('24/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('24/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('24/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0001', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000029', to_date('26/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('26/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('26/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0002', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000030', to_date('28/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('28/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('28/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000031', to_date('30/11/2023 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('30/11/2023 00:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('30/11/2023 12:30:00', 'dd/mm/yyyy hh24:mi:ss'), 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000032', to_date('01/12/2023 12:10:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('01/12/2023 12:15:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('01/12/2023 18:15:00', 'dd/mm/yyyy hh24:mi:ss'), 800, 27000, 360, 19850, 'S0001', 'S0002', 'R0002', 'A0003');
INSERT INTO FLIGHT VALUES ('000000033', to_date('03/12/2023 01:00:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('03/12/2023 01:00:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('03/12/2023 09:00:00', 'dd/mm/yyyy hh24:mi:ss'), 830, 28000, 480, 21950, 'S0001', 'S0002', 'R0005', 'A0004');
INSERT INTO FLIGHT VALUES ('000000034', to_date('05/12/2023 06:10:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('05/12/2023 06:15:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('05/12/2023 07:15:00', 'dd/mm/yyyy hh24:mi:ss'), 885, 30000, 60 , 12050, 'S0001', 'S0002', 'R0004', 'A0005');
INSERT INTO FLIGHT VALUES ('000000035', to_date('07/12/2023 11:40:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('07/12/2023 11:45:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('07/12/2023 18:45:00', 'dd/mm/yyyy hh24:mi:ss'), 880, 28000, 420, 19400, 'S0001', 'S0002', 'R0005', 'A0006');
INSERT INTO FLIGHT VALUES ('000000036', to_date('09/12/2023 10:20:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('09/12/2023 10:25:00', 'dd/mm/yyyy hh24:mi:ss'), to_date('09/12/2023 13:25:00', 'dd/mm/yyyy hh24:mi:ss'), 820, 27000, 180, 15050, 'S0001', 'S0002', 'R0003', 'A0005');
INSERT INTO FLIGHT VALUES ('000000037', to_date('09/12/2025 10:20:00', 'dd/mm/yyyy hh24:mi:ss'), NULL, NULL, 820, 27000, 180, 15050, 'S0001', 'S0002', 'R0003', 'A0005');
INSERT INTO FLIGHT VALUES ('000000038', to_date('01/01/2025 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), NULL, NULL, 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000039', to_date('05/01/2025 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), NULL, NULL, 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000040', to_date('08/01/2025 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), NULL, NULL, 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000041', to_date('11/01/2025 00:30:00', 'dd/mm/yyyy hh24:mi:ss'), NULL, NULL, 890, 29000, 720, 20050, 'S0009', 'S0010', 'R0002', 'A0001');
INSERT INTO FLIGHT VALUES ('000000042', to_date('01/01/2025 11:40:00', 'dd/mm/yyyy hh24:mi:ss'), NULL, NULL, 880, 28000, 420, 19400, 'S0001', 'S0002', 'R0005', 'A0006');

--ticketNum, 
--luggageLimit,
--seatNum, 
--classCode, 
--medicalCondition, 
--mealChoice, 
--customerID, 
--flightID,
INSERT INTO TICKET VALUES ('T0001', 20, 001, 'E', 'Diabetes',    'ST', 'C0001', '000000001');
INSERT INTO TICKET VALUES ('T0002', 20, 001, 'F', NULL,          'ST', 'C0002', '000000002');
INSERT INTO TICKET VALUES ('T0003', 20, 001, 'E', NULL,          'ST', 'C0003', '000000003');
INSERT INTO TICKET VALUES ('T0004', 20, 001, 'E', NULL,          'ST', 'C0004', '000000004');
INSERT INTO TICKET VALUES ('T0005', 20, 001, 'F', 'Nut allergy', 'ST', 'C0005', '000000005');
INSERT INTO TICKET VALUES ('T0006', 20, 001, 'E', NULL,          'ST', 'C0006', '000000006');
INSERT INTO TICKET VALUES ('T0007', 20, 001, 'E', NULL,          'ST', 'C0007', '000000007');
INSERT INTO TICKET VALUES ('T0008', 20, 001, 'E', NULL,          'VG', 'C0008', '000000008');
INSERT INTO TICKET VALUES ('T0009', 20, 001, 'E', NULL,          'ST', 'C0009', '000000009');
INSERT INTO TICKET VALUES ('T0010', 20, 001, 'E', 'Epilepsy',    'ST', 'C0010', '000000010');
INSERT INTO TICKET VALUES ('T0011', 20, 001, 'E', NULL,          'VG', 'C0011', '000000011');
INSERT INTO TICKET VALUES ('T0012', 20, 001, 'E', NULL,          'ST', 'C0012', '000000012');
INSERT INTO TICKET VALUES ('T0014', 20, 001, 'E', NULL,          'ST', 'C0014', '000000014');
INSERT INTO TICKET VALUES ('T0015', 20, 001, 'E', NULL,          'ST', 'C0015', '000000015');
INSERT INTO TICKET VALUES ('T0016', 20, 001, 'B', NULL,          'VG', 'C0016', '000000016');
INSERT INTO TICKET VALUES ('T0017', 20, 001, 'E', NULL,          'VG', 'C0017', '000000017');
INSERT INTO TICKET VALUES ('T0018', 20, 001, 'B', NULL,          'ST', 'C0018', '000000018');
INSERT INTO TICKET VALUES ('T0019', 20, 001, 'E', NULL,          'ST', 'C0019', '000000019');
INSERT INTO TICKET VALUES ('T0020', 20, 001, 'E', 'Asthma',      'VG', 'C0020', '000000031');
INSERT INTO TICKET VALUES ('T0021', 20, 001, 'B', NULL,          'ST', 'C0021', '000000032'); 
INSERT INTO TICKET VALUES ('T0022', 20, 001, 'E', NULL,          'ST', 'C0022', '000000033');
INSERT INTO TICKET VALUES ('T0024', 20, 001, 'B', 'Hemophilia',  'VG', 'C0024', '000000035');
INSERT INTO TICKET VALUES ('T0025', 20, 001, 'B', NULL,          'ST', 'C0025', '000000036');
INSERT INTO TICKET VALUES ('T0026', 20, 002, 'E', NULL,          'ST', 'C0026', '000000001');
INSERT INTO TICKET VALUES ('T0027', 20, 002, 'E', NULL,          'ST', 'C0027', '000000002');
INSERT INTO TICKET VALUES ('T0028', 20, 002, 'F', NULL,          'ST', 'C0028', '000000003');
INSERT INTO TICKET VALUES ('T0029', 20, 002, 'F', NULL,          'ST', 'C0029', '000000004');
INSERT INTO TICKET VALUES ('T0030', 20, 002, 'E', NULL,          'ST', 'C0030', '000000005');
INSERT INTO TICKET VALUES ('T0031', 20, 002, 'E', 'Diabetes',    'ST', 'C0001', '000000006');
INSERT INTO TICKET VALUES ('T0032', 20, 002, 'F', NULL,          'ST', 'C0002', '000000007');
INSERT INTO TICKET VALUES ('T0033', 20, 002, 'E', NULL,          'VG', 'C0003', '000000008');
INSERT INTO TICKET VALUES ('T0034', 20, 002, 'E', NULL,          'ST', 'C0004', '000000009');
INSERT INTO TICKET VALUES ('T0035', 20, 002, 'F', 'Nut allergy', 'ST', 'C0005', '000000010');
INSERT INTO TICKET VALUES ('T0036', 20, 002, 'E', NULL,          'VG', 'C0006', '000000011');
INSERT INTO TICKET VALUES ('T0037', 20, 002, 'E', NULL,          'ST', 'C0007', '000000012');
INSERT INTO TICKET VALUES ('T0038', 20, 002, 'E', NULL,          'ST', 'C0008', '000000013');
INSERT INTO TICKET VALUES ('T0039', 20, 002, 'E', NULL,          'ST', 'C0009', '000000014');
INSERT INTO TICKET VALUES ('T0040', 20, 002, 'E', 'Epilepsy',    'ST', 'C0010', '000000015');
INSERT INTO TICKET VALUES ('T0041', 20, 002, 'B', NULL,          'VG', 'C0011', '000000016');
INSERT INTO TICKET VALUES ('T0042', 20, 002, 'E', NULL,          'VG', 'C0012', '000000017');
INSERT INTO TICKET VALUES ('T0044', 20, 002, 'E', NULL,          'ST', 'C0014', '000000019');
INSERT INTO TICKET VALUES ('T0045', 20, 002, 'E', NULL,          'VG', 'C0015', '000000031');
INSERT INTO TICKET VALUES ('T0046', 20, 002, 'B', NULL,          'ST', 'C0016', '000000032'); 
INSERT INTO TICKET VALUES ('T0047', 20, 002, 'E', NULL,          'ST', 'C0017', '000000033');
INSERT INTO TICKET VALUES ('T0049', 20, 002, 'B', NULL,          'VG', 'C0019', '000000035');
INSERT INTO TICKET VALUES ('T0050', 20, 002, 'B', 'Asthma',      'ST', 'C0020', '000000036');
INSERT INTO TICKET VALUES ('T0051', 20, 003, 'E', NULL,          'ST', 'C0021', '000000001');
INSERT INTO TICKET VALUES ('T0052', 20, 003, 'E', NULL,          'ST', 'C0022', '000000002');
INSERT INTO TICKET VALUES ('T0053', 20, 003, 'F', NULL,          'ST', 'C0023', '000000003');
INSERT INTO TICKET VALUES ('T0054', 20, 003, 'F', 'Hemophilia',  'ST', 'C0024', '000000004');
INSERT INTO TICKET VALUES ('T0055', 20, 003, 'E', NULL,          'ST', 'C0025', '000000005');
INSERT INTO TICKET VALUES ('T0056', 20, 003, 'E', NULL,          'ST', 'C0026', '000000006');
INSERT INTO TICKET VALUES ('T0057', 20, 003, 'E', NULL,          'ST', 'C0027', '000000007');
INSERT INTO TICKET VALUES ('T0058', 20, 003, 'E', NULL,          'VG', 'C0028', '000000008');
INSERT INTO TICKET VALUES ('T0059', 20, 003, 'E', NULL,          'ST', 'C0029', '000000009');
INSERT INTO TICKET VALUES ('T0060', 20, 003, 'E', NULL,          'ST', 'C0030', '000000010');
INSERT INTO TICKET VALUES ('T0061', 20, 003, 'E', 'Diabetes',    'VG', 'C0001', '000000011');
INSERT INTO TICKET VALUES ('T0062', 20, 003, 'F', NULL,          'ST', 'C0002', '000000012');
INSERT INTO TICKET VALUES ('T0063', 20, 003, 'E', NULL,          'ST', 'C0003', '000000013');
INSERT INTO TICKET VALUES ('T0064', 20, 003, 'E', NULL,          'ST', 'C0004', '000000014');
INSERT INTO TICKET VALUES ('T0065', 20, 003, 'F', 'Nut allergy', 'ST', 'C0005', '000000015');
INSERT INTO TICKET VALUES ('T0066', 20, 003, 'B', NULL,          'VG', 'C0006', '000000016');
INSERT INTO TICKET VALUES ('T0067', 20, 003, 'E', NULL,          'VG', 'C0007', '000000017');
INSERT INTO TICKET VALUES ('T0068', 20, 003, 'B', NULL,          'ST', 'C0008', '000000018');
INSERT INTO TICKET VALUES ('T0069', 20, 003, 'E', NULL,          'ST', 'C0009', '000000019');
INSERT INTO TICKET VALUES ('T0070', 20, 003, 'E', 'Epilepsy',    'VG', 'C0010', '000000031');
INSERT INTO TICKET VALUES ('T0071', 20, 003, 'B', NULL,          'ST', 'C0011', '000000032'); 
INSERT INTO TICKET VALUES ('T0072', 20, 003, 'E', NULL,          'ST', 'C0012', '000000033');
INSERT INTO TICKET VALUES ('T0074', 20, 003, 'B', NULL,          'VG', 'C0014', '000000035');
INSERT INTO TICKET VALUES ('T0075', 20, 003, 'B', NULL,          'ST', 'C0015', '000000036');
INSERT INTO TICKET VALUES ('T0076', 20, 004, 'E', NULL,          'ST', 'C0016', '000000001');
INSERT INTO TICKET VALUES ('T0077', 20, 004, 'E', NULL,          'ST', 'C0017', '000000002');
INSERT INTO TICKET VALUES ('T0078', 20, 004, 'F', NULL,          'ST', 'C0018', '000000003');
INSERT INTO TICKET VALUES ('T0079', 20, 004, 'F', NULL,          'ST', 'C0019', '000000004');
INSERT INTO TICKET VALUES ('T0080', 20, 004, 'E', 'Asthma',      'ST', 'C0020', '000000005');
INSERT INTO TICKET VALUES ('T0081', 20, 004, 'E', NULL,          'ST', 'C0021', '000000006');
INSERT INTO TICKET VALUES ('T0082', 20, 004, 'E', NULL,          'ST', 'C0022', '000000007');
INSERT INTO TICKET VALUES ('T0083', 20, 004, 'E', NULL,          'VG', 'C0023', '000000008');
INSERT INTO TICKET VALUES ('T0084', 20, 004, 'E', 'Hemophilia',  'ST', 'C0024', '000000009');
INSERT INTO TICKET VALUES ('T0085', 20, 004, 'E', NULL,          'ST', 'C0025', '000000010');
INSERT INTO TICKET VALUES ('T0086', 20, 004, 'E', NULL,          'VG', 'C0026', '000000011');
INSERT INTO TICKET VALUES ('T0087', 20, 004, 'E', NULL,          'ST', 'C0027', '000000012');
INSERT INTO TICKET VALUES ('T0088', 20, 004, 'E', NULL,          'ST', 'C0028', '000000013');
INSERT INTO TICKET VALUES ('T0089', 20, 004, 'E', NULL,          'ST', 'C0029', '000000014');
INSERT INTO TICKET VALUES ('T0090', 20, 004, 'E', NULL,          'ST', 'C0030', '000000015');
INSERT INTO TICKET VALUES ('T0091', 20, 004, 'B', 'Diabetes',    'VG', 'C0001', '000000016');
INSERT INTO TICKET VALUES ('T0092', 20, 004, 'F', NULL,          'VG', 'C0002', '000000017');
INSERT INTO TICKET VALUES ('T0093', 20, 004, 'B', NULL,          'ST', 'C0003', '000000018');
INSERT INTO TICKET VALUES ('T0094', 20, 004, 'E', NULL,          'ST', 'C0004', '000000019');
INSERT INTO TICKET VALUES ('T0095', 20, 004, 'F', 'Nut allergy', 'VG', 'C0005', '000000031');
INSERT INTO TICKET VALUES ('T0096', 20, 004, 'B', NULL,          'ST', 'C0006', '000000032'); 
INSERT INTO TICKET VALUES ('T0097', 20, 004, 'E', NULL,          'ST', 'C0007', '000000033');
INSERT INTO TICKET VALUES ('T0099', 20, 004, 'B', NULL,          'VG', 'C0009', '000000035');
INSERT INTO TICKET VALUES ('T0100', 20, 004, 'B', 'Epilepsy',    'ST', 'C0010', '000000036');
INSERT INTO TICKET VALUES ('T0101', 20, 005, 'E', NULL,          'ST', 'C0011', '000000001');
INSERT INTO TICKET VALUES ('T0102', 20, 005, 'E', NULL,          'ST', 'C0012', '000000002');
INSERT INTO TICKET VALUES ('T0104', 20, 005, 'F', NULL,          'ST', 'C0014', '000000004');
INSERT INTO TICKET VALUES ('T0105', 20, 005, 'E', NULL,          'ST', 'C0015', '000000005');
INSERT INTO TICKET VALUES ('T0106', 20, 005, 'E', NULL,          'ST', 'C0016', '000000006');
INSERT INTO TICKET VALUES ('T0107', 20, 005, 'E', NULL,          'ST', 'C0017', '000000007');
INSERT INTO TICKET VALUES ('T0108', 20, 005, 'E', NULL,          'VG', 'C0018', '000000008');
INSERT INTO TICKET VALUES ('T0109', 20, 005, 'E', NULL,          'ST', 'C0019', '000000009');
INSERT INTO TICKET VALUES ('T0110', 20, 005, 'E', 'Asthma',      'ST', 'C0020', '000000010');
INSERT INTO TICKET VALUES ('T0111', 20, 005, 'E', NULL,          'VG', 'C0021', '000000011');
INSERT INTO TICKET VALUES ('T0112', 20, 005, 'E', NULL,          'ST', 'C0022', '000000012');
INSERT INTO TICKET VALUES ('T0113', 20, 005, 'E', NULL,          'ST', 'C0023', '000000013');
INSERT INTO TICKET VALUES ('T0114', 20, 005, 'E', 'Hemophilia',  'ST', 'C0024', '000000014');
INSERT INTO TICKET VALUES ('T0115', 20, 005, 'E', NULL,          'ST', 'C0025', '000000015');
INSERT INTO TICKET VALUES ('T0116', 20, 005, 'B', NULL,          'VG', 'C0026', '000000016');
INSERT INTO TICKET VALUES ('T0117', 20, 005, 'E', NULL,          'VG', 'C0027', '000000017');
INSERT INTO TICKET VALUES ('T0118', 20, 005, 'B', NULL,          'ST', 'C0028', '000000018');
INSERT INTO TICKET VALUES ('T0119', 20, 005, 'E', NULL,          'ST', 'C0029', '000000019');
INSERT INTO TICKET VALUES ('T0120', 20, 005, 'E', NULL,          'VG', 'C0030', '000000031');
INSERT INTO TICKET VALUES ('T0121', 20, 005, 'B', 'Diabetes',    'ST', 'C0001', '000000032'); 
INSERT INTO TICKET VALUES ('T0122', 20, 005, 'F', NULL,          'ST', 'C0002', '000000033');
INSERT INTO TICKET VALUES ('T0124', 25, 005, 'B', NULL,          'VG', 'C0004', '000000035');
INSERT INTO TICKET VALUES ('T0125', 25, 005, 'F', 'Nut allergy', 'ST', 'C0005', '000000036');
INSERT INTO TICKET VALUES ('T0126', 25, 006, 'E', NULL,          'ST', 'C0006', '000000001');
INSERT INTO TICKET VALUES ('T0127', 25, 006, 'E', NULL,          'ST', 'C0007', '000000002');
INSERT INTO TICKET VALUES ('T0128', 25, 006, 'F', NULL,          'ST', 'C0008', '000000003');
INSERT INTO TICKET VALUES ('T0129', 25, 006, 'F', NULL,          'ST', 'C0009', '000000004');
INSERT INTO TICKET VALUES ('T0130', 25, 006, 'E', 'Epilepsy',    'ST', 'C0010', '000000005');
INSERT INTO TICKET VALUES ('T0131', 25, 006, 'E', NULL,          'ST', 'C0011', '000000006');
INSERT INTO TICKET VALUES ('T0132', 25, 006, 'E', NULL,          'ST', 'C0012', '000000007');
INSERT INTO TICKET VALUES ('T0134', 25, 006, 'E', NULL,          'ST', 'C0014', '000000009');
INSERT INTO TICKET VALUES ('T0135', 25, 006, 'E', NULL,          'ST', 'C0015', '000000010');
INSERT INTO TICKET VALUES ('T0136', 25, 006, 'E', NULL,          'VG', 'C0016', '000000011');
INSERT INTO TICKET VALUES ('T0137', 20, 006, 'E', NULL,          'ST', 'C0017', '000000012');
INSERT INTO TICKET VALUES ('T0138', 20, 006, 'E', NULL,          'ST', 'C0018', '000000013');
INSERT INTO TICKET VALUES ('T0139', 20, 006, 'E', NULL,          'ST', 'C0019', '000000014');
INSERT INTO TICKET VALUES ('T0140', 20, 006, 'E', 'Asthma',      'ST', 'C0020', '000000015');
INSERT INTO TICKET VALUES ('T0141', 20, 006, 'B', NULL,          'VG', 'C0021', '000000016');
INSERT INTO TICKET VALUES ('T0142', 20, 006, 'E', NULL,          'VG', 'C0022', '000000017');
INSERT INTO TICKET VALUES ('T0143', 20, 006, 'B', NULL,          'ST', 'C0023', '000000018');
INSERT INTO TICKET VALUES ('T0144', 20, 006, 'E', 'Hemophilia',  'ST', 'C0024', '000000019');
INSERT INTO TICKET VALUES ('T0145', 20, 006, 'E', NULL,          'VG', 'C0025', '000000031');
INSERT INTO TICKET VALUES ('T0146', 30, 006, 'B', NULL,          'ST', 'C0026', '000000032'); 
INSERT INTO TICKET VALUES ('T0147', 30, 006, 'E', NULL,          'ST', 'C0027', '000000033');
INSERT INTO TICKET VALUES ('T0149', 30, 006, 'B', NULL,          'VG', 'C0029', '000000035');
INSERT INTO TICKET VALUES ('T0150', 30, 006, 'B', NULL,          'ST', 'C0030', '000000036');
INSERT INTO TICKET VALUES ('T0151', 30, 007, 'E', NULL,          'ST', 'C0007', '000000001');
INSERT INTO TICKET VALUES ('T0152', 30, 007, 'E', NULL,          'ST', 'C0008', '000000002');
INSERT INTO TICKET VALUES ('T0153', 30, 007, 'F', NULL,          'ST', 'C0009', '000000003');
INSERT INTO TICKET VALUES ('T0154', 30, 007, 'F', 'Epilepsy',    'ST', 'C0010', '000000004');
INSERT INTO TICKET VALUES ('T0155', 30, 007, 'E', NULL,          'ST', 'C0011', '000000005');
INSERT INTO TICKET VALUES ('T0156', 30, 007, 'E', NULL,          'ST', 'C0012', '000000006');
INSERT INTO TICKET VALUES ('T0158', 20, 007, 'E', NULL,          'VG', 'C0014', '000000008');
INSERT INTO TICKET VALUES ('T0159', 20, 007, 'E', NULL,          'ST', 'C0015', '000000009');
INSERT INTO TICKET VALUES ('T0160', 20, 007, 'E', NULL,          'ST', 'C0016', '000000010');
INSERT INTO TICKET VALUES ('T0161', 20, 007, 'E', NULL,          'VG', 'C0017', '000000011');
INSERT INTO TICKET VALUES ('T0162', 20, 007, 'E', NULL,          'ST', 'C0018', '000000012');
INSERT INTO TICKET VALUES ('T0163', 20, 007, 'E', NULL,          'ST', 'C0019', '000000013');
INSERT INTO TICKET VALUES ('T0164', 20, 007, 'E', 'Asthma',      'ST', 'C0020', '000000014');
INSERT INTO TICKET VALUES ('T0165', 40, 007, 'E', NULL,          'ST', 'C0021', '000000015');
INSERT INTO TICKET VALUES ('T0166', 40, 007, 'B', NULL,          'VG', 'C0022', '000000016');
INSERT INTO TICKET VALUES ('T0167', 40, 007, 'E', NULL,          'VG', 'C0023', '000000017');
INSERT INTO TICKET VALUES ('T0168', 40, 007, 'B', 'Acrophobia',  'ST', 'C0024', '000000018');
INSERT INTO TICKET VALUES ('T0169', 40, 007, 'E', NULL,          'ST', 'C0025', '000000019');
INSERT INTO TICKET VALUES ('T0170', 40, 007, 'E', NULL,          'VG', 'C0026', '000000031');
INSERT INTO TICKET VALUES ('T0171', 40, 007, 'B', NULL,          'ST', 'C0027', '000000032'); 
INSERT INTO TICKET VALUES ('T0172', 40, 007, 'E', NULL,          'ST', 'C0028', '000000033');
INSERT INTO TICKET VALUES ('T0174', 40, 007, 'B', NULL,          'VG', 'C0030', '000000035');
INSERT INTO TICKET VALUES ('T0175', 40, 007, 'B', 'Diabetes',    'ST', 'C0001', '000000036');
INSERT INTO TICKET VALUES ('T0176', 40, 008, 'F', NULL,          'ST', 'C0002', '000000001');
INSERT INTO TICKET VALUES ('T0177', 40, 008, 'E', NULL,          'ST', 'C0003', '000000002');
INSERT INTO TICKET VALUES ('T0178', 40, 008, 'F', NULL,          'ST', 'C0004', '000000003');
INSERT INTO TICKET VALUES ('T0179', 20, 008, 'F', 'Nut allergy', 'ST', 'C0005', '000000004');
INSERT INTO TICKET VALUES ('T0180', 20, 008, 'E', NULL,          'ST', 'C0006', '000000005');
INSERT INTO TICKET VALUES ('T0181', 20, 008, 'E', NULL,          'ST', 'C0007', '000000006');
INSERT INTO TICKET VALUES ('T0182', 20, 008, 'E', NULL,          'ST', 'C0008', '000000007');
INSERT INTO TICKET VALUES ('T0183', 20, 008, 'E', NULL,          'VG', 'C0009', '000000008');
INSERT INTO TICKET VALUES ('T0184', 20, 008, 'E', 'Epilepsy',    'ST', 'C0010', '000000009');
INSERT INTO TICKET VALUES ('T0185', 20, 008, 'E', NULL,          'ST', 'C0011', '000000010');
INSERT INTO TICKET VALUES ('T0186', 20, 008, 'E', NULL,          'VG', 'C0012', '000000011');
INSERT INTO TICKET VALUES ('T0188', 25, 008, 'E', NULL,          'ST', 'C0014', '000000013');
INSERT INTO TICKET VALUES ('T0189', 25, 008, 'E', NULL,          'ST', 'C0015', '000000014');
INSERT INTO TICKET VALUES ('T0190', 25, 008, 'E', NULL,          'ST', 'C0016', '000000015');
INSERT INTO TICKET VALUES ('T0191', 25, 008, 'B', NULL,          'VG', 'C0017', '000000016');
INSERT INTO TICKET VALUES ('T0192', 25, 008, 'E', NULL,          'VG', 'C0018', '000000017');
INSERT INTO TICKET VALUES ('T0193', 25, 008, 'B', NULL,          'ST', 'C0019', '000000018');
INSERT INTO TICKET VALUES ('T0194', 25, 008, 'E', 'Asthma',      'ST', 'C0020', '000000019');
INSERT INTO TICKET VALUES ('T0195', 25, 008, 'E', NULL,          'VG', 'C0021', '000000031');
INSERT INTO TICKET VALUES ('T0196', 25, 008, 'B', NULL,          'ST', 'C0022', '000000032'); 
INSERT INTO TICKET VALUES ('T0197', 25, 008, 'E', NULL,          'ST', 'C0023', '000000033');
INSERT INTO TICKET VALUES ('T0199', 25, 008, 'B', NULL,          'VG', 'C0025', '000000035');
INSERT INTO TICKET VALUES ('T0200', 25, 008, 'B', NULL,          'ST', 'C0026', '000000036');
INSERT INTO TICKET VALUES ('T0201', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000002');
INSERT INTO TICKET VALUES ('T0202', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000003');
INSERT INTO TICKET VALUES ('T0203', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000004');
INSERT INTO TICKET VALUES ('T0204', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000005');
INSERT INTO TICKET VALUES ('T0205', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000006');
INSERT INTO TICKET VALUES ('T0206', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000007');
INSERT INTO TICKET VALUES ('T0207', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000008');
INSERT INTO TICKET VALUES ('T0208', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000009');
INSERT INTO TICKET VALUES ('T0209', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000010');
INSERT INTO TICKET VALUES ('T0210', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000011');
INSERT INTO TICKET VALUES ('T0211', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000012');
INSERT INTO TICKET VALUES ('T0212', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000013');
INSERT INTO TICKET VALUES ('T0213', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000014');
INSERT INTO TICKET VALUES ('T0214', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000015');
INSERT INTO TICKET VALUES ('T0215', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000016');
INSERT INTO TICKET VALUES ('T0216', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000017');
INSERT INTO TICKET VALUES ('T0217', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000018');
INSERT INTO TICKET VALUES ('T0218', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000019');
INSERT INTO TICKET VALUES ('T0219', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000020');
INSERT INTO TICKET VALUES ('T0220', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000021');
INSERT INTO TICKET VALUES ('T0221', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000022');
INSERT INTO TICKET VALUES ('T0222', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000023');
INSERT INTO TICKET VALUES ('T0223', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000024');
INSERT INTO TICKET VALUES ('T0224', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000025');
INSERT INTO TICKET VALUES ('T0225', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000026');
INSERT INTO TICKET VALUES ('T0226', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000027');
INSERT INTO TICKET VALUES ('T0227', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000028');
INSERT INTO TICKET VALUES ('T0228', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000029');
INSERT INTO TICKET VALUES ('T0229', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000030');
INSERT INTO TICKET VALUES ('T0230', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000031');
INSERT INTO TICKET VALUES ('T0231', 20, 009, 'B', 'Alzheimers',  'ST', 'C0013', '000000042');

--staffID, 
--flightID, 
--activityCode, 
--activityDesc,
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000002', 'TR', 'Precision instrument approach training');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000003', 'TR', 'Multi-crew cooperation');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0011', '000000003', 'TR', 'Multi-crew cooperation');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000006', 'TR', 'Navigation Exercise');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000007', 'TR', 'Navigation Exercise');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000008', 'TR', 'Navigation Exercise');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000009', 'TR', 'General handling');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000010', 'TR', 'General handling');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000011', 'TR', 'Multi-crew cooperation');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0011', '000000011', 'TR', 'Multi-crew cooperation');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0012', '000000011', 'TR', 'Multi-crew cooperation');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000015', 'TR', 'General handling');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000016', 'TR', 'General handling');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000017', 'TR', 'General handling');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000018', 'TR', 'General handling');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000019', 'TR', 'General handling');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000020', 'TR', 'General handling');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000021', 'TR', 'General handling');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000022', 'TR', 'Precision instrument approach training');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000023', 'TR', 'Precision instrument approach training');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000024', 'TR', 'Precision instrument approach training');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000025', 'TR', 'Precision instrument approach training');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000026', 'TR', 'Precision instrument approach training');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000027', 'TR', 'Precision instrument approach training');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000028', 'TR', 'Basic instrument flight');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000029', 'TR', 'Basic instrument flight');
INSERT INTO ADDITIONAL_PILOT VALUES ('S0006', '000000030', 'TR', 'Basic instrument flight');

--staffID, 
--flightID, 
INSERT INTO HOSTING VALUES ('S0003','000000001');
INSERT INTO HOSTING VALUES ('S0004','000000001');
INSERT INTO HOSTING VALUES ('S0005','000000002');
INSERT INTO HOSTING VALUES ('S0007','000000003');
INSERT INTO HOSTING VALUES ('S0008','000000003');
INSERT INTO HOSTING VALUES ('S0003','000000004');
INSERT INTO HOSTING VALUES ('S0004','000000004');
INSERT INTO HOSTING VALUES ('S0005','000000005');
INSERT INTO HOSTING VALUES ('S0007','000000006');
INSERT INTO HOSTING VALUES ('S0008','000000006');
INSERT INTO HOSTING VALUES ('S0003','000000007');
INSERT INTO HOSTING VALUES ('S0004','000000007');
INSERT INTO HOSTING VALUES ('S0005','000000008');
INSERT INTO HOSTING VALUES ('S0007','000000009');
INSERT INTO HOSTING VALUES ('S0008','000000009');
INSERT INTO HOSTING VALUES ('S0003','000000010');
INSERT INTO HOSTING VALUES ('S0004','000000010');
INSERT INTO HOSTING VALUES ('S0005','000000011');
INSERT INTO HOSTING VALUES ('S0007','000000012');
INSERT INTO HOSTING VALUES ('S0008','000000012');
INSERT INTO HOSTING VALUES ('S0003','000000013');
INSERT INTO HOSTING VALUES ('S0004','000000013');
INSERT INTO HOSTING VALUES ('S0005','000000014');
INSERT INTO HOSTING VALUES ('S0007','000000015');
INSERT INTO HOSTING VALUES ('S0008','000000015');
INSERT INTO HOSTING VALUES ('S0003','000000016');
INSERT INTO HOSTING VALUES ('S0004','000000016');
INSERT INTO HOSTING VALUES ('S0005','000000017');
INSERT INTO HOSTING VALUES ('S0007','000000018');
INSERT INTO HOSTING VALUES ('S0008','000000018');
INSERT INTO HOSTING VALUES ('S0003','000000019');
INSERT INTO HOSTING VALUES ('S0004','000000019');
INSERT INTO HOSTING VALUES ('S0005','000000020');
INSERT INTO HOSTING VALUES ('S0007','000000021');
INSERT INTO HOSTING VALUES ('S0003','000000022');
INSERT INTO HOSTING VALUES ('S0005','000000023');
INSERT INTO HOSTING VALUES ('S0007','000000024');
INSERT INTO HOSTING VALUES ('S0003','000000025');
INSERT INTO HOSTING VALUES ('S0005','000000026');
INSERT INTO HOSTING VALUES ('S0007','000000027');
INSERT INTO HOSTING VALUES ('S0003','000000028');
INSERT INTO HOSTING VALUES ('S0005','000000029');
INSERT INTO HOSTING VALUES ('S0007','000000030');
INSERT INTO HOSTING VALUES ('S0003','000000031');
INSERT INTO HOSTING VALUES ('S0004','000000031');
INSERT INTO HOSTING VALUES ('S0005','000000032');
INSERT INTO HOSTING VALUES ('S0006','000000032');
INSERT INTO HOSTING VALUES ('S0007','000000033');
INSERT INTO HOSTING VALUES ('S0008','000000033');
INSERT INTO HOSTING VALUES ('S0005','000000035');
INSERT INTO HOSTING VALUES ('S0006','000000035');
INSERT INTO HOSTING VALUES ('S0007','000000036');
INSERT INTO HOSTING VALUES ('S0008','000000036');

--qualification, 
--staffID,
INSERT INTO PILOT_QUALIFICATION VALUES ('CPL' , 'S0001');
INSERT INTO PILOT_QUALIFICATION VALUES ('CFI' , 'S0001');
INSERT INTO PILOT_QUALIFICATION VALUES ('ATPL', 'S0001');
INSERT INTO PILOT_QUALIFICATION VALUES ('CPL' , 'S0002');
INSERT INTO PILOT_QUALIFICATION VALUES ('CFI' , 'S0002');
INSERT INTO PILOT_QUALIFICATION VALUES ('ATPL', 'S0002');
INSERT INTO PILOT_QUALIFICATION VALUES ('CPL' , 'S0006');
INSERT INTO PILOT_QUALIFICATION VALUES ('CPL' , 'S0009');
INSERT INTO PILOT_QUALIFICATION VALUES ('CFI' , 'S0009');
INSERT INTO PILOT_QUALIFICATION VALUES ('ATPL', 'S0009');
INSERT INTO PILOT_QUALIFICATION VALUES ('CPL' , 'S0010');
INSERT INTO PILOT_QUALIFICATION VALUES ('ATPL', 'S0010');
INSERT INTO PILOT_QUALIFICATION VALUES ('ATPL', 'S0014');


commit; 
