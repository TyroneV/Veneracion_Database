
INSERT INTO Employees (EmployeeID,LastName, FirstName, DOB)
VALUES (101,'Gates','William','11/03/1984');
INSERT INTO Employees (EmployeeID,LastName, FirstName, DOB)
VALUES (102,'Garcia','Estella','10/11/1997');
INSERT INTO Employees (EmployeeID,LastName, FirstName, DOB)
VALUES (103,'Goode','April','06/11/1989');
INSERT INTO Employees (EmployeeID,LastName, FirstName, DOB)
VALUES (203,'Simpson','Homer','01/05/1987');
INSERT INTO Employees (EmployeeID,LastName, FirstName, DOB)
VALUES (202,'Chan','Henry','05/27/1994');
INSERT INTO Employees (EmployeeID,LastName, FirstName, DOB)
VALUES (297,'Jackson','Shirley','11/15/1988');
INSERT INTO Employees (EmployeeID,LastName, FirstName, DOB)
VALUES (211,'Slack','Elton','04/12/1995');


INSERT INTO JobTitles (JobTitle)
VALUES ('President');
INSERT INTO JobTitles (JobTitle)
VALUES ('Sales Manager');
INSERT INTO JobTitles (JobTitle)
VALUES ('Programmer');
INSERT INTO JobTitles (JobTitle)
VALUES ('Sales Associate ');
INSERT INTO JobTitles (JobTitle)
VALUES ('Programmer Associate ');

INSERT INTO BonusGroup (BonusRate)
VALUES (5);
INSERT INTO BonusGroup (BonusRate)
VALUES (7);
INSERT INTO BonusGroup (BonusRate)
VALUES (15);

INSERT INTO CarAllowance (CarAllowance)
VALUES (400);
INSERT INTO CarAllowance (CarAllowance)
VALUES (600);
INSERT INTO CarAllowance (CarAllowance)
VALUES (2400);

INSERT INTO SalesInformation (EmployeeID,SalesAmt)
VALUES (203,4500);
INSERT INTO SalesInformation (EmployeeID,SalesAmt)
VALUES (202,94980);
INSERT INTO SalesInformation (EmployeeID,SalesAmt)
VALUES (297,180670);

INSERT INTO EmployeeJobs (EmployeeID,JobID,HireDate,BonusGroupID,MonthlySalary,CarAllowanceID)
VALUES (101,1,'02/27/1999',1,423300,3);
INSERT INTO EmployeeJobs (EmployeeID,JobID,HireDate,BonusGroupID,MonthlySalary,CarAllowanceID)
VALUES (102,2,'10/11/1997',2,12500,2);
INSERT INTO EmployeeJobs (EmployeeID,JobID,HireDate,MonthlySalary)
VALUES (103,3,'06/11/1989',7900);
INSERT INTO EmployeeJobs (EmployeeID,JobID,HireDate,BonusGroupID,MonthlySalary,CarAllowanceID)
VALUES (203,4,'01/05/1987',3,3600,1);
INSERT INTO EmployeeJobs (EmployeeID,JobID,HireDate,BonusGroupID,MonthlySalary,CarAllowanceID)
VALUES (202,4,'05/27/1994',3,4700,1);
INSERT INTO EmployeeJobs (EmployeeID,JobID,HireDate,BonusGroupID,MonthlySalary,CarAllowanceID)
VALUES (297,4,'11/15/1988',3,5100,1);
INSERT INTO EmployeeJobs (EmployeeID,JobID,HireDate,MonthlySalary)
VALUES (211,5,'04/12/1995',6200);

