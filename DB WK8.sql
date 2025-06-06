-- CREATE DATABASE Clinic_db;
-- USE Clinic_db;


#Create Specializations

CREATE TABLE Specialization (
    SpecializationID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE
);

-- Doctors
CREATE TABLE Doctor (
    DoctorID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(100) NOT NULL UNIQUE,
    Phone VARCHAR(20),
    SpecializationID INT,
    FOREIGN KEY (SpecializationID) REFERENCES Specialization(SpecializationID)
);

--  Patients
CREATE TABLE Patient (
    PatientID INT AUTO_INCREMENT PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Gender ENUM('Male', 'Female', 'Other'),
    Phone VARCHAR(20),
    Email VARCHAR(100) UNIQUE
);

-- Appointments
CREATE TABLE Appointment (
    AppointmentID INT AUTO_INCREMENT PRIMARY KEY,
    PatientID INT NOT NULL,
    DoctorID INT NOT NULL,
    AppointmentDate DATETIME NOT NULL,
    Reason VARCHAR(255),
    FOREIGN KEY (PatientID) REFERENCES Patient(PatientID),
    FOREIGN KEY (DoctorID) REFERENCES Doctor(DoctorID)
);

--  Prescriptions (1-1 with Appointment)
CREATE TABLE Prescription (
    PrescriptionID INT AUTO_INCREMENT PRIMARY KEY,
    AppointmentID INT NOT NULL UNIQUE,
    Notes TEXT,
    FOREIGN KEY (AppointmentID) REFERENCES Appointment(AppointmentID)
);

-- Medications
CREATE TABLE Medication (
    MedicationID INT AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(100) NOT NULL UNIQUE,
    Dosage VARCHAR(50)
);

-- Create Prescription-Medication (Many-to-Many)
CREATE TABLE PrescriptionMedication (
    PrescriptionID INT NOT NULL,
    MedicationID INT NOT NULL,
    Quantity INT NOT NULL,
    PRIMARY KEY (PrescriptionID, MedicationID),
    FOREIGN KEY (PrescriptionID) REFERENCES Prescription(PrescriptionID),
    FOREIGN KEY (MedicationID) REFERENCES Medication(MedicationID)
);
