-- This file contains stored procedures for managing companies in the orthodontist database. 

USE orthodontistDB;

DELIMITER //

-- The createCompanyType procedure adds a new company type to the orthodontist database.
DROP PROCEDURE IF EXISTS createCompanyType//
CREATE PROCEDURE createCompanyType
(	
    IN  companyLabelType    VARCHAR(255),
    OUT companyTypeID       INT
)
BEGIN

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
	END;

	START TRANSACTION;

	INSERT INTO companyTypes (label)
    VALUES (companyLabelType);
    
	SELECT LAST_INSERT_ID() INTO companyTypeID;

	COMMIT;
    
END//

-- The deleteCompanyType procedure adds a new company type to the orthodontist database
DROP PROCEDURE IF EXISTS deleteCompanyType//
CREATE PROCEDURE deleteCompanyType
(
	IN ID INT
)
BEGIN

  DECLARE EXIT HANDLER FOR SQLEXCEPTION
    
    BEGIN
        ROLLBACK;
        RESIGNAL;
	END;

	START TRANSACTION;

	DELETE FROM companyTypes WHERE companyTypeID = ID;
    
	COMMIT;
    
END//


-- The createCompanyContact procedure adds a new company contact individual to the orthodontist database.
DROP PROCEDURE IF EXISTS createCompanyContact//
CREATE PROCEDURE createCompanyContact
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


-- The createCompany procedure adds a new company to the orthodontist database.
DROP PROCEDURE IF EXISTS createCompany//
CREATE PROCEDURE createCompany
(
	IN  companyName    VARCHAR(255),
    IN  companyType    INT,
    IN  contactPerson  INT,
    IN  street 		   VARCHAR(255),
    IN  city           VARCHAR(255),
    IN  state          CHAR(2),
    IN  zipCode        VARCHAR(10),
	IN  phoneNumber    VARCHAR(255),
	IN  emailAddress   VARCHAR(255),
    OUT companyID      INT
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
    
    INSERT INTO Companies (companyName, companyTypeID, contactPerson, phoneNumber, emailAddress, mailingAddress)
	VALUES (companyName, companyType, contactPerson, phoneNumber, emailAddress, addressID);
    
	SELECT LAST_INSERT_ID() INTO companyID;
    
    COMMIT;
    
END//

-- The deleteCompany procedure removes companies from the orthodontist database.
DROP PROCEDURE IF EXISTS deleteCompany//
CREATE PROCEDURE deleteCompany 
(
	ID INT
)
BEGIN
	
    DECLARE addressIDs INT;
    DECLARE addressCount INT;

    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
	END;
    
    START TRANSACTION;
   
	SELECT mailingAddress INTO addressIDs FROM companies WHERE companyID = ID;
	SELECT COUNT(*) INTO addressCount FROM companies;
    
    SELECT addressIDs;
    SELECT addressCount;
    
	DELETE FROM companies WHERE companyID = ID;
        
    IF addressCount = 1 THEN
		DELETE FROM address WHERE addressID = addressIDs;
	END IF;
    
    COMMIT;
    
END//

DELIMITER ;