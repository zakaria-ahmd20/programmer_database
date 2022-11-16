CREATE DATABASE senecadb;
USE senecadb;
create table Clients (
 client_id decimal(5,0) NOT null,
 client_name varchar(50) NOT NULL,
 client_address varchar(50) NOT NULL,
 client_city varchar(10) ,
 client_prov char(2) NOT NULL,
 client_postal char(6) not null,
 unique(client_name),
 primary key (client_id)
) ;
create table Programmer (
 prog_id decimal(5,0) not null,
 prog_name varchar(30) not null,
 prog_office char(5) not null,
 prog_phone char(10) null,
 primary key (prog_id)
) ;
create table Project (
 project_id decimal(6,0) NOT NULL,
 project_name varchar(40) not null unique,
 complete_date date not null,
 total_cost decimal(8,2) not null,
 client_id decimal(5,0) not null,
 primary key (project_id),
 key client_id (client_id)
) ;
create table Project_mm_Programmer (
 prog_id decimal(5,0) not null,
 project_id decimal(6,0) not null,
 hours_worked decimal(4,1) not null,
 key (prog_id),
 key (project_id),
 CONSTRAINT fk_prog_id FOREIGN KEY (prog_id) REFERENCES Programmer (prog_id),
 CONSTRAINT fk_project_id2 FOREIGN KEY (project_id) REFERENCES Project (project_id)
) ;
insert into Clients(Client_id,client_name,client_address,client_city,client_prov,client_postal) values
(1001,
'Seneca College',
'70 the Pond Road',
'Toronto',
'ON',
'M1K2T4'
),
(1002,
'Greenville Printers',
'1516 Steels Road West',
'Vaughan',
'ON',
'L2R6Y5'
),
(1003,
'Cameco Refinery',
'P.O.Box 2100, stn M',
'Calgary',
'AB',
'T2P2M5'
),
(1004,
'Pier Exports',
'701 W Georgia St',
'Vancouver',
'BC',
'V7Y1G5'
),
(1005,
'Parkdale Marketing',
'1485 Portage Ave',
'Winnipeg',
'MB',
'R3G0W4'
)
;
INSERT INTO Programmer(prog_id,prog_name,prog_office,prog_phone) values
(20001,
'Mark Zukerberg', 'T2110', '8994211212'
),
(20002,
'Steve Jobs',
'S1200',
'6994440000'
),
(20003,
'Bill Gates',
'T1200',
'
'
),
(20004,
'Chris Tyler',
'T2008',
'
'
),
(20005, 'Laura Pitts', 'S3007',
'
'
);
insert into Project(project_id,project_name,complete_date,total_cost,client_id) 
VALUES
(210001,
'Mind Craft',
'2020-11-10',10000.00,10001), 
(210002,
'The Locker',
'2027-02-12',250000.99,10002), 
(210003 
,
'Mind Reader', 
'2021-12-12',90000.99,10003), 
(210004 
,
'Phone Tracker',
'2022-01-02',25000.99, 
10001), 
(210005 
,
'Jobs on Go',
'2023-12-08',59999.99,10002);
insert Project_mm_Programmer (prog_id,project_id,hours_worked) 
Values
(20001,210001,89.5),
(20001,210002,66),
(20003,210003,50),
(20002,210003,100.5),
(20005,210002,60),
(20004,210002,90);
 -- test queries
select prog_name from programmer
join Project_mm_Programmer ON programmer.prog_id = Project_mm_Programmer.prog_id
join project ON Project_mm_Programmer.project_id = project.project_id
where project.project_name = "The Locker";
UPDATE programmer
SET prog_phone = 647-900-0000 
WHERE prog_name = 'Bill Gates';
DELETE FROM programmer WHERE prog_name = "Laura Pitts";
UPDATE project
SET total_cost = 12000 
WHERE project_name = 'Mind Craft';
select sum(Total_Cost), sum(hours_worked) from programmer
join project_mm_programmer on programmer.prog_id = project_mm_programmer.prog_id
join project on project_mm_programmer.project_id = project.project_id
where programmer.prog_id = '20001';
select client_name , project_name , prog_name from programmer 
join project_mm_programmer on programmer.prog_id = project_mm_programmer.prog_id
join project on project_mm_programmer.project_id = project.project_id
join clients on project.client_id = clients.client_id;
