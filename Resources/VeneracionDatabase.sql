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
