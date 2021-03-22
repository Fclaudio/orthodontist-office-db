-- This file contains stored procedures for managing patients in the orthodontist database. 

USE orthodontistDB
DELIMITER //


-- The createPatient procedure adds a new patient to the orthodontist database.
DROP PROCEDURE IF EXISTS createPatient//
CREATE PROCEDURE createPatient
(	
    IN  honorific       VARCHAR(255),
	IN  firstName       VARCHAR(255),
    IN  middleName      VARCHAR(255),
    IN  lastName        VARCHAR(255),
    IN  street          VARCHAR(255),
    IN  city            VARCHAR(255),
    IN  state           CHAR(2),
    IN  zipCode         VARCHAR(10),
	IN  phoneNumber     VARCHAR(255),
	IN  emailAddress    VARCHAR(255),
    IN  dateOfBirth     DATETIME,
    IN  sex				CHAR(1),
    OUT patientID       INT
)
BEGIN

	DECLARE addressID INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
	END;
    
    START TRANSACTION;
    
	INSERT INTO address (street, city, state, zipCode)
    VALUES (street, city, state, zipCode);
    
	SELECT LAST_INSERT_ID() INTO addressID;
    
	INSERT INTO individuals (honorific, firstName, middleName, lastName, mailingAddress, phoneNumber, emailAddress)
	VALUES (honorific, firstName, middleName, lastName, addressID, phoneNumber, emailAddress);
    
	SELECT LAST_INSERT_ID() INTO patientID;
    
    INSERT INTO patients (patientID, dateOfBirth, sex)
    VALUES (patientID, dateOfBirth, sex);
    
	COMMIT;

END//


-- The dropPatient procedure removes patients from the orthodontist database.
DROP PROCEDURE IF EXISTS deletePatient//
CREATE PROCEDURE deletePatient (ID INT)
BEGIN
	
    DECLARE addressIDs INT;
    DECLARE addressCount  INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
	END;
    
    START TRANSACTION;
   
	SELECT mailingAddress INTO addressIDs FROM individuals WHERE individualID = ID;
	SELECT COUNT(*) INTO addressCount FROM individuals WHERE mailingAddress = addressIDs;
    
    DELETE FROM insurance WHERE patientID = ID;
	DELETE FROM patients WHERE patientID = ID;
	DELETE FROM individuals WHERE individualID = ID;
    
    SELECT addressCount;
    
    IF addressCount = 1 THEN
		DELETE FROM address WHERE addressID = addressIDs;
	END IF;

	COMMIT;

END//


-- The addPatientInsurance procedure adds an insurance policy to a patient.
DROP PROCEDURE IF EXISTS addPatientInsurance//
CREATE PROCEDURE addPatientInsurance
(
	IN  patientID             INT,
    IN  companyID             INT,
    IN  insurancePlan         INT,
    IN  subscriptionNumber    VARCHAR(255),
    IN  expirationDate        DATE,
    IN  applicableDeductible  DECIMAL(9, 2),
    OUT insurancePolicyID     INT
)
BEGIN
	
    INSERT INTO insurance (patientID, companyID, insurancePlan, subscriptionNumber, expirationDate, applicableDeductible)
    VALUES (patientID, companyID, insurancePlan, subscriptionNumber, expirationDate, applicableDeductible);
    
    SELECT LAST_INSERT_ID() INTO insurancePolicyID;
    
END//


-- The createIndividual procedure is used to add an individual who is neither a patient nor staff nor company contact to the orthodontist database.
DROP PROCEDURE IF EXISTS createIndividual//
CREATE PROCEDURE createIndividual
(
	IN  honorific       VARCHAR(255),
	IN  firstName       VARCHAR(255),
    IN  middleName      VARCHAR(255),
    IN  lastName        VARCHAR(255),
    IN  street          VARCHAR(255),
    IN  city            VARCHAR(255),
    IN  state           CHAR(2),
    IN  zipCode         VARCHAR(10),
	IN  phoneNumber     VARCHAR(255),
	IN  emailAddress    VARCHAR(255),
    OUT individualID    INT
)
BEGIN

	DECLARE addressID INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
	END;
    
    START TRANSACTION;
    
	INSERT INTO address (street, city, state, zipCode)
    VALUES (street, city, state, zipCode);
    
	SELECT LAST_INSERT_ID() INTO addressID;
    
	INSERT INTO individuals (honorific, firstName, middleName, lastName, mailingAddress, phoneNumber, emailAddress)
	VALUES (honorific, firstName, middleName, lastName, addressID, phoneNumber, emailAddress);
    
	SELECT LAST_INSERT_ID() INTO individualID;
    
    COMMIT;
    
END//


-- The addEmergencyContact procedure adds an emergency contact to an existing patient in the orthodontist database.
DROP PROCEDURE IF EXISTS addEmergencyContact//
CREATE PROCEDURE addEmergencyContact
(
	IN contactID          INT,
    IN patientID          INT,
    IN relationToPatient  VARCHAR(255)
)
BEGIN

	INSERT INTO emergencyContacts VALUES (contactID, patientID, relationToPatient);
    
END//


-- The addPatientTreatment procedure adds a medication to an existing patient in the orthodontist database.
DROP PROCEDURE IF EXISTS addPatientTreatment//
CREATE PROCEDURE addPatientTreatment
(
	IN patientID    INT,
    IN treatmentID  INT,
    IN dateStarted  INT,
    IN orderedBy    INT,
    IN results      VARCHAR(255)
)
BEGIN

    INSERT INTO patientTreatments (patientID, treatmentID, dateStarted, orderedBy, results)
    VALUES (patientID, treatmentID, dateStarted, orderedBy, results);
    
END//


-- The addPatientCondition procedure adds the medical condition suffered by the patient to the orthodontis database.
DROP PROCEDURE IF EXISTS addPatientCondition//
CREATE PROCEDURE addPatientCondition
(
	IN patientID  INT,
    IN conditionDescription VARCHAR(255)
)
BEGIN
    INSERT INTO PatientConditions (patientID, conditionDescription)
    VALUES (patientID, conditionDescription);
END//


DELIMITER ;
