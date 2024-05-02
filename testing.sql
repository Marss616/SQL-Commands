--30/4/24
--1
select V.venueName, E.eventName
from Events E, EventVenues EV, Venues V
where E.eventID = EV.eventID
and ev.venueID = V.venueID;
-- 2
SELECT *
FROM Events, Clients
where Events.ClientID = Clients.ClientID;
--3
select distinct V.venueName, E.eventName
from Events E, EventVenues EV, Venues V
where E.eventID = EV.eventID
and EV.venueID = V.venueID;
--4
select *
From VENUES, EVENTS
--5
select distinct V.venueName, E.eventName
from Events E, EventVenues EV, Venues V
where E.eventID = EV.eventID
and EV.venueID = V.venueID;
--6 to_char method
select distinct V.venueName, E.eventName
from Events E, EventVenues EV, Venues V
where E.eventID = EV.eventID
and EV.venueID = V.venueID
and to_char(EV.bookingDate, 'MON-YYYY') = 'JUN-2018';
--7 another method of to_char()
select to_char(bookingDate, 'DD-MON-YYYY HH:MI AM')
from eventVenues;

select to_char(bookingDate, 'DD-MON-YYYY')
from eventVenues;
where eventVenues.bookingDate = '01-JUN-2018';

select to_char(bookingDate, 'MON-YYYY')
from eventVenues
where eventVenues.bookingDate = 'JUN-2018';
--2/5/24
SELECT * from tab;
SELECT * from CLIENTS;

SELECT COUNT(*) from CLIENTS
where POSTCODE='1001';

SELECT COUNT(*) from CLIENTS
FROM EVENTS;