-- Create the database
CREATE DATABASE BlueSkyPortal;
GO

-- Switch to the new database
USE BlueSkyPortal;
GO

-- Create the Users table
CREATE TABLE Users (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    Email NVARCHAR(255) NOT NULL UNIQUE,
    PasswordHash NVARCHAR(255) NOT NULL,
    FullName NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);
GO

-- Create the Applications table
CREATE TABLE Applications (
    Id INT IDENTITY(1,1) PRIMARY KEY,
    UserId INT NOT NULL,
    GradYear INT,
    GPA DECIMAL(3,2),
    ACTScore INT,
    ResumeFilename NVARCHAR(255),
    ApplicationStatus NVARCHAR(50) DEFAULT 'Draft',
    CreatedAt DATETIME DEFAULT GETDATE(),
    UpdatedAt DATETIME DEFAULT GETDATE(),

    -- Foreign key linking back to Users
    CONSTRAINT FK_Applications_Users FOREIGN KEY (UserId)
        REFERENCES Users(Id)
        ON DELETE CASCADE
);
GO

INSERT INTO Users (Email, PasswordHash, FullName)
VALUES 
('user1@example.com', '$2b$12$vorrLWtSpkphJ/nI5igXzedz3j.vd2i8fsDSebLt6M1pE9Not4hU2', 'Alice Johnson'),
('user2@example.com', '$2b$12$S7EA.voL7WeIe/gt1aRWouplnPE7X6gGzTJY5RDvP59MeBtHSetZi', 'Bob Smith'),
('user3@example.com', '$2b$12$xKC5li82QiiCIjhjr4fAIeoBEy5pq2O.FSZ6nNj5mOPWorMQrKpq2', 'Charlie Davis'),
('user4@example.com', '$2b$12$kQNXdZQrPhNHEr3G9XGDouhvDc3R4vkGSddgZGJhnYAjzGWbd7f2y', 'Diana Brown'),
('user5@example.com', '$2b$12$wVwdbvVKvSfW//IhKkIgRePvUCD7WILtCVwCf.JyuITYh1VaHE37W', 'Ethan Wilson'),
('user6@example.com', '$2b$12$G9Isv5tHJif6tNnmTLHgLel7pTiLFhOkkTl8abAvfN3wuZv0lteJ2', 'Fiona Clark'),
('user7@example.com', '$2b$12$UXRru/GQr7IfT8fxVZ1o2.jQh8gf88ZU0kqnzmqSprdMgApY1oQM.', 'George Lewis'),
('user8@example.com', '$2b$12$.S3wK3BsNxuikK9jQGpem.foGhjVS53OZKigp1sry4F3KEHXLThm2', 'Hannah Walker'),
('user9@example.com', '$2b$12$421DHzHsuQDf93u2nxRzweVcfdtLeyy03XZiEz0S0HG9QMDLmONia', 'Ian Hall'),
('user10@example.com', '$2b$12$Zn6jsLBVWzgoppCWz8Nx1uFAxoeFnSAKXYKFX9ur4vNpsQ2XQeH6.', 'Jasmine Allen'),
('user11@example.com', '$2b$12$TdQeaYqppgOknmvf1vyi7ugAA8aOmNq.p0R8OEBhHhFjGFYwqhSeW', 'Kevin Young'),
('user12@example.com', '$2b$12$RjP.Lsw..JXHJppRcdgNs.IWAyN6geS7dzLob2YOJqPZKXae/J4Um', 'Laura King'),
('user13@example.com', '$2b$12$wXyTP78SW1YbR2kx.VAt4uqdtPYH4kY4CvykgDPLMilzz8Ugaz.hm', 'Michael Wright'),
('user14@example.com', '$2b$12$DfUjLn1WfjouV/QVX3YfSukjKio/j/.Jr8sHTcS7rFkdpxKutRmUK', 'Nina Scott'),
('user15@example.com', '$2b$12$PK8eV2Unxd.kPe2jy0c1bOZRiiEIS.RQvAaWDnQYdUbkRj/BqGaai', 'Oscar Green'),
('user16@example.com', '$2b$12$rQ/eXtd/WfHGCaSbStf5suRAogqzMNbFEt85XV9KdvMY3XzRraHuq', 'Paula Adams'),
('user17@example.com', '$2b$12$mdMjGTjtiaigPsCYmDLRB.iCab6I8C8bSSGpCwa1XH7n/n3gbfUBq', 'Quentin Baker'),
('user18@example.com', '$2b$12$mIT8BaCfCS7jmyzrYenIoOa55V2LbYGiC3CLBSEXR8osleEAdk3vq', 'Rachel Nelson'),
('user19@example.com', '$2b$12$Z/c0uyM1UQPelflGT1j5yeMqKltnAQeUk5WYV/wCRXSLbS0.Z3i6S', 'Steven Carter'),
('user20@example.com', '$2b$12$Xg.waB4M4rtyfTfO2.BywuAqiKDjjP2Hyte3tDaZSJ5SXEOtQfLMK', 'Tina Mitchell');

select * from BlueSkyPortal..Users
