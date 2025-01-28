-- provides information about what patient had an appointment with what therapist
SELECT P.FirstName AS Patient_FirstName, P.SurName AS Patient_SurName,
       T.FirstName AS Therapist_FirstName, T.SurName AS Therapist_SurName,
       A.AppDate AS Appointment_Date, A.AppTime AS Appointment_Time
    FROM Appointment A
    JOIN Therapist T ON A.TherapistID = T.TherapistID
    JOIN Patient P ON A.PatientID = P.PatientID;

-- proveds information about therapist and their institute in a specific city
SELECT T.FirstName AS Therapist_FirstName, T.SurName AS Therapist_SurName,
       I.InstName AS Institute_Name, I.InstAddress AS Institute_Address,
       I.City AS Institute_City
    FROM Therapist T
    JOIN Institute I ON T.InstituteID = I.InstituteID
    WHERE I.City = 'Smallcity';

-- shows time and date of available therapist (and their location)
SELECT T.FirstName AS Therapist_FirstName, T.SurName AS Therapist_SurName,
       I.InstName AS Institute_Name, A.AppDate AS Appointment_Date,
       A.AppTime AS Appointment_Time
    FROM Therapist T
    JOIN Availability Av ON T.TherapistID = Av.TherapistID
    JOIN Institute I ON T.InstituteID = I.InstituteID
    LEFT JOIN Appointment A ON T.TherapistID = A.TherapistID 
              AND Av.AvailDay = DAYOFWEEK(A.AppDate) 
              AND A.AppTime >= Av.StartTime 
              AND A.AppTime <= Av.EndTime
    WHERE A.AppointmentID IS NULL
              AND Av.AvailDay = '2024-01-14' 
              AND '12:00:00' BETWEEN Av.StartTime AND Av.EndTime;

-- shows therapist with a specific specialization and the institute they're affiliated with
SELECT T.FirstName AS Therapist_FirstName, T.SurName AS Therapist_SurName,
       T.Phone AS Therapist_Phone, T.Email AS Therapist_Email,
       I.InstName AS Institute_Name, I.InstAddress AS Institute_Address,
       I.City AS Institute_City
    FROM Therapist T
    JOIN Institute I ON T.InstituteID = I.InstituteID
    WHERE T.Specialization LIKE '%Physiotherapy';

-- counts all cancelled appointments
SELECT COUNT(*) AS Cancelled_Appointments
    FROM Appointment
    WHERE AppStatus = 'cancelled';

-- counts the total number of therapist that work in a certain institute
SELECT COUNT(*) AS Total_Therapists
    FROM Therapist
    WHERE InstituteID IN (SELECT InstituteID FROM Institute WHERE InstName = 'OsteoFit');  

-- Calculates the average duration of appointments of the therapist with ID 2
SELECT T.FirstName AS Therapist_FirstName,T.SurName AS Therapist_SurName,
       AVG(Duration) AS Average_Appointment_Time
    FROM Appointment A
    JOIN Therapist T ON A.TherapistID = T.TherapistID
    WHERE T.TherapistID = 2;

-- counts the number of patients that have an appointment over 30 min on the 12.01.2024
SELECT COUNT(DISTINCT A.PatientID) AS Patients
    FROM Appointment A
    WHERE A.AppDate = '2024-01-12' AND A.Duration > 30;

-- shows therapsit, that has free appointments on a specified day in a specified institute
SELECT T.FirstName AS Therapist_FirstName,
       T.SurName AS Therapist_SurName,
       I.InstName AS Institute_Name
    FROM Therapist T
    JOIN Institute I ON T.InstituteID = I.InstituteID
    LEFT JOIN Appointment A ON T.TherapistID = A.TherapistID
    WHERE I.InstName = 'PhysioCarl'
    AND T.TherapistID NOT IN (
        SELECT A.TherapistID
        FROM Appointment A
        WHERE A.AppDate = '2024-01-14' OR A.AppDate = '2024-01-16'
    ); 

-- shows therapist with the least amount of appointments
SELECT T.FirstName AS Therapist_FirstName, T.SurName AS Therapist_SurName,
       COUNT(*) AS Total_Appointments
    FROM Appointment A
    JOIN Therapist T ON A.TherapistID = T.TherapistID
    GROUP BY T.FirstName, T.SurName
    HAVING COUNT(*) = (SELECT MIN(AppointmentCount) FROM (SELECT COUNT(*) AS AppointmentCount FROM Appointment GROUP BY TherapistID) AS Number_Appointments);
