-- =======================================================
-- TASK 3: SQL PRACTICE QUERIES
-- =======================================================

-- 1. Top 5 highest salary employees
SELECT TOP 5 * FROM Employees 
ORDER BY Salary DESC;

-- 2. Department wise employee count
SELECT DepartmentID, COUNT(EmployeeID) AS EmployeeCount
FROM Employees
GROUP BY DepartmentID;

-- 3. Find Second highest salary
SELECT MAX(Salary) AS SecondHighestSalary
FROM Employees
WHERE Salary < (SELECT MAX(Salary) FROM Employees);

-- 4. Employees whose salary > department average salary
SELECT e.*
FROM Employees e
INNER JOIN (
    SELECT DepartmentID, AVG(Salary) AS AvgSalary
    FROM Employees
    GROUP BY DepartmentID
) d ON e.DepartmentID = d.DepartmentID
WHERE e.Salary > d.AvgSalary;

-- 5. Inner Join
SELECT e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
INNER JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 6. Left Join
SELECT e.EmployeeID, e.FirstName, e.LastName, d.DepartmentName
FROM Employees e
LEFT JOIN Departments d ON e.DepartmentID = d.DepartmentID;

-- 7. Group By with Having
SELECT DepartmentID, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY DepartmentID
HAVING AVG(Salary) > 50000;

-- 8. Employees hired in last 6 months
SELECT * FROM Employees 
WHERE HireDate >= DATEADD(month, -6, GETDATE());

-- 9. Find the Duplicate records
SELECT FirstName, LastName, Email, COUNT(*) as DuplicateCount
FROM Employees
GROUP BY FirstName, LastName, Email
HAVING COUNT(*) > 1;

-- 10. How to remove the duplicate records
WITH CTE_Duplicates AS (
    SELECT *,
           ROW_NUMBER() OVER (PARTITION BY FirstName, LastName, Email ORDER BY EmployeeID) AS RowNum
    FROM Employees
)
DELETE FROM CTE_Duplicates 
WHERE RowNum > 1;
