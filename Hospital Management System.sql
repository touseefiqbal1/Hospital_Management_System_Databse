-- Create New HospitalDB Database
CREATE DATABASE HospitalDB;

-- Switching to HospitalDB Database
Use HospitalDB;
GO

-- Creating Departments table
CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    Name VARCHAR(50) NOT NULL UNIQUE
);

-- Creating Patients table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY IDENTITY(1,1),
    FirstName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Address VARCHAR(100),
    DateOfBirth DATE,
    Insurance VARCHAR(50),
    Email VARCHAR(50) UNIQUE,
    Phone VARCHAR(20),
    UserName VARCHAR(50) NOT NULL UNIQUE,
    PasswordHash VARBINARY(256) NOT NULL, -- Storing Password as hash
    PatientLeft DATE
);

-- Creating Doctors table
CREATE TABLE Doctors (
    DoctorID INT PRIMARY KEY IDENTITY(1,1),
    FullName VARCHAR(255) NOT NULL,
    DepartmentID INT NOT NULL,
    Specialty VARCHAR(100) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Creating Appointments table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    DepartmentID INT NOT NULL,
    AppointmentDate DATE NOT NULL,
    AppointmentTime TIME NOT NULL,
    CancelledDate DATE,
    Status VARCHAR(20) NOT NULL CHECK (Status IN ('Pending', 'Completed', 'Cancelled', 'Available')),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (DepartmentID) REFERENCES Departments(DepartmentID)
);

-- Creating MedicalRecords table
CREATE TABLE MedicalRecords (
    RecordID INT PRIMARY KEY IDENTITY(1,1),
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    Diagnosis VARCHAR(100) NOT NULL,
    Medicine VARCHAR(100),
    MedicinePrescribedDate DATE,
    Allergy VARCHAR(100),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID)
);

-- Creating DoctorFeedback table
CREATE TABLE DoctorFeedback (
    FeedbackID INT PRIMARY KEY IDENTITY(1,1),
    Rating INT NOT NULL CHECK (Rating BETWEEN 1 AND 5),
    Comment TEXT,
    FeedbackDate DATE NOT NULL,
    AppointmentID INT NOT NULL,
    DoctorID INT NOT NULL,
    PatientID INT NOT NULL,
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID),
    FOREIGN KEY (DoctorID) REFERENCES Doctors(DoctorID),
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID)
);

-- Insert sample data into tables
INSERT INTO Patients 
(FirstName, LastName, Address, DateOfBirth, Insurance, Email, Phone, UserName, PasswordHash)
VALUES
    ('Ahmed', 'Khan', '67 Gulberg 2 Karachi', '1982-01-15', 'Jubilee Health', 'ahmed.khan@gmail.com', '0302-4578521', 'ahmedk82', HASHBYTES('SHA2_256', CONVERT(VARCHAR(50), '@ahmadkh@n44$'))),
    ('Fatima', 'Iqbal', '34 Shadman Colony Lahore', '1978-05-24', 'EFU Health', 'fatima.iqbal@hotmail.com', '0303-5421456', 'fatimaiqbal78', HASHBYTES('SHA2_256', CONVERT(VARCHAR(50), 'f@t!m@#3$'))),
    ('Usman', 'Ali', '73 Defense Rd, Lahore', '1994-11-28', 'State Life', 'usman.ali@yahoo.com', '0313-4215445', 'usmanali94', HASHBYTES('SHA2_256', CONVERT(VARCHAR(50), 'Usm@n789'))),
    ('Hina', 'Riaz', '99 Model Town, Peshawar', '1989-07-30', 'Takaful Health', 'hina.riaz@aol.com', '0343-4585965', 'hinariaz89', HASHBYTES('SHA2_256', CONVERT(VARCHAR(50), 'H!na1234Riaz'))),
    ('Hania', 'Ali', '87 Gulshan-e-Iqbal, Karachi', '1972-03-15', 'Allianz Care', 'hania.ali@live.co.uk', '0333-7858698', 'haniali72', HASHBYTES('SHA2_256', CONVERT(VARCHAR(50), 'h@ni@ali99'))),
	('Mir', 'Hamza', '96 Shadman Enclave, Karachi', '1972-03-15', 'EFU', 'MirHamza99@live.com', '0333-7858698', 'Mirhamza44', HASHBYTES('SHA2_256', CONVERT(VARCHAR(50), 'H@mz@Mir'))),
	('Adam', 'Ali', '13 Bahria Town, Rawalpindi', '1972-03-15', 'Pakistan Takaful', 'AliAdam@aol.com', '0333-7858698', 'AliAdam77', HASHBYTES('SHA2_256', CONVERT(VARCHAR(50), 'Ali@Adam')))
;

INSERT INTO Departments (Name)
VALUES
    ('Cardiology'),
    ('Physiotherapy'),
    ('Orthopedics'),
    ('Gastroenterology'),
    ('Oncology'),
	('Emergency'),
	('Dental');

INSERT INTO Doctors (FullName, Specialty, DepartmentID)
VALUES
    ('Dr. Ayesha Butt', 'Cardiology', '1'),
    ('Dr. Ali Haider', 'Physiotherapy', '2'),
    ('Dr. Waqas Ahmed', 'Orthopedics', '3'),
    ('Dr. Wasim Jr.', 'Gastroenterology', '4'),
    ('Dr. Salman Ali', 'Oncology', '5'),
	('Dr. Imad Waseem.', 'Emergency', '6'),
	('Dr. Amir Ali', 'Dental', '7');
	

INSERT INTO Appointments (PatientID, DoctorID, DepartmentID, AppointmentDate, AppointmentTime, Status)
VALUES
    (1, 1, 1, CAST(GETDATE() AS DATE), '09:00:00', 'Pending'),
    (2, 2, 2, CAST(GETDATE() AS DATE), '10:30:00', 'Completed'),
    (3, 3, 3, '2024-05-03', '14:00:00', 'Pending'),
    (4, 4, 4, '2024-05-04', '11:30:00', 'Cancelled'),
    (5, 5, 5, '2024-05-07', '16:00:00', 'Pending'),
	(6, 6, 6, '2024-06-17', '16:00:00', 'Completed'),
	(7, 7, 7, '2024-07-25', '16:00:00', 'Pending');

INSERT INTO MedicalRecords (PatientID, DoctorID, Diagnosis, Medicine, MedicinePrescribedDate, Allergy)
VALUES
    (1, 1, 'Hypertension', 'Lisinopril', '2023-01-10', 'Penicillin'),
    (2, 2, 'Asthma', 'Albuterol', '2023-02-15', 'Lactose Intolerant'),
    (3, 3, 'Arthritis', 'Ibuprofen', '2023-03-20', 'Nuts'),
    (4, 4, 'Ulcer', 'Omeprazole', '2023-04-25', 'Dust Allergy'),
    (5, 5, 'Breast Cancer', 'Tamoxifen', '2023-05-30', NULL),
	(6, 6, 'Headache', 'Paracetamol', '2023-05-30', 'Pollen'),
	(6, 6, 'Flu', 'Rigix', '2023-05-30', NULL);

-- 2 Add the constraint to check that the appointment date is not in the past. 
ALTER TABLE Appointments
ADD CONSTRAINT CK_AppointmentDate
CHECK (AppointmentDate >= CAST(GETDATE() AS DATE));

-- 3 List all the patients with older than 40 and have Cancer in diagnosis. 
SELECT
    p.PatientID,
    p.FirstName,
	p.LastName,
    p.DateOfBirth,
    m.Diagnosis
FROM
    Patients p
JOIN
    MedicalRecords m ON p.PatientID = m.PatientID
WHERE DATEDIFF(YEAR, p.DateOfBirth, GETDATE()) > 40
    AND m.Diagnosis LIKE '%Cancer%';

-- 4(a) Search the database of the hospital for matching character strings by name of medicine. 
SELECT PatientID, Medicine, MedicinePrescribedDate
FROM MedicalRecords
WHERE Medicine LIKE '%%' ORDER BY MedicinePrescribedDate DESC;

-- 4 (b)(i) Return a full list of diagnosis and allergies for a specific patient who has an appointment today (Using SQL Query)
SELECT 
    m.PatientID, 
    m.Diagnosis, 
    m.Allergy
FROM 
    MedicalRecords m
JOIN 
    Appointments a ON m.PatientID = a.PatientID
WHERE 
    a.AppointmentDate = CAST(GETDATE() AS DATE);

-- 4 (b)(ii) Return a full list of diagnosis and allergies for a specific patient who has an appointment today (Using Stored Procedure)
CREATE PROCEDURE GetPatientDiagnosisAndAllergiesForToday

AS
BEGIN
    SELECT 
        m.PatientID, 
        m.Diagnosis, 
        m.Allergy
    FROM 
        MedicalRecords m
    JOIN 
        Appointments a ON m.PatientID = a.PatientID
    WHERE 
        a.AppointmentDate = CAST(GETDATE() AS DATE); 
END;

--Executing the GetPatientDiagnosisAndAllergiesForToday Stored Procedure
EXEC GetPatientDiagnosisAndAllergiesForToday;

--4 (c) Update the details for an existing doctor (using sql query)
UPDATE Doctors
SET FullName = 'Dr. Yaqoob Ali', 
    DepartmentID = 3           
WHERE DoctorID = 4;


-- 4(c) Update the details for an existing doctor (Using Stored Procedure)
-- Creating Stored Procedure
CREATE PROCEDURE DoctorInfoUpdate
    @DoctorID INT,
    @FullName VARCHAR(255) = NULL,
    @DepartmentID INT = NULL,
    @Specialty VARCHAR(255) = NULL
AS
BEGIN
    -- Updating doctor details in the Doctors table
    UPDATE Doctors
    SET FullName = COALESCE(@FullName, FullName),
        DepartmentID = COALESCE(@DepartmentID, DepartmentID),
        Specialty = COALESCE(@Specialty, Specialty)
    WHERE DoctorID = @DoctorID;
END;

--Executing the DoctorInfoUpdate Stored Procedure
EXEC DoctorInfoUpdate @DoctorID = 2, @Specialty = 'Oncology';
EXEC DoctorInfoUpdate @DoctorID = 1, @FullName = 'Dr. Raj Kumar', @DepartmentID = 4, @Specialty = 'Dermatology';

-- 4 (d) Delete the appointment who status is already completed (using sql query)
DELETE FROM Appointments
WHERE Status = 'Completed';

-- Inserting Sample data in Appointment Table to get better Result
INSERT INTO Appointments (PatientID, DoctorID, DepartmentID, AppointmentDate, AppointmentTime, Status)
VALUES (1, 2, 1, GETDATE(), '15:00:00', 'Completed');

-- 4 (d) Delete the appointment who status is already completed (using stored procedure)
CREATE PROCEDURE DeleteCompletedAppointments
AS
BEGIN
    -- Deleting records from Appointments where the status is 'Completed'
    DELETE FROM Appointments
    WHERE Status = 'Completed';
END;

EXEC DeleteCompletedAppointments;

-- Inserting Sample data in Appointment & DoctorFeedback Table to get better Result
INSERT INTO Appointments (PatientID, DoctorID, DepartmentID, AppointmentDate, AppointmentTime, Status)
VALUES (1, 2, 1, GETDATE(), '15:00:00', 'Completed');

INSERT INTO DoctorFeedback (AppointmentID, DoctorID, PatientID, Rating, Comment, FeedbackDate)
VALUES (4, 2, 1, 5, 'Excellent care and attention.', GETDATE());


-- 5 The hospitals wants to view the appointment date and time, showing all previous and current appointments for all doctors.
CREATE VIEW DoctorAppointmentDetails AS
SELECT
    a.AppointmentID,
    a.AppointmentDate,
    a.AppointmentTime,
    d.FullName AS DoctorName,
    d.Specialty,
    dep.DepartmentID,
    r.Comment AS ReviewFeedback
FROM
    Appointments a
JOIN
    Doctors d ON a.DoctorID = d.DoctorID
JOIN
    Departments dep ON d.DepartmentID = dep.DepartmentID
LEFT JOIN
    DoctorFeedback r ON a.AppointmentID = r.AppointmentID;

-- Getting the Results
SELECT *
FROM DoctorAppointmentDetails
ORDER BY AppointmentDate DESC, AppointmentTime DESC;

-- 6 Create a trigger so that the current state of an appointment can be changed to available when it is cancelled.
CREATE TRIGGER trg_UpdateStatusToAvailable1
ON Appointments
AFTER UPDATE
AS
BEGIN
    -- Check if the status has been updated to 'Cancelled'
    IF UPDATE(Status)
    BEGIN
        UPDATE a
        SET a.Status = 'Available'
        FROM Appointments a
        JOIN inserted i ON a.AppointmentID = i.AppointmentID
        JOIN deleted d ON a.AppointmentID = d.AppointmentID
        WHERE i.Status = 'Cancelled' AND d.Status <> 'Cancelled';
    END
END;

-- Updating the Status of a Appointment to Cancelled
UPDATE Appointments
SET Status = 'Cancelled'
WHERE AppointmentID = 4;

-- Checking the output
SELECT Status FROM Appointments 
WHERE AppointmentID = 4;

-- Updating the Status of AppointmentID 4 which relates to Gastroenterology to get better results
UPDATE Appointments
SET Status = 'Completed'
WHERE AppointmentID = 5;

-- 7 Write a select query which allows the hospital to identify the number of completed appointments with the specialty of doctors as ‘Gastroenterologists’. 
SELECT COUNT(*) AS CompletedAppointments
FROM Appointments a
JOIN Doctors d ON a.DoctorID = d.DoctorID
JOIN Departments dep ON d.DepartmentID = dep.DepartmentID
WHERE a.Status = 'Completed'
AND d.Specialty = 'Gastroenterology';

-- END