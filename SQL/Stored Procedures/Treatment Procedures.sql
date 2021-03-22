-- This file defines stored procedures for managing medical procedures in the orthodontist database. 

USE orthodontistDB;
DELIMITER //

-- The createProcedure procedure adds a new medical procedure to the orthodontist database.
DROP PROCEDURE IF EXISTS createProcedure//
CREATE PROCEDURE createProcedure
(
    IN  visit 		  INT,
    IN  patient       INT,
	IN  treatment     INT,
	OUT procedure_ID  INT
)
BEGIN
    
    DECLARE newExaminedBy  INT;
    DECLARE newExaminedIn  INT;
    
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
	END;
    
    START TRANSACTION;
	
    SELECT examinedBy INTO newExaminedBy FROM visits WHERE visitID = visit;
    SELECT examinedIn INTO newExaminedIn FROM visits WHERE visitID = visit;
    
	INSERT INTO procedures (procedure_ID, visit, patient, examinedBy, examinedIn, treatment)
    VALUES (procedure_ID, visit, patient, newExaminedBy, newExaminedIn, treatment);
	
    SELECT LAST_INSERT_ID() INTO procedure_ID;
    
	COMMIT;

END//


-- The createPrescription procedure adds a new prescription to the orthodontist database.
DROP PROCEDURE IF EXISTS createPrescription//
CREATE PROCEDURE createPrescription
(
	IN  prescriptionID     INT,
    IN  patientID          INT,
	IN  prescribedBy       INT,
	IN  datePrescribed     INT,
    IN  numberOfRefills    INT
)
BEGIN
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
	END;
    
    START TRANSACTION;
                    
    INSERT INTO prescriptions (prescriptionID, prescribedBy, patientID, datePrescribed, numberOfRefills)
    VALUES (prescriptionID, prescribedBy, patientID, datePrescribed, numberOfRefills);

	COMMIT;
    
END//


DELIMITER ;