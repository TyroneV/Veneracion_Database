
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

IF (NOT EXISTS (SELECT *
   FROM INFORMATION_SCHEMA.TABLES
   WHERE TABLE_SCHEMA = 'dbo'
   AND TABLE_NAME = 'EmployeeInformation'))
BEGIN
	SELECT e.EmployeeID, e.LastName,e.FirstName,
	jt.JobTitle,e.DOB,ej.HireDate,
	ej.MonthlySalary, 
	 ISNULL(s.SalesAmt,0) as SalesAmt, ISNULL(b.BonusRate,0)AS BonusRate, ISNULL(c.CarAllowance,0) AS CarAllowance,
	((ISNULL(b.BonusRate,0)/100) * ISNULL(MonthlySalary,0)) AS BonusAmount 
	INTO dbo.EmployeeInformation
	FROM Employees AS e
	LEFT OUTER JOIN EmployeeJobs AS ej ON e.EmployeeID = ej.EmployeeID
	LEFT OUTER JOIN JobTitles AS jt ON ej.JobID = jt.JobID
	LEFT OUTER JOIN SalesInformation AS s ON e.EmployeeID = s.EmployeeID
	LEFT OUTER JOIN BonusGroup AS b ON ej.BonusGroupID = b.BonusGroupID
	LEFT OUTER JOIN CarAllowance AS c ON ej.CarAllowanceID = c.CarAllowanceID
	ORDER BY e.EmployeeID;
END

UPDATE dbo.EmployeeInformation
SET BonusAmount = ISNULL(SalesAmt,0) * (ISNULL(BonusRate,0)/100)
WHERE JobTitle = 'Sales Associate';

UPDATE  dbo.EmployeeInformation
SET BonusAmount = (SELECT SUM(ISNULL(SalesAmt,0)) total FROM EmployeeInformation) * (ISNULL(BonusRate,0)/100)
WHERE JobTitle = 'Sales Manager';
