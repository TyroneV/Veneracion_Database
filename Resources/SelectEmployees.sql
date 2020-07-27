Select EmployeeID,LastName,FirstName, JobTitle,
FORMAT(DOB,'MM/dd/yyyy') AS DOB,FORMAT(HireDate,'MM/dd/yyyy')AS HireDate,
FORMAT(MonthlySalary,'c') AS MonthlySalary,FORMAT(SalesAmt,'c') AS SalesAmt,
BonusRate,FORMAT(CarAllowance,'c') AS CarAllowance,FORMAT(BonusAmount,'c') AS BonusAmount,
FORMAT((ISNULL(MonthlySalary,0)+((ISNULL(BonusRate,0)/100) * ISNULL(MonthlySalary,0))+ISNULL(CarAllowance,0)),'c') AS TotalCompensation
FROM dbo.EmployeeInformation;