Select FORMAT(SUM(MonthlySalary),'c') AS MonthlySalary,
FORMAT(SUM(SalesAmt),'c') AS SalesAmt,
FORMAT(SUM(CarAllowance),'c') AS CarAllowance,
FORMAT(SUM(BonusAmount),'c') AS BonusAmount,
FORMAT(SUM((ISNULL(MonthlySalary,0)+((ISNULL(BonusRate,0)/100) * ISNULL(MonthlySalary,0))+ISNULL(CarAllowance,0))),'c') AS TotalCompensation
FROM dbo.EmployeeInformation