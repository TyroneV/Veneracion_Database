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

Select EmployeeID,LastName,FirstName, JobTitle,
FORMAT(DOB,'MM/dd/yyyy') AS DOB,FORMAT(HireDate,'MM/dd/yyyy')AS HireDate,
FORMAT(MonthlySalary,'c') AS MonthlySalary,FORMAT(SalesAmt,'c') AS SalesAmt,
BonusRate,FORMAT(CarAllowance,'c') AS CarAllowance,FORMAT(BonusAmount,'c') AS BonusAmount,
FORMAT((ISNULL(MonthlySalary,0)+((ISNULL(BonusRate,0)/100) * ISNULL(MonthlySalary,0))+ISNULL(CarAllowance,0)),'c') AS TotalCompensation
FROM dbo.EmployeeInformation;