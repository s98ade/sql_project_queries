CREATE TABLE Patient (
    PatientID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(32),
    SurName VARCHAR(32),
    Phone VARCHAR(10),
    PatAddress VARCHAR(32),
    City VARCHAR(32),
    Email VARCHAR(32)
);

INSERT INTO Patient (FirstName, SurName, Phone, PatAddress, City, Email)
VALUES 
('John', 'Don', '0263846523', 'Leibnitz street 23 A', 'Smallcity', 'john.don@exp.com'),
('Ella', 'Gross', '0495886722', 'Small-Avenue 13', 'Smallcity', 'gross@exp.com'),
('Bob', 'Harlli', '0209384756', 'Fishers-Alley 2', 'Smallcity', 'HarlliBob@exp.com'),
('Mikko', 'Smith', '0776354228', 'Bayside 123 B', 'Smallcity', 'MikkoTheSmith@exp.com'),
('Alf', 'Alfsson', '0223748593', 'Riverside 34', 'Smallcity', 'Alf@exp.com');


CREATE TABLE Institute (
    InstituteID INT PRIMARY KEY AUTO_INCREMENT,
    InstName VARCHAR(32),
    InstAddress VARCHAR(32),
    City VARCHAR(32),
    Phone VARCHAR(10),
    Webpage VARCHAR(32)
);

INSERT INTO Institute (InstName, InstAddress, City, Phone, Webpage)
VALUES 
('OsteoHealth', 'Bayside 2', 'Smallcity', '0555362271', 'Osteohealth.com'),
('Osteopathy Adams', 'At-the-tree-street 24', 'Smallcity', '0847362732', 'Osteoadmas.com'),
('OsteoFit', 'Alfred-Wisman-Avenue 423 B', 'Smallcity', '0857463527', 'Osteofit.com'),
('PhysioCarl', 'Lerchen-path 2', 'Smallcity', '0555334421', 'Physiocarl.com'),
('OsteoPhyt', 'Big-Avenue 23', 'Smallcity', '0987653421', 'Osteophyt.com');

CREATE TABLE Therapist (
    TherapistID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(32),
    SurName VARCHAR(32),
    Phone VARCHAR(10),
    Email VARCHAR(32),
    InstituteID INT,
    Specialization VARCHAR(32),

    FOREIGN KEY (InstituteID) REFERENCES Institute(InstituteID)
);

INSERT INTO Therapist (FirstName, SurName, Phone, Email, InstituteID, Specialization)
VALUES 
('Carl', 'Jacson', '0123456789', 'jacson@osteoadams.com', 2, 'Osteopathy, Physiotherapy'),
('Jessy', 'Jacsson', '0123427891', 'jessy_jacsson@example.com', 4, 'Osteopathy, Shoulder'),
('Betty', 'Martin', '0234456789', 'martin@osteoadams.com', 2, 'Osteopathy, Sport-Therapy'),
('Albert', 'Twogem', '0122226789', 'albert.twogem@osteophyt', 5, 'Osteopathy, Physiotherapy'),
('Isa', 'Bella', '0773499789', 'bella@osteofit.com', 3, 'Osteopathy, Trauma-Recovery');

CREATE TABLE Appointment (
    AppointmentID INT PRIMARY KEY AUTO_INCREMENT,
    PatientID INT,
    TherapistID INT,
    AppDate DATE,
    AppTime TIME,
    Duration INT,
    AppStatus VARCHAR(32),
    Comments TEXT,

    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (TherapistID) REFERENCES Therapist(TherapistID)
);

INSERT INTO Appointment (PatientID, TherapistID, AppDate, AppTime, Duration, AppStatus, Comments)
VALUES 
(1, 2, '2024-01-12', '13:30:00', 30, 'completed', NULL),
(2, 2, '2024-01-12', '14:00:00', 30, 'completed', 'Patient recieved exercises for home'),
(3, 5, '2024-01-12', '14:30:00', 60, 'completed', 'Improving of left shoulder mobility'),
(1, 2, '2024-01-13', '12:00:00', 0, 'cancelled', NULL),
(1, 2, '2024-01-13', '13:30:00', 45, 'scheduled', NULL);

CREATE TABLE Availability (
    AvailabilityID INT PRIMARY KEY AUTO_INCREMENT,
    TherapistID INT,
    AvailDay DATE,
    StartTime TIME,
    EndTime TIME,

    FOREIGN KEY (TherapistID) REFERENCES Therapist(TherapistID)
);

INSERT INTO Availability (TherapistID, AvailDay, StartTime, EndTime)
VALUES 
(1, '2024-01-14', '10:00:00', '16:00:00'),
(2, '2024-01-14', '09:00:00', '16:00:00'),
(3, '2024-01-15', '10:00:00', '18:00:00'),
(1, '2024-01-16', '11:00:00', '19:00:00'),
(5, '2024-01-16', '09:00:00', '16:00:00');
