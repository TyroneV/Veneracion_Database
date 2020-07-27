IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'Employees'))
BEGIN

	CREATE TABLE Employees (
		EmployeeID INT NOT NULL,
		LastName VARCHAR(50) NOT NULL,
		FirstName VARCHAR(50) NOT NULL,
		DOB DATE NOT NULL,
		CONSTRAINT PK_Employees PRIMARY KEY (EmployeeID)
	);

END

IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'JobTitles'))
BEGIN

	CREATE TABLE JobTitles (
		JobID INT IDENTITY(1,1) NOT NULL,
		JobTitle VARCHAR(50) NOT NULL,
		CONSTRAINT PK_JobTitles PRIMARY KEY(JobID)
	);

END

IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'BonusGroup'))
BEGIN

	CREATE TABLE BonusGroup (
		BonusGroupID INT IDENTITY(1,1) NOT NULL,
		BonusRate DECIMAL NOT NULL,
		CONSTRAINT PK_BonusGroups PRIMARY KEY (BonusGroupID),
		CONSTRAINT UC_BonusRate UNIQUE (BonusRate)
	);

END
IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'CarAllowance'))
BEGIN

CREATE TABLE CarAllowance (
	CarAllowanceID INT IDENTITY(1,1) NOT NULL,
	CarAllowance MONEY NOT NULL,
	CONSTRAINT PK_CarAllowance PRIMARY KEY(CarAllowanceID),
	CONSTRAINT UC_CarAllowance UNIQUE (CarAllowance)
);

END
IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'SalesInformation'))
BEGIN

CREATE TABLE SalesInformation (
	SalesID INT IDENTITY(1,1) NOT NULL,
	EmployeeID INT NOT NULL,
	SalesAmt MONEY,
	CONSTRAINT PK_SalesData PRIMARY KEY (SalesID),
	CONSTRAINT FK_Employee FOREIGN KEY (EmployeeID) REFERENCES Employees(EmployeeID)
);

END

IF (NOT EXISTS (SELECT * 
                 FROM INFORMATION_SCHEMA.TABLES 
                 WHERE TABLE_SCHEMA = 'dbo' 
                 AND  TABLE_NAME = 'EmployeeJobs'))
BEGIN

CREATE TABLE EmployeeJobs (
	EmployeeJobID INT IDENTITY(1,1) NOT NULL,
	EmployeeID INT NOT NULL,
	JobID INT NOT NULL,
	HireDate DATE NOT NULL,
	BonusGroupID INT NULL,
	MonthlySalary MONEY NULL,
	CarAllowanceID INT NULL,
	CONSTRAINT PK_EmployeeJobs PRIMARY KEY (EmployeeJobID),
	CONSTRAINT FK_Employees FOREIGN KEY(EmployeeID) REFERENCES  Employees (EmployeeID),
	CONSTRAINT FK_JobTitles FOREIGN KEY(JobID) REFERENCES JobTitles (JobID),
	CONSTRAINT FK_BonusGroups FOREIGN KEY(BonusGroupID) REFERENCES BonusGroup (BonusGroupID),
	CONSTRAINT FK_CarAllowance FOREIGN KEY(CarAllowanceID) REFERENCES CarAllowance (CarAllowanceID)
);

END

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