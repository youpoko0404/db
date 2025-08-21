CREATE TABLE Projects
(
    ProjectId INT IDENTITY(1,1) PRIMARY KEY,
    ProjectName NVARCHAR(200) NOT NULL,
    Description NVARCHAR(500),
    StartDate DATETIME NOT NULL,
    EndDate DATETIME NULL,
    IsActive BIT NOT NULL DEFAULT 1,
    IsDeleted BIT NOT NULL DEFAULT 0,
    CreatedAt DATETIME NOT NULL DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL
);
GO
CREATE TABLE Employees
(
    EmployeeId INT IDENTITY(1,1) PRIMARY KEY,
    FullName NVARCHAR(150) NOT NULL,
    Position NVARCHAR(100),
    HireDate DATETIME,
    IsActive BIT DEFAULT 1,
    IsDeleted BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL
);
GO
CREATE TABLE ProjectAssignments
(
    AssignmentId INT IDENTITY(1,1) PRIMARY KEY,
    ProjectId INT NOT NULL,
    EmployeeId INT NOT NULL,
    Note NVARCHAR(300),
    AssignedDate DATETIME DEFAULT GETDATE(),
    IsDeleted BIT DEFAULT 0,
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME NULL,

    CONSTRAINT FK_Assignments_Project FOREIGN KEY (ProjectId) REFERENCES Projects(ProjectId),
    CONSTRAINT FK_Assignments_Employee FOREIGN KEY (EmployeeId) REFERENCES Employees(EmployeeId)
);
