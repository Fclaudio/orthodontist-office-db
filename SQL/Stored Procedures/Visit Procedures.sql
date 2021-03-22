-- This file defines stored procedures for managing vists in the orthodontist database. 

DELIMITER //

-- The createVisit procedure adds a new visit to the orthodontist database.
DROP PROCEDURE IF EXISTS createVisit //
CREATE PROCEDURE createVisit
(
    IN  patientID                INT,
    IN  scheduledDateTime        DATETIME,
    IN  reasonOfVisit            VARCHAR(255),
	IN  examinedBy  	         INT,
    IN  examinedIn               INT,
    IN  totalDebts               DECIMAL(9,2),
    IN  descriptionOfServices    VARCHAR(255),
    OUT visitID                  INT
    
)
BEGIN
    
    DECLARE billID INT;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
	END;
    
    START TRANSACTION;
    
    INSERT INTO billing (totalDebt, dueDate, remainingBalance, descriptionOfServices)
	VALUES (totalDebt, NULL, NULL, descriptionOfServices);
    
	SELECT LAST_INSERT_ID() INTO billID;
    
	INSERT INTO visits (patient, scheduledDateTime, reasonOfVisit, examinedBy, examinedIn, billOfServices)
    VALUES (patientID, scheduledDateTime, reasonOfVisit, examinedBy, examinedIn, billID);
    
	SELECT LAST_INSERT_ID() INTO visitID;
    
	COMMIT;

END//


-- The checkInVisit procedure sets the check in status to "Yes" of a visit.
DROP PROCEDURE IF EXISTS checkInVisit//
CREATE PROCEDURE checkInVisit
(
	ID 					   INT,
    newResults             VARCHAR(255),
    newDueDate             DATETIME,
	newRemainingBalance    DECIMAL(9,2)
)

BEGIN

	DECLARE billIDs INT;
    DECLARE checkin CHAR(1);
	
    IF checkIn IS NULL THEN
		SET checkin = "Y";
               
	END IF;
    
	SELECT billOfServices INTO billIDs FROM visits WHERE visitID = ID;
   
	UPDATE visits
	SET results = newResults
	WHERE visitID = ID;
	
	UPDATE billing
	SET dueDate = newDueDate , remainingBalance = newRemainingBalance
	WHERE billID = billIDs;
    
	UPDATE visits 
    SET checkIn = checkin 
    WHERE visitID = ID;
    
END//

DELIMITER ;