-- This file contains stored procedures for managing staff in the orthodontist database. 

DELIMITER //

-- The createStaff procedure adds new staff members to the orthodontist database.
DROP PROCEDURE IF EXISTS createStaff//
CREATE PROCEDURE createStaff
(
    IN  honorific      VARCHAR(255),
	IN  firstName      VARCHAR(255),
    IN  middleName     VARCHAR(255),
    IN  lastName       VARCHAR(255),
    IN  street         VARCHAR(255),
    IN  city           VARCHAR(255),
    IN  state          CHAR(2),
    IN  zipCode        VARCHAR(10),
	IN  phoneNumber    VARCHAR(255),
	IN  emailAddress   VARCHAR(255),
    IN  jobPosition    VARCHAR(255),
    IN  userRole       VARCHAR(255),
	IN  userLogIn      VARCHAR(255),
    IN  userPassword   VARCHAR(255),
    OUT staffID        INT
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
    
	SELECT LAST_INSERT_ID() INTO staffID;
    
    INSERT INTO staff (staffID, jobPosition, userLogIn, userRole)
    VALUES (staffID, jobPosition, userLogIn, userRole);
    
    -- Create user lon in 
    SET @createUserSQL = CONCAT('CREATE USER ', QUOTE(userLogIn), '@"localhost" IDENTIFIED BY ', QUOTE(userPassword));
	PREPARE createUserStatement FROM @createUserSQL;
	EXECUTE createUserStatement;
	DEALLOCATE PREPARE createUserStatement;
   
    -- Grant role privileges to users
 	SET @grantRoleSQL = CONCAT('GRANT ', QUOTE(CONCAT('orthodontistDB', userRole)), ' TO ', QUOTE(userLogIn), '@"localhost"');
    PREPARE grantRoleStatement FROM @grantRoleSQL;
    EXECUTE grantRoleStatement;
    DEALLOCATE PREPARE grantRoleStatement;

	SET @defaultUserRole = CONCAT('SET DEFAULT ROLE', QUOTE(CONCAT('orthodontistDB', userRole)), 'TO', QUOTE(userLogIn), '@"localhost"');
	PREPARE setDefaultUserRole FROM @defaultUserRole;
    EXECUTE setDefaultUserRole;
    DEALLOCATE PREPARE setDefaultUserRole;

END//

-- The deleteStaff procedure removes staff members from the orthodontist database.
DROP PROCEDURE IF EXISTS deleteStaff//
CREATE PROCEDURE deleteStaff (ID INT)
BEGIN
	
    DECLARE addressIDs   INT;
    DECLARE addressCount INT;
    DECLARE userLogIns    VARCHAR(32) DEFAULT NULL;
    
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;
        RESIGNAL;
	END;
    
    START TRANSACTION;
    
    SELECT userLogIn INTO userLogIns FROM staff WHERE staffID = ID;
    SELECT mailingAddress INTO addressIDs FROM individuals WHERE individualID = ID;
    SELECT COUNT(*) INTO addressCount FROM individuals WHERE mailingAddress = addressIDs;
    
    DELETE FROM staff WHERE staffID = ID;
    DELETE FROM individuals WHERE individualID = ID;
    
    IF addressCount = 1 THEN
		DELETE FROM address WHERE addressID = addressIDs;
	END IF;
	
	IF userLogIns IS NOT NULL THEN
 
        SET @dropUserSQL = CONCAT('DROP USER', QUOTE(userLogIns), '@"localhost"');
		PREPARE dropUserStatement FROM @dropUserSQL;
		EXECUTE dropUserStatement;
		DEALLOCATE PREPARE dropUserStatement;
	END IF;

	COMMIT;

END//