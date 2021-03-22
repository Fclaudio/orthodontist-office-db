-- This file contains sample data to populate the tables of the orthodontist database. 

-- Populate lookout tables ----------------------------------------

INSERT INTO roomsTypes (roomTypeID , roomLabel) VALUES 
(default, "X-Ray Room"), 
(default, "Waiting Room"), 
(default, "Testing Room");  

INSERT INTO rooms (roomName,  roomType, roomDescription) VALUES
("Room 104", 1, "Small room with x-ray equipment and supplies"), 
("Room 103", 2, "Small waiting area for patients"), 
("Room 102", 3, "Small room with multiple dental chairs, where most procedures are held");

INSERT INTO insurancePlans (insurancePlanName, planCoverage) VALUES
("Gold Plus", "Essential Health Services, Preventive Services, Medication Coverage, Dental Diagnostic and Preventive, All for aldults and minors"),
("Silver", "Essential Health Services, Preventive Services, Medication Coverage");

INSERT INTO treatments (treatmentName, treatmentDescription) VALUES  
("Dental Brace", "The use of devices to move teeth or adjust underlying bone."),
("Retainers", "Prevent shifting of the teeth to their previous position"),
("Jaw repositioning", "Train the jaw to close in a more favorable position");

INSERT INTO equipmentTypes (equipmentName , equipmentDescription) VALUES 
("Plastic Filling Instrument", "This instrument is used to place composite onto the mesh pad of an orthodontic bracket prior to bonding of the bracket."),
("Bracket Tweezer", "Reverse action instrument with two fine angled tips used to hold and place orthodontic brackets."), 
("Cheek Retractor", "Used to move the cheeks away from the teeth to allow for visualization and isolation of the treatment area."), 
("Band Pusher", "A band pusher is a long handled instrument with an angled rectangular serrated tip which is used for fitting and positioning an orthodontic band on a tooth."), 
("Dental X-Ray Machine", "Provide x-ray images of the patients dental area"),
("Dental Chair", "Seating aparatus for patients, which houses power for multiple dental tools, and different positions."),
("Waiting Room Chair", "Basic chair, for patients to wait for their apointment turn.");

INSERT INTO roomEquipment (roomID , equipmentID, quantity) VALUES 
(1, 1, 1),
(2, 7, 10),
(3, 6, 3),
(3, 1, 4),
(3, 3, 3);

INSERT INTO medicalSpecialties (specialtyName, specialtyDescription ) VALUES
("Orthodontist", "Treat irregularities in the teeth and jaws"),
("Registered Nurse", "Monitor, record and report symptoms or changes in patients conditions"),
("Orthodontist Assistant", "Prepare patients for treatment, and obtain their dental records.");

INSERT INTO drugs (genericName, brandName) VALUES
("Citalopram", "Celexa"),
("Glyburide", "Diabeta"),
("Furosemide", "Lasix"),
("Paroxetine", "Paxil"),
("Famotidine", "Pepcid"),
("Omeprazole", "Prilosec"),
("Albuterol", "Proventil");

INSERT INTO medications (drug, dosage, frequency) VALUES
(1, "500mg", "Twice a day"), 
(2, "500mg", "Every four hours"), 
(4, "300mg", "Every eight hours, with food"), 
(6, "100mg", "Once a day");

-- Create sample Company Types ------------------------------------
CALL createCompanyType ("Medical Supplies", @companyType1);
CALL createCompanyType ("Office Supplies", @companyType2);
CALL createCompanyType ("Insurance", @companyType3);

-- Create sample Company Contact ---------------------------------
CALL createCompanyContact ("Mr.", "Moses", "B", "Alston", "5659 Mauris Rd.", "Miami", "FL", "65763", "(828) 769-5541","rutrum@Nuncpulvinararcu.net", @companyContact1);
CALL createCompanyContact ("Mr.", "Cade", "C", "Santiago", "894-7744 Vulputate Av.", "Seattle", "WA", "80317", "(393) 986-5397", "magna.Phasellus.dolor@pharetrafelis.co.uk", @companyContact2);

-- Create sample Companies ---------------------------------------
CALL createCompany ("First Medical", @companyType3, @companyContact1, "Ap #333-2121 Aliquet, Ave", "Atlanta", "GA", "81945", "787-658-4154", "firstMedical@fmpr.com", @company1);
CALL createCompany ("Office Max", @companyType2, @companyContact2, "Ap #640-4427 Non, Rd.", "San Jose", "CA", "92117", "354-615-1547", "officeMax@OM.com", @company2);
CALL createCompany ("Panamerican", @companyType1, @companyContact2, "501-2080 Eleifend St.", "Eugene", "OR", "15099", "475-451-1571", "panamericanPR@PAPR.com", @company3);

-- Create sample patients ---------------------------------------
CALL createPatient ("Mr.", "Jake", "R", "Roberts", "567 Newport Drive", "Grand Blanc", "MI", "48439", "980-543-2765", "jroberts@gmail.com", "1985-12-03", "M", @patient1);
CALL createPatient ("Ms.", "Laura", "A", "Johnson", "501-2080 Eleifend St.", "Eugene", "OR", "15099", "374-7814", "pede@nisiAeneaneget.net", "1985-12-03", "M", @patient2);
CALL createPatient ("Miss.","Emery","Z","Park", "6242 Erat, St.","Hillsboro","OR","60516", "980-543-2765", "vestibulum.nec.euismod@Aenean.net", "1985-12-03", "F", @patient3);
CALL createPatient ("Mrs.", "Marimar", "H", "Soler", "154 Condor Drive", "Grand Line", "AR", "48545", "925-543-2765", "marimaer@gmail.com", "1985-12-03", "F", @patient4);

-- Add sample patient insurance ---------------------------------
CALL addPatientInsurance (@patient1, @company1, 1, "H00001", "2025-12-03", 500.00, @insurancePolicy1);
CALL addPatientInsurance (@patient2, @company1, 1, "H00002", "2025-12-03", 500.00, @insurancePolicy2);
CALL addPatientInsurance (@patient3, @company1, 1, "H00003", "2025-12-03", 500.00, @insurancePolicy3);
CALL addPatientInsurance (@patient4, @company1, 1, "H00004", "2025-12-03", 500.00, @insurancePolicy4);

-- Create sample individuals ---------------------------------------
CALL createIndividual ("Mr.", "Austin", "", "Johnson", "9058 Wintergreen Circle", "Greenville", "NC",  "27834",  "704-471-1235", "jsmith@gmail.com", @individual1);
CALL createIndividual ("Mrs.", "Taylor", "A", "Heath", "4 S. Rockville St.", "Owosso", "MI", "48867", "919-459-2325", "theath@gmail.com", @individual2);

-- Create emergency contacts for patients --------------------------
CALL addEmergencyContact (@individual1, @patient1, "Cousin");
CALL addEmergencyContact (@individual2, @patient3, "Cousin");

-- Add condition for patients --------------------------------------
CALL addPatientCondition(@patient2, "Underbite");
CALL addPatientCondition(@patient4, "Overbite");

-- Add staff -------------------------------------------------------
CALL createStaff ("Dr.", "Sofia", "E", "Tillman", "367-4393 Nec, Rd.", "New Haven", "CT", "83350", "980-471-2765", "jsmith@gmail.com", "Doctor", "Manager", "jsmith", "zYS$Q1$81%Fu", @staff1);
CALL createStaff ("Mr.", "Brett", "Z", "Mcclain", "Ap #375-844 Donec Avenue", "Saint Paul", "MN", "51954", "919-443-2255", "apatricks@gmail.com", "Supervisor Orthodontist", "Supervisor", "apatricks", "0B55vo*$8B%k", @staff2);
CALL createStaff ("Mrs.", "Gray", "R", "Flowers", "P.O. Box 321, 9090 Quisque Street","Owensboro","KY","51342", "704-121-3245", "tjones@gmail.com", "Receptionist", "Clerical", "tjones", "@lmko7Y*eA3W", @staff3);
CALL createStaff ("Mr.","Ahmed","H","York", "6242 Erat, St.","Hillsboro","OR","60516", "704-031-2380", "smoore@gmail.com", "Orthodontist Assistant", "Medical", "smoore", "avz^h5xZJ@Zv", @staff4);

-- Add visits for patients -------------------------------------
CALL createVisit(@patient1, "2020-10-12", "Rutinary check", @staff1, 3, 100.00, "Clean of braces and changes", @visit1);
CALL createVisit(@patient2, "2020-10-12", "Swolen gums due to braces", @staff2, 3, 200.00, "Check gums and braces", @visit2);

-- Check In patients for visits ------------------------------------
CALL checkInVisit(@visit1, "Braces were tighned and cleaned", "2021-01-12", 50.00);
CALL checkInVisit(@visit2, "Gums were dissenfected and healed", "2021-01-12", 100.00);

-- Add medication for patients -------------------------------------
 CALL addPatientTreatment(@patient1, 1, @visit1, @staff1, "Patient is in month 3 of a 18 month program, all indicates patient will finish program accordingly");
 CALL addPatientTreatment(@patient2, 2, @visit2, @staff2, "Patient is in month 3 of a 18 month program, all indicates patient will finish program accordingly");

-- Create procedure for patients -------------------------------------
CALL createProcedure(@visit1, @patient1 ,1, @procedure1);
CALL createProcedure(@visit2, @patient2 ,1, @procedure2);

-- Create prescription for patients ----------------------------------
CALL createPrescription(1, @patient1, @staff1, @visit1, 2);
CALL createPrescription(2, @patient2, @staff1, @visit2, 5);


-- These commented procedures work, are only commented so they would not
-- run automatically and delete the newly inserted data into the database

/*

-- Test Delete Company Types Procedures ----------------------------
CALL deleteCompanyType (@companyType1);
CALL deleteCompanyType (@companyType2);
CALL deleteCompanyType (@companyType3);

-- Test Delete Company Procedures ---------------------------------

CALL deleteCompany (@company1);
CALL deleteCompany (@company2);
CALL deleteCompany (@company3);

-- Test Delete Patient Procedures ---------------------------------

CALL deletePatient(@patient1);
CALL deletePatient(@patient2);
CALL deletePatient(@patient3);
CALL deletePatient(@patient4);

-- Test Delete Staff Procedures ---------------------------------

CALL deleteStaff(@staff1);
CALL deleteStaff(@staff2);
CALL deleteStaff(@staff3);
CALL deleteStaff(@staff4);
CALL deleteStaff(@staff5);

-- Test setting default roles manually ---------------------------
-- SET DEFAULT ROLE 'orthodontistDBManager' TO 'jsmith'@'localhost';
-- SET DEFAULT ROLE 'orthodontistDBSupervisor' TO 'apatricks'@'localhost';
-- SET DEFAULT ROLE 'orthodontistDBClerical' TO 'tjones'@'localhost';
-- SET DEFAULT ROLE 'orthodontistDBMedical' TO 'smoore'@'localhost';
*/