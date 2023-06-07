#Create schema:
Create schema Project;

#Create table "Hotel" : 
CREATE TABLE Hotel(
hotelName  VARCHAR(19) NOT NULL,
phoneNum      INT(10),
city          VARCHAR(7),
neighborhood      VARCHAR(28),
street           VARCHAR(20),
email           VARCHAR(30),
CONSTRAINT Hotel_PK PRIMARY KEY (hotelName)
);

#Create table "Guest" : 
CREATE TABLE Guest (
guestID INT (10) NOT NULL ,
guestName VARCHAR (20),
phone INT(10) NOT NULL,
numOfAdults INT (5) ,
numOfChildren INT(5),
CONSTRAINT Guest_PK PRIMARY KEY (guestID));

#Create table "Employee" : 
Create Table Employee
( EmpId INT(7) NOT NULL,
FName  VARCHAR(20),
LName  VARCHAR(20),
city VARCHAR(30),
street VARCHAR(30),
neighborhood VARCHAR(20),
phoneNum INT (10),
occupation VARCHAR(20),
gender char(6),
birthdate DATE,
hotelName VARCHAR(19),
S_empId INT(7) NOT NULL,
CONSTRAINT Employee PRIMARY KEY (EmpId),
CONSTRAINT Employee FOREIGN KEY (hotelName) REFERENCES Hotel(hotelName)
);

#Create table "Room" : 
CREATE TABLE Room 
( numberOfRoom   INT(3) NOT NULL,
     typeOfRoom    VARCHAR(20),
     floor       INT(2),
     available     VARCHAR(3) CHECK (available IN ('yes','no') ),
     hotelName   VARCHAR(19) ,
     guestID   INT(10),
     CONSTRAINT Room_PK PRIMARY KEY (numberOfRoom),
     CONSTRAINT Room_FK FOREIGN KEY (hotelName) REFERENCES hotel(hotelName)ON DELETE CASCADE ON UPDATE CASCADE ,
     CONSTRAINT Room_FK1  FOREIGN KEY (guestID) REFERENCES Guest(guestID) ON DELETE CASCADE ON UPDATE CASCADE
     );
     
#Create table "Services" : 
CREATE TABLE Services
( servName   VARCHAR (20) NOT NULL , 
servPrice    VARCHAR (10) ,
servEmpName   VARCHAR (20) ,
EmpId       INT(7) , 
hotelName    VARCHAR(19),
Constraint Services_PK PRIMARY KEY (servName),
Constraint Services_FK FOREIGN KEY (EmpId) references Employee (EmpId)  , 
Constraint Services_FK2 FOREIGN KEY (hotelName) references Hotel (hotelName)  
);

#Create table "Takes" : 
CREATE TABLE Takes (
servName VARCHAR (20) NOT NULL,
guestID INT (10) NOT NULL,
CONSTRAINT Takes_PK  PRIMARY KEY (servName,guestID),
CONSTRAINT Takes_FK1 FOREIGN KEY (servName) REFERENCES Services(servName) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT Takes_FK2 FOREIGN KEY (guestID) REFERENCES Guest(guestID)
);


#Insert:

INSERT INTO  Hotel 
VALUES ('reef',0574324567,'makkah','salam','sharia','reef01@gmail.com'),
('mera',0565324554,'jeddah','thabit','al-rawdaa','mera@hotmail.com'),
('aram',0599347892,'aseer','budaiya','al-tirmidhi','aram9@gmail.com'),
('brera',0597323424,'riyadh','sidra','olaya','brera00@hotmail.com'),
('zaha al-munawwarah',0534780792,'medina','al-rabwa','al-faisaliah','zaha7@gmail.com'),
('garden view',0533408757,'tabouk','qadisiyah','al-mourouj','garden@hotmail.com');

INSERT INTO  Guest 
VALUES (442004372,'sara' ,0550643615,2,2),
(442105672,'ahmad',0550678615,1,0),
(442001489,'rahaf',0550643677,3,1),
(442001492,'naif' ,0550223615,2,0),
(442024722,'nora' ,0550643995,5,1),
(442008092,'saad' ,0550699915,1,2);

INSERT INTO Employee 
VALUES (9557677, 'Renad','ALWAFI','Jeddah','Abn alahtm','Alsafa',0550575595,'Manger','Female','2002-10-7','reef',9557677),
(6756750, 'Mohamad','ALHARBI','Makkah','Um almomnin','albuhairat',0558788595,'Reception','male','2002-11-12','mera',9557677),
(7860323, 'Ahmad','Alnasiri','Makkah','Alzaher','alhegon',0556676666,'Reception','male','1990-12-8','aram',9557677),
(9976547, 'Amani','Alnasiri','Makkah','alazizih','alkyat',0550878955,'room service','Female','1998-05-9','brera',9557677),
(2389900, 'Naif','Alshareef','jeddah','alslam','slamah',0559724395,'Reception','male','2000-11-12','zaha al-munawwarah',9557677),
(4335789, 'Anas','Hafiz','Makkah','alhag','alaml',0550200455,'room service','male','1995-7-20','garden view',9557677);

INSERT INTO Room 
VALUES (12, 'Single room', 2, 'yes', 'mera', NULL),
(15, 'Single room', 2, 'yes', 'aram', NULL),
(21, 'King room', 3, 'no', 'garden view', 442001492),
(33, 'Duplex room', 4, 'yes', 'brera', NULL),
(37, 'Duplex room', 4, 'no', 'zaha al-munawwarah', 442024722),
(23, 'Twin room', 3, 'no', 'reef', 442004372);


INSERT INTO Services (servName , servPrice , servEmpName , empId , hotelName )
VALUE ('rooms Services' , 'free' , 'Amani ' , 9976547 , 'brera' ),
('rooms Cleaning' , 'free' , 'Anas ' ,  4335789 , 'garden view' ),
('Servinng meals ' , 25, 'Amani ' ,9976547 ,'brera'),
( 'Laundry' , 40 , 'Anas' , 4335789 , 'garden view' ),
('Reserving rooms' , 'free' , ' Renad' , 9557677 , 'reef' ),
('currency exchange' , '0.05%' , ' Naif' ,  2389900 , 'zaha al-munawwarah' ),
('Order a Taksi' , '15' , 'Ahmad' , 7860323 , 'aram' );


INSERT INTO  Takes (servName , guestID)
VALUES ('rooms Services', 442004372),
('rooms Cleaning', 442105672),
('Servinng meals ', 442001489),
('Laundry' , 442001492),
('Reserving rooms', 442024722),
('currency exchange', 442008092);


#Commands:
#.. Shatha ..

#Updtae the occupation of the employee with Id = 4335789, to Reception.
UPDATE Employee
SET occupation = 'Reception'
WHERE EmpId = 4335789;

#Delete the employee with ID 7860323 from working on services. 
DELETE FROM Services
WHERE empId = 7860323;

#Delete the employee (Amani) from working on services.
DELETE FROM Services
WHERE empId IN(SELECT empId
               FROM Employee
               WHERE FName = 'Amani');
               
               
#.. Ghadee ..

#List the hotel names, locations, and the employees' names and Ids.
SELECT     h.hotelName , h.city , h.street, EmpId ,FName,LName
FROM       hotel h , Employee e
WHERE       h.hotelName=e.hotelName;

#List the all room number, type, floor and availability status, with first ascending order in room number, and then ascending order in floor.
SELECT   numberOfRoom, typeOfRoom, floor, available
FROM     Room
ORDER BY    numberOfRoom, floor ASC; 

#.. RENAD ..

#List all the details of every guest with more than one child.
SELECT  *
FROM Guest
WHERE  numOfChildren > 1;

#List all the non-available rooms numbers, and hotel name for each. 
SELECT hotelName, numberOfRoom ,available
FROM Room
WHERE hotelName IN ( SELECT hotelName 
                     FROM Room 
                     WHERE numberOfRoom IN (SELECT numberOfRoom
                                            FROM Room
										    WHERE available = 'no'));
                                            
                                            
#For each employee working in Makkah, show their first name, last name, and the name of the hotel they work for. 
SELECT FName ,LName , hotelName
FROM Employee
WHERE city = ( 'Makkah');    

#List all the details of every guest who asked for a free service.
SELECT * 
FROM Guest
WHERE guestID IN ( SELECT guestID 
                     FROM Takes 
                     WHERE servName IN (SELECT servName
                                            FROM Services
										    WHERE servPrice = 'free'));                
                                            
#..Rawan Hafiz..

#Find the total number of available rooms, as well as the non-available.
SELECT available , Count(numberOfRoom) AS count
FROM room
GROUP BY available ;

#Find the total number of employee in each city.
SELECT city , Count(EmpId) AS count  
FROM Employee
GROUP BY city ;

#For each floor higher than the first floor, find the total number of rooms.
SELECT floor , Count(numberOfRoom) AS count 
FROM Room
GROUP BY floor
HAVING Count(floor)>1;  

# ..Hadeel.. 

#List all the guest names, IDs, and their current room number. Show names in descending order.
SELECT guestName,g.guestID, numberOfRoom
FROM Guest g, Room r
WHERE g.guestID = r.guestID
ORDER BY guestName DESC;

#Show how many employee in each occupation.
SELECT occupation, Count(EmpId) AS Number_Of_Employees
FROM Employee
GROUP BY occupation;




                 