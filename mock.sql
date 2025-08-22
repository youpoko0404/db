DELETE FROM dbo.ProjectAssignments;
DELETE FROM dbo.Employees;
DELETE FROM dbo.Projects;

INSERT INTO Employees(TenantId, FullName, Position, HireDate)
SELECT
	1,
    CONCAT('Employee ', v.number),
    CASE v.number % 5 
        WHEN 0 THEN 'Developer'
        WHEN 1 THEN 'QA'
        WHEN 2 THEN 'Project Manager'
        WHEN 3 THEN 'Business Analyst'
        ELSE 'UX/UI'
    END,
    DATEADD(DAY, -v.number * 10, GETDATE())
FROM (SELECT TOP 50 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS number FROM sys.all_objects) v

INSERT INTO Projects
    (ProjectName, Description, StartDate, EndDate)
SELECT
    CONCAT('Project ', v.number),
    CONCAT('This is the description for project ', v.number),
    DATEADD(DAY, -v.number * 5, GETDATE()),
    CASE WHEN v.number % 3 = 0 THEN NULL ELSE DATEADD(DAY, v.number * 2, GETDATE()) END
FROM (SELECT TOP 50 ROW_NUMBER() OVER (ORDER BY (SELECT NULL)) AS number FROM sys.all_objects) v;

INSERT INTO ProjectAssignments (ProjectId, EmployeeId, Note)
SELECT TOP 100
    p.ProjectId,
    e.EmployeeId,
    ''
FROM Projects p
CROSS JOIN Employees e
ORDER BY NEWID();

SELECT * FROM dbo.ProjectAssignments
SELECT * FROM dbo.Employees
SELECT * FROM dbo.Projects
