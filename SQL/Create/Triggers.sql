-- This file contains all the querys to create all the triggers for the orthodontist database. 

-- Triggers to audit all modifications to all tables
-- Including insert, update, delete, query for each table

-- See all triggers in the database
SHOW TRIGGERS IN orthodontistDB;

-- Use the database to ensure the triggers are being created insided of our database
USE orthodontistDB;
DELIMITER //

-- Address Triggers  ===========================================================================================================

-- Address Insert Trigger 
DROP TRIGGER IF EXISTS addressInsert//
CREATE TRIGGER addressInsert
	AFTER INSERT ON address
    FOR EACH ROW 
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'address', 'addressID', NULL, NEW.addressID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'address', 'street', NULL, NEW.street);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'address', 'city', NULL, NEW.city);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'address', 'state', NULL, NEW.state);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'address', 'zipcode', NULL, NEW.zipCode);
END//

-- Address Update Trigger 
DROP TRIGGER IF EXISTS addressUpdate//
CREATE TRIGGER addressUpdate
	AFTER UPDATE ON address
    FOR EACH ROW 
BEGIN
	IF OLD.addressID <> NEW.addressID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'address', 'addressID', OLD.addressID, NEW.addressID);
			ELSEIF OLD.street <> NEW.street THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'address', 'street', OLD.street, NEW.street);
			ELSEIF OLD.city <> NEW.city THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'address', 'city', OLD.city, NEW.city);
			ELSEIF OLD.state <> NEW.state THEN
        INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'address', 'state', OLD.state, NEW.state);
			ELSEIF OLD.zipCode <> NEW.zipCode THEN
       INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'address', 'zipcode', OLD.zipCode, NEW.zipCode);
	END IF;
END//

-- Address Delete Trigger 
DROP TRIGGER IF EXISTS addressDelete//
CREATE TRIGGER addressDelete
	AFTER DELETE ON address
    FOR EACH ROW 
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'address', 'addressID', OLD.addressID, null);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'address', 'street', OLD.street, null);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'address', 'city', OLD.city, null);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'address', 'state', OLD.state, null);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'address', 'zipcode', OLD.zipCode, null);
END//

-- Billing Triggers  ===========================================================================================================

-- Billing Insert Trigger 
DROP TRIGGER IF EXISTS billingInsert//
CREATE TRIGGER billingInsert
	AFTER INSERT ON billing
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'billing', 'billID', NULL, NEW.billID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'billing', 'totalDebt', NULL, NEW.totalDebt);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'billing', 'dueDate', NULL, NEW.dueDate);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'billing', 'remainingBalance', NULL, NEW.remainingBalance);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'billing', 'descriptionOfServices', NULL, NEW.descriptionOfServices);
END//

-- Billing Update Trigger 
DROP TRIGGER IF EXISTS billingUpdate//
CREATE TRIGGER billingUpdate
	AFTER UPDATE ON billing
    FOR EACH ROW
BEGIN
	IF OLD.billID <> NEW.billID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'billing', 'billID', OLD.billID, NEW.billID);
			ELSEIF OLD.totalDebt <> NEW.totalDebt THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'billing', 'billID', OLD.totalDebt, NEW.totalDebt);
			ELSEIF OLD.dueDate <> NEW.dueDate THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'billing', 'billID', OLD.dueDate, NEW.dueDate);
			ELSEIF OLD.remainingBalance <> NEW.remainingBalance THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'billing', 'billID', OLD.remainingBalance, NEW.remainingBalance);
			ELSEIF OLD.descriptionOfServices <> NEW.descriptionOfServices THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'billing', 'descriptionOfServices', NULL, NEW.descriptionOfServices);
	END IF;
END//

-- Billing Delete Trigger 
DROP TRIGGER IF EXISTS billingDelete//
CREATE TRIGGER billingDelete
	AFTER DELETE ON billing
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'billing', 'billID', OLD.billID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'billing', 'totalDebt', OLD.totalDebt, NULL);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'billing', 'dueDate', OLD.dueDate, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'billing', 'remainingBalance', OLD.remainingBalance, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'billing', 'descriptionOfServices', OLD.descriptionOfServices, NULL);
END//

-- Companies Triggers  ===========================================================================================================

-- Companies Insert Trigger 
DROP TRIGGER IF EXISTS companiesInsert//
CREATE TRIGGER companiesInsert
	AFTER INSERT ON companies
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'companies', 'companyID', NULL, NEW.companyID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'companies', 'companyName', NULL, NEW.companyName);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'companies', 'companyTypeID', NULL, NEW.companyTypeID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'companies', 'contactPerson', NULL, NEW.contactPerson);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'companies', 'phoneNumber', NULL, NEW.phoneNumber);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'companies', 'emailAddress', NULL, NEW.emailAddress);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'companies', 'mailingAddress', NULL, NEW.mailingAddress);
END//

-- Companies Update Trigger 
DROP TRIGGER IF EXISTS companiesUpdate//
CREATE TRIGGER companiesUpdate
	AFTER UPDATE ON companies
    FOR EACH ROW
BEGIN
	IF OLD.companyID <> NEW.companyID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'companies', 'companyID', OLD.companyID, NEW.companyID);
			ELSEIF OLD.companyName <> NEW.companyName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'companies', 'companyName', OLD.companyName, NEW.companyName);
			ELSEIF OLD.companyTypeID <> NEW.companyTypeID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'companies', 'companyTypeID', OLD.companyTypeID, NEW.companyTypeID);
			ELSEIF OLD.contactPerson <> NEW.contactPerson THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'companies', 'contactPerson', OLD.contactPerson, NEW.contactPerson);
			ELSEIF OLD.phoneNumber <> NEW.phoneNumber THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'companies', 'phoneNumber', OLD.phoneNumber, NEW.phoneNumber);
            ELSEIF OLD.emailAddress <> NEW.emailAddress THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'companies', 'emailAddress', OLD.emailAddress, NEW.emailAddress);
            ELSEIF OLD.mailingAddress <> NEW.mailingAddress THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'companies', 'mailingAddress', OLD.mailingAddress, NEW.mailingAddress);
	END IF;
END//

-- Companies Delete Trigger 
DROP TRIGGER IF EXISTS companiesDelete//
CREATE TRIGGER companiesDelete
	AFTER DELETE ON companies
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'companies', 'companyID', OLD.companyID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'companies', 'companyName', OLD.companyName, NULL);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'companies', 'companyTypeID', OLD.companyTypeID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'companies', 'contactPerson', OLD.NEW.contactPerson, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'companies', 'phoneNumber', OLD.NEW.phoneNumber, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'companies', 'emailAddress', OLD.emailAddress, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'companies', 'mailingAddress', OLD.mailingAddress, NULL);
END//

-- CompanyTypes Triggers ===========================================================================================================

-- CompanyTypes Insert Trigger 
DROP TRIGGER IF EXISTS companyTypesInsert//
CREATE TRIGGER companyTypesInsert
	AFTER INSERT ON companyTypes
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'companyTypes', 'companyTypeID', NULL, NEW.companyTypeID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'companyTypes', 'label', NULL, NEW.label);
END//

-- CompanyTypes Update Trigger 
DROP TRIGGER IF EXISTS companyTypesUpdate//
CREATE TRIGGER companyTypesUpdate
	AFTER UPDATE ON companyTypes
    FOR EACH ROW
BEGIN
	IF OLD.companyTypeID <> NEW.companyTypeID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'companyTypes', 'companyTypeID', OLD.companyTypeID, NEW.companyTypeID);
			ELSEIF OLD.label <> NEW.label THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'companyTypes', 'label', OLD.label, NEW.label);
	END IF;
END//

-- CompanyTypes Delete Trigger 
DROP TRIGGER IF EXISTS companyTypesDelete//
CREATE TRIGGER companyTypesDelete
	AFTER DELETE ON companyTypes
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'companyTypes', 'companyTypeID', OLD.companyTypeID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'companyTypes', 'label', OLD.label, NULL);
END//

-- Drugs Triggers ===========================================================================================================

-- Drugs Insert Trigger 
DROP TRIGGER IF EXISTS drugsInsert//
CREATE TRIGGER drugsInsert
	AFTER INSERT ON drugs
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'drugs', 'drugID', NULL, NEW.drugID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'drugs', 'genericName', NULL, NEW.genericName);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'drugs', 'brandName', NULL, NEW.brandName);
END//

-- Drugs Update Trigger 
DROP TRIGGER IF EXISTS drugsUpdate//
CREATE TRIGGER drugsUpdate
	AFTER UPDATE ON drugs
    FOR EACH ROW
BEGIN
	IF OLD.drugID <> NEW.drugID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'drugs', 'drugID', OLD.drugID, NEW.drugID);
			ELSEIF OLD.genericName <> NEW.genericName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'drugs', 'genericName', OLD.genericName, NEW.genericName);
			ELSEIF OLD.brandName <> NEW.brandName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'drugs', 'brandName', OLD.brandName, NEW.brandName);
	END IF;
END//

-- Drugs Delete Trigger 
DROP TRIGGER IF EXISTS drugsDelete//
CREATE TRIGGER drugsDelete
	AFTER DELETE ON drugs
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'drugs', 'drugID', OLD.drugID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'drugs', 'genericName', OLD.genericName, NULL);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'drugs', 'brandName', OLD.brandName, NULL);
END//

-- Emergency Contacts Triggers ===========================================================================================================

-- Emergency Contacts Insert Trigger 
DROP TRIGGER IF EXISTS emergencyContactsInsert//
CREATE TRIGGER emergencyContactsInsert
	AFTER INSERT ON emergencyContacts
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'emergencyContacts', 'contactID', NULL, NEW.contactID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'emergencyContacts', 'patientID', NULL, NEW.patientID);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'emergencyContacts', 'relationToPatient', NULL, NEW.relationToPatient);
END//

-- Emergency Contacts Update Trigger 
DROP TRIGGER IF EXISTS emergencyContactsUpdate//
CREATE TRIGGER emergencyContactsUpdate
	AFTER UPDATE ON emergencyContacts
    FOR EACH ROW
BEGIN
	IF OLD.contactID <> NEW.contactID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'emergencyContacts', 'contactID', OLD.contactID, NEW.contactID);
			ELSEIF OLD.patientID <> NEW.patientID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'emergencyContacts', 'patientID', OLD.patientID, NEW.patientID);
			ELSEIF OLD.relationToPatient <> NEW.relationToPatient THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'emergencyContacts', 'relationToPatient', OLD.relationToPatient, NEW.relationToPatient);
	END IF;
END//

-- Emergency Contacts Delete Trigger 
DROP TRIGGER IF EXISTS emergencyContactsDelete//
CREATE TRIGGER emergencyContactsDelete
	AFTER DELETE ON emergencyContacts
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'emergencyContacts', 'contactID', OLD.contactID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'emergencyContacts', 'patientID', OLD.patientID, NULL);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'emergencyContacts', 'relationToPatient', OLD.relationToPatient, NULL);
END//

-- Equipment Types Triggers ===========================================================================================================

-- Equipment Types Insert Trigger 
DROP TRIGGER IF EXISTS equipmentTypesInsert//
CREATE TRIGGER equipmentTypesInsert
	AFTER INSERT ON equipmentTypes
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'equipmentTypes', 'equipmentID', NULL, NEW.equipmentID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'equipmentTypes', 'equipmentName', NULL, NEW.equipmentName);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'equipmentTypes', 'equipmentDescription', NULL, NEW.equipmentDescription);
END//

-- Equipment Types Update Trigger 
DROP TRIGGER IF EXISTS equipmentTypesUpdate//
CREATE TRIGGER equipmentTypesUpdate
	AFTER UPDATE ON equipmentTypes
    FOR EACH ROW
BEGIN
	IF OLD.equipmentID <> NEW.equipmentID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'equipmentTypes', 'equipmentID', OLD.equipmentID, NEW.equipmentID);
			ELSEIF OLD.equipmentName <> NEW.equipmentName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'equipmentTypes', 'equipmentName', OLD.equipmentName, NEW.equipmentName);
			ELSEIF OLD.equipmentDescription <> NEW.equipmentDescription THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'equipmentTypes', 'equipmentDescription', OLD.equipmentDescription, NEW.equipmentDescription);
	END IF;
END//

-- Equipment Types Delete Trigger 
DROP TRIGGER IF EXISTS equipmentTypesDelete//
CREATE TRIGGER equipmentTypesDelete
	AFTER DELETE ON equipmentTypes
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'emergencyContacts', 'contactID', OLD.equipmentID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'emergencyContacts', 'patientID', OLD.equipmentName, NULL);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'emergencyContacts', 'relationToPatient', OLD.equipmentDescription, NULL);
END//

-- Individuals Triggers ===========================================================================================================

-- Individuals Insert Trigger 
DROP TRIGGER IF EXISTS individualsInsert//
CREATE TRIGGER individualsInsert
	AFTER INSERT ON individuals
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'individuals', 'individualID', NULL, NEW.individualID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'individuals', 'honorific', NULL, NEW.honorific);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'individuals', 'firstName', NULL, NEW.firstName);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'individuals', 'middleName', NULL, NEW.middleName);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'individuals', 'lastName', NULL, NEW.lastName);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'individuals', 'mailingAddress', NULL, NEW.mailingAddress);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'individuals', 'phoneNumber', NULL, NEW.phoneNumber);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'individuals', 'emailAddress', NULL, NEW.emailAddress);
END//

-- Individuals Update Trigger 
DROP TRIGGER IF EXISTS individualsUpdate//
CREATE TRIGGER individualsUpdate
	AFTER UPDATE ON individuals
    FOR EACH ROW
BEGIN
	IF OLD.individualID <> NEW.individualID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'individuals', 'individualID', OLD.individualID, NEW.individualID);
            ELSEIF OLD.honorific <> NEW.honorific THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'individuals', 'honorific', OLD.honorific, NEW.honorific);
            ELSEIF OLD.firstName <> NEW.firstName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'individuals', 'firstName', OLD.firstName, NEW.firstName);
            ELSEIF OLD.middleName <> NEW.middleName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'individuals', 'middleName', OLD.middleName, NEW.middleName);
            ELSEIF OLD.lastName <> NEW.lastName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'individuals', 'lastName', OLD.lastName, NEW.lastName);
            ELSEIF OLD.mailingAddress <> NEW.mailingAddress THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'individuals', 'mailingAddress', OLD.mailingAddress, NEW.mailingAddress);
            ELSEIF OLD.phoneNumber <> NEW.phoneNumber THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'individuals', 'phoneNumber', OLD.phoneNumber, NEW.phoneNumber);
            ELSEIF OLD.emailAddress <> NEW.emailAddress THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'individuals', 'emailAddress', OLD.emailAddress, NEW.emailAddress);
	END IF;
END//

-- Individuals Delete Trigger 
DROP TRIGGER IF EXISTS individualsDelete//
CREATE TRIGGER individualsDelete
	AFTER DELETE ON individuals
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'individuals', 'individualID', OLD.individualID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'individuals', 'honorific', OLD.honorific, NULL);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'individuals', 'firstName', OLD.firstName, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'individuals', 'middleName', OLD.middleName, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'individuals', 'lastName', OLD.lastName, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'individuals', 'mailingAddress', OLD.mailingAddress, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'individuals', 'phoneNumber', OLD.phoneNumber, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'individuals', 'emailAddress', OLD.emailAddress, NULL);
END//

-- Insurance Triggers ===========================================================================================================

-- Insurance Insert Trigger 
DROP TRIGGER IF EXISTS insuranceInsert//
CREATE TRIGGER insuranceInsert
	AFTER INSERT ON insurance
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'insurance', 'insurancePolicyID', NULL, NEW.insurancePolicyID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'insurance', 'patientID', NULL, NEW.patientID);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'insurance', 'companyID', NULL, NEW.companyID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'insurance', 'insurancePlan', NULL, NEW.insurancePlan);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'insurance', 'subscriptionNumber', NULL, NEW.subscriptionNumber);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'insurance', 'experationDate', NULL, NEW.expirationDate);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'insurance', 'applicableDeductible', NULL, NEW.applicableDeductible);
END//

-- Insurance Update Trigger 
DROP TRIGGER IF EXISTS insuranceUpdate//
CREATE TRIGGER insuranceUpdate
	AFTER UPDATE ON insurance
    FOR EACH ROW
BEGIN
	IF OLD.insurancePolicyID <> NEW.insurancePolicyID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'insurance', 'insurancePolicyID', OLD.insurancePolicyID, NEW.insurancePolicyID);
            ELSEIF OLD.patientID <> NEW.patientID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'insurance', 'patientID', OLD.patientID, NEW.patientID);
            ELSEIF OLD.companyID <> NEW.companyID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'insurance', 'companyID', OLD.companyID, NEW.companyID);
            ELSEIF OLD.insurancePlan <> NEW.insurancePlan THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'insurance', 'insurancePlan', OLD.insurancePlan, NEW.insurancePlan);
            ELSEIF OLD.subscriptionNumber <> NEW.subscriptionNumber THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'insurance', 'subscriptionNumber', OLD.subscriptionNumber, NEW.subscriptionNumber);
            ELSEIF OLD.expirationDate <> NEW.expirationDate THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'insurance', 'experationDate', OLD.expirationDate, NEW.expirationDate);
            ELSEIF OLD.applicableDeductible <> NEW.applicableDeductible THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'insurance', 'applicableDeductibler', OLD.applicableDeductible, NEW.applicableDeductible);
	END IF;
END//

-- Insurance Delete Trigger 
DROP TRIGGER IF EXISTS insuranceDelete//
CREATE TRIGGER insuranceDelete
	AFTER DELETE ON insurance
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'insurance', 'insurancePolicyID', OLD.insurancePolicyID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'insurance', 'patientID', OLD.patientID, NULL);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'insurance', 'companyID', OLD.companyID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'insurance', 'insurancePlan', OLD.insurancePlan, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'insurance', 'subscriptionNumber', OLD.subscriptionNumber, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'insurance', 'experationDate', OLD.expirationDate, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'insurance', 'applicableDeductibler', OLD.applicableDeductible, NULL);
END//

-- Insurance Plans Triggers ===========================================================================================================

-- Insurance Plans Insert Trigger 
DROP TRIGGER IF EXISTS insurancePlansInsert//
CREATE TRIGGER insurancePlansInsert
	AFTER INSERT ON insurancePlans
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'insurancePlans', 'insurancePlanID', NULL, NEW.insurancePlanID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'insurancePlans', 'insurancePlanName', NULL, NEW.insurancePlanName);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'insurancePlans', 'planCoverage', NULL, NEW.planCoverage);
END//

-- Insurance Plan Update Trigger 
DROP TRIGGER IF EXISTS insurancePlanUpdate//
CREATE TRIGGER insurancePlanUpdate
	AFTER UPDATE ON insurancePlans
    FOR EACH ROW
BEGIN
	IF OLD.insurancePlanID <> NEW.insurancePlanID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'insurancePlans', 'insurancePlanID', OLD.insurancePlanID, NEW.insurancePlanID);
            ELSEIF OLD.insurancePlanName <> NEW.insurancePlanName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'insurancePlans', 'insurancePlanName', OLD.insurancePlanName, NEW.insurancePlanName);
            ELSEIF OLD.planCoverage <> NEW.planCoverage THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'insurancePlans', 'planCoverage', OLD.planCoverage, NEW.planCoverage);
	END IF;
END//

-- Insurance Plan Delete Trigger 
DROP TRIGGER IF EXISTS insurancePlanDelete//
CREATE TRIGGER insurancePlanDelete
	AFTER DELETE ON insurancePlans
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'insurancePlans', 'insurancePlanID', OLD.insurancePlanID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'insurancePlans', 'insurancePlanName', OLD.insurancePlanName, NULL);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'insurancePlans', 'planCoverage', OLD.planCoverage, NULL);
END//

-- Medical Specialties Triggers ===========================================================================================================

-- Medical Specialties Insert Trigger 
DROP TRIGGER IF EXISTS medicalSpecialtiesInsert//
CREATE TRIGGER medicalSpecialtiesInsert
	AFTER INSERT ON medicalSpecialties
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'medicalSpecialties', 'specialtyID', NULL, NEW.specialtyID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'medicalSpecialties', 'specialtyName', NULL, NEW.specialtyName);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'medicalSpecialties', 'specialtyDescription', NULL, NEW.specialtyDescription);
END//

-- Medical Specialties Update Trigger 
DROP TRIGGER IF EXISTS medicalSpecialtiesUpdate//
CREATE TRIGGER medicalSpecialtiesUpdate
	AFTER UPDATE ON medicalSpecialties
    FOR EACH ROW
BEGIN
	IF OLD.specialtyID <> NEW.specialtyID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'medicalSpecialties', 'specialtyID', OLD.specialtyID, NEW.specialtyID);
            ELSEIF OLD.specialtyName <> NEW.specialtyName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'medicalSpecialties', 'specialtyName', OLD.specialtyName, NEW.specialtyName);
            ELSEIF OLD.specialtyDescription <> NEW.specialtyDescription THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'medicalSpecialties', 'specialtyDescription', OLD.specialtyDescription, NEW.specialtyDescription);
	END IF;
END//

-- Medical Specialties Delete Trigger 
DROP TRIGGER IF EXISTS medicalSpecialtiesDelete//
CREATE TRIGGER medicalSpecialtiesDelete
	AFTER DELETE ON medicalSpecialties
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'medicalSpecialties', 'specialtyID', OLD.specialtyID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'medicalSpecialties', 'specialtyName', OLD.specialtyName, NULL);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'medicalSpecialties', 'specialtyDescription', OLD.specialtyDescription, NULL);
END//

-- Medications Triggers ===========================================================================================================

-- Medications Insert Trigger 
DROP TRIGGER IF EXISTS medicationsInsert//
CREATE TRIGGER medicationsInsert
	AFTER INSERT ON medications
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'medications', 'medicationID', NULL, NEW.medicationID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'medications', 'drug', NULL, NEW.drug);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'medications', 'dosage', NULL, NEW.dosage);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'medications', 'frequency', NULL, NEW.frequency);
END//

-- Medications Update Trigger 
DROP TRIGGER IF EXISTS medicationsUpdate//
CREATE TRIGGER medicationsUpdate
	AFTER UPDATE ON medications
    FOR EACH ROW
BEGIN
	IF OLD.medicationID <> NEW.medicationID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'medications', 'medicationID', OLD.medicationID, NEW.medicationID);
            ELSEIF OLD.drug <> NEW.drug THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'medications', 'drug', OLD.drug, NEW.drug);
            ELSEIF OLD.dosage <> NEW.dosage THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'medications', 'dosage', OLD.dosage, NEW.dosage);
			ELSEIF OLD.frequency <> NEW.frequency THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'medications', 'frequency', OLD.frequency, NEW.frequency);
	END IF;
END//

-- Medications Delete Trigger 
DROP TRIGGER IF EXISTS medicationsDelete//
CREATE TRIGGER medicationsDelete
	AFTER DELETE ON medications
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'medications', 'medicationID', OLD.medicationID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'medications', 'drug', OLD.drug, NULL);
    INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'medications', 'dosage', OLD.dosage, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'medications', 'frequency', OLD.frequency, NULL);
END//

-- Patient Conditions Triggers ===========================================================================================================

-- Patient Conditions Insert Trigger 
DROP TRIGGER IF EXISTS patientConditionsInsert//
CREATE TRIGGER patientConditionsInsert
	AFTER INSERT ON patientConditions
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'patientConditions', 'patientID', NULL, NEW.patientID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'patientConditions', 'conditionDescription', NULL, NEW.conditionDescription);
END//

-- Patient Conditions Update Trigger 
DROP TRIGGER IF EXISTS patientConditionsUpdate//
CREATE TRIGGER patientConditionsUpdate
	AFTER UPDATE ON patientConditions
    FOR EACH ROW
BEGIN
	IF OLD.patientID <> NEW.patientID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'patientConditions', 'patientID', OLD.patientID, NEW.patientID);
            ELSEIF OLD.conditionDescription <> NEW.conditionDescription THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'patientConditions', 'conditionDescription', OLD.conditionDescription, NEW.conditionDescription);
	END IF;
END//

-- Patient Conditions Delete Trigger 
DROP TRIGGER IF EXISTS patientConditionsDelete//
CREATE TRIGGER patientConditionsDelete
	AFTER DELETE ON patientConditions
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'patientConditions', 'patientID', OLD.patientID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'patientConditions', 'conditionDescription', OLD.conditionDescription, NULL);
END//

-- Patients Triggers ===========================================================================================================

-- Patients Insert Trigger 
DROP TRIGGER IF EXISTS patientsInsert//
CREATE TRIGGER patientsInsert
	AFTER INSERT ON patients
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'patients', 'patientID', NULL, NEW.patientID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'patients', 'dateOfBirth', NULL, NEW.dateOfBirth);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'patients', 'sex', NULL, NEW.sex);
END//

-- Patients Update Trigger 
DROP TRIGGER IF EXISTS patientsUpdate//
CREATE TRIGGER patientsUpdate
	AFTER UPDATE ON patients
    FOR EACH ROW
BEGIN
	IF OLD.patientID <> NEW.patientID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'patients', 'patientID', OLD.patientID, NEW.patientID);
            ELSEIF OLD.dateOfBirth <> NEW.dateOfBirth THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'patients', 'dateOfBirth', OLD.dateOfBirth, NEW.dateOfBirth);
            ELSEIF OLD.sex <> NEW.sex THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'patients', 'sex', OLD.sex, NEW.sex);
	END IF;
END//

-- Patients Delete Trigger 
DROP TRIGGER IF EXISTS patientsDelete//
CREATE TRIGGER patientsDelete
	AFTER DELETE ON patients
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'patients', 'patientID', OLD.patientID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'patients', 'dateOfBirth', OLD.dateOfBirth, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'patients', 'sex', OLD.sex, NULL);
END//

-- Patients Treatments Triggers ===========================================================================================================

-- Patients Treatments Insert Trigger 
DROP TRIGGER IF EXISTS patientTreatmentsInsert//
CREATE TRIGGER patientTreatmentsInsert
	AFTER INSERT ON patientTreatments
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'patientTreatments', 'patientID', NULL, NEW.patientID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'patientTreatments', 'treatmentID', NULL, NEW.treatmentID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'patientTreatments', 'dateStarted', NULL, NEW.dateStarted);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'patientTreatments', 'orderedBy', NULL, NEW.orderedBy);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'patientTreatments', 'results', NULL, NEW.results);
END//

-- Patients Treatments Update Trigger 
DROP TRIGGER IF EXISTS patientTreatmentsUpdate//
CREATE TRIGGER patientTreatmentsUpdate
	AFTER UPDATE ON patientTreatments
    FOR EACH ROW
BEGIN
	IF OLD.patientID <> NEW.patientID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'patientTreatments', 'patientID', OLD.patientID, NEW.patientID);
            ELSEIF OLD.treatmentID <> NEW.treatmentID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'patientTreatments', 'treatmentID', OLD.treatmentID, NEW.treatmentID);
            ELSEIF OLD.dateStarted <> NEW.dateStarted THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'patientTreatments', 'dateStarted', OLD.dateStarted, NEW.dateStarted);
            ELSEIF OLD.orderedBy <> NEW.orderedBy THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'patientTreatments', 'orderedBy', OLD.orderedBy, NEW.orderedBy);
            ELSEIF OLD.results <> NEW.results THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'patientTreatments', 'results', OLD.results, NEW.results);
	END IF;
END//

-- Patients Treatments Delete Trigger 
DROP TRIGGER IF EXISTS patientTreatmentsDelete//
CREATE TRIGGER patientTreatmentsDelete
	AFTER DELETE ON patientTreatments
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'patientTreatments', 'patientID', OLD.patientID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'patientTreatments', 'treatmentID', OLD.treatmentID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'patientTreatments', 'dateStarted', OLD.dateStarted, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'patientTreatments', 'orderedBy', OLD.orderedBy, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'patientTreatments', 'results', OLD.results, NULL);
END//

-- Prescriptions Triggers ===========================================================================================================

-- Prescriptions Insert Trigger 
DROP TRIGGER IF EXISTS prescriptionsInsert//
CREATE TRIGGER prescriptionsInsert
	AFTER INSERT ON prescriptions
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'prescriptions', 'prescriptionID', NULL, NEW.prescriptionID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'prescriptions', 'prescribedBy', NULL, NEW.prescribedBy);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'prescriptions', 'patientID', NULL, NEW.patientID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'prescriptions', 'datePrescribed', NULL, NEW.datePrescribed);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'prescriptions', 'numberOfRefills', NULL, NEW.numberOfRefills);
END//

-- Prescriptions Update Trigger 
DROP TRIGGER IF EXISTS prescriptionsUpdate//
CREATE TRIGGER prescriptionsUpdate
	AFTER UPDATE ON prescriptions
    FOR EACH ROW
BEGIN
	IF OLD.prescriptionID <> NEW.prescriptionID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'prescriptions', 'prescriptionID', OLD.prescriptionID, NEW.prescriptionID);
            ELSEIF OLD.prescribedBy <> NEW.prescribedBy THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'prescriptions', 'prescribedbBy', OLD.prescribedBy, NEW.prescribedBy);
            ELSEIF OLD.patientID <> NEW.patientID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'prescriptions', 'patientID', OLD.patientID, NEW.patientID);
            ELSEIF OLD.datePrescribed <> NEW.datePrescribed THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'prescriptions', 'datePrescribed', OLD.datePrescribed, NEW.datePrescribed);
            ELSEIF OLD.numberOfRefills <> NEW.numberOfRefills THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'prescriptions', 'numberOfRefills', OLD.numberOfRefills, NEW.numberOfRefills);
	END IF;
END//

-- Prescriptions Delete Trigger 
DROP TRIGGER IF EXISTS prescriptionsDelete//
CREATE TRIGGER prescriptionsDelete
	AFTER DELETE ON prescriptions
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'prescriptions', 'prescriptionID', OLD.prescriptionID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'prescriptions', 'prescribedBy', OLD.prescribedBy, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'prescriptions', 'patientID', OLD.patientID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'prescriptions', 'datePrescribed', OLD.datePrescribed, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'prescriptions', 'numberOfRefills', OLD.numberOfRefills, NULL);
END//

-- Procedures Triggers ===========================================================================================================

-- Procedures Insert Trigger 
DROP TRIGGER IF EXISTS proceduresInsert//
CREATE TRIGGER proceduresInsert
	AFTER INSERT ON procedures
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'procedures', 'procedure_ID', NULL, NEW.procedure_ID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'procedures', 'visit', NULL, NEW.visit);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'procedures', 'patient', NULL, NEW.patient);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'procedures', 'examinedBy', NULL, NEW.examinedBy);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'procedures', 'examinedIn', NULL, NEW.examinedIn);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'procedures', 'treatment', NULL, NEW.treatment);
END//

-- Procedures Update Trigger 
DROP TRIGGER IF EXISTS proceduresUpdate//
CREATE TRIGGER proceduresUpdate
	AFTER UPDATE ON procedures
    FOR EACH ROW
BEGIN
	IF OLD.procedure_ID <> NEW.procedure_ID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'procedures', 'procedure_ID', OLD.procedure_ID, NEW.procedure_ID);
            ELSEIF OLD.visit <> NEW.visit THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'procedures', 'visit', OLD.visit, NEW.visit);
            ELSEIF OLD.patient <> NEW.patient THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'procedures', 'patient', OLD.patient, NEW.patient);
            ELSEIF OLD.examinedBy <> NEW.examinedBy THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'procedures', 'examinedBy', OLD.examinedBy, NEW.examinedBy);
            ELSEIF OLD.examinedIn <> NEW.examinedIn THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'procedures', 'examinedIn', OLD.examinedIn, NEW.examinedIn);
            ELSEIF OLD.treatment <> NEW.treatment THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'procedures', 'treatment', OLD.treatment, NEW.treatment);
	END IF;
END//

-- Procedures Delete Trigger 
DROP TRIGGER IF EXISTS proceduresDelete//
CREATE TRIGGER proceduresDelete
	AFTER DELETE ON procedures
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'procedures', 'procedure_ID', OLD.procedure_ID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'procedures', 'visit', OLD.visit, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'procedures', 'patient', OLD.patient, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'procedures', 'examinedBy', OLD.examinedBy, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'procedures', 'examinedIn', OLD.examinedIn, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'procedures', 'treatment', OLD.treatment, NULL);
END//

-- Room Equipment Triggers ===========================================================================================================

-- Room Equipment Insert Trigger 
DROP TRIGGER IF EXISTS roomEquipmentInsert//
CREATE TRIGGER roomEquipmentInsert
	AFTER INSERT ON roomEquipment
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'roomEquipment', 'roomID', NULL, NEW.roomID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'roomEquipment', 'equipmentID', NULL, NEW.equipmentID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'roomEquipment', 'quantity', NULL, NEW.quantity);
END//

-- Room Equipment Update Trigger 
DROP TRIGGER IF EXISTS roomEquipmentUpdate//
CREATE TRIGGER roomEquipmentUpdate
	AFTER UPDATE ON roomEquipment
    FOR EACH ROW
BEGIN
	IF OLD.roomID <> NEW.roomID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'roomEquipment', 'roomID', OLD.roomID, NEW.roomID);
            ELSEIF OLD.equipmentID <> NEW.equipmentID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'roomEquipment', 'equipmentID', OLD.equipmentID, NEW.equipmentID);
            ELSEIF OLD.quantity <> NEW.quantity THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'roomEquipment', 'quantity', OLD.quantity, NEW.quantity);
	END IF;
END//

-- Room Equipment Delete Trigger 
DROP TRIGGER IF EXISTS roomEquipmentDelete//
CREATE TRIGGER roomEquipmentDelete
	AFTER DELETE ON roomEquipment
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'roomEquipment', 'roomID', OLD.roomID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'roomEquipment', 'equipmentID', OLD.equipmentID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'roomEquipment', 'quantity', OLD.quantity, NULL);
END//

-- Rooms Triggers ===========================================================================================================

-- Rooms Insert Trigger 
DROP TRIGGER IF EXISTS roomsInsert//
CREATE TRIGGER roomsInsert
	AFTER INSERT ON rooms
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'rooms', 'roomID', NULL, NEW.roomID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'rooms', 'roomName', NULL, NEW.roomName);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'rooms', 'roomType', NULL, NEW.roomType);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'rooms', 'roomDescription', NULL, NEW.roomDescription);
END//

-- Rooms Update Trigger 
DROP TRIGGER IF EXISTS roomsUpdate//
CREATE TRIGGER roomsUpdate
	AFTER UPDATE ON rooms
    FOR EACH ROW
BEGIN
	IF OLD.roomID <> NEW.roomID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'rooms', 'roomID', OLD.roomID, NEW.roomID);
            ELSEIF OLD.roomName <> NEW.roomName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'rooms', 'roomName', OLD.roomName, NEW.roomName);
            ELSEIF OLD.roomType <> NEW.roomType THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'rooms', 'roomType', OLD.roomType, NEW.roomType);
            ELSEIF OLD.roomDescription <> NEW.roomDescription THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'rooms', 'roomDescription', OLD.roomDescription, NEW.roomDescription);
	END IF;
END//

-- Rooms Delete Trigger 
DROP TRIGGER IF EXISTS roomsDelete//
CREATE TRIGGER roomsDelete
	AFTER DELETE ON rooms
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'rooms', 'roomID', OLD.roomID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'rooms', 'roomName', OLD.roomName, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'rooms', 'roomType', OLD.roomType, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'rooms', 'roomDescription', OLD.roomDescription, NULL);
END//

-- Rooms Types Triggers ===========================================================================================================

-- Rooms Types Insert Trigger 
DROP TRIGGER IF EXISTS roomsTypesInsert//
CREATE TRIGGER roomsTypesInsert
	AFTER INSERT ON roomsTypes
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'roomsTypes', 'roomTypeID', NULL, NEW.roomTypeID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'roomsTypes', 'roomLabel', NULL, NEW.roomLabel);
END//

-- Rooms Types Update Trigger 
DROP TRIGGER IF EXISTS roomsTypesUpdate//
CREATE TRIGGER roomsTypesUpdate
	AFTER UPDATE ON roomsTypes
    FOR EACH ROW
BEGIN
	IF OLD.roomTypeID <> NEW.roomTypeID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'roomsTypes', 'roomTypeID', OLD.roomTypeID, NEW.roomTypeID);
            ELSEIF OLD.roomLabel <> NEW.roomLabel THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'roomsTypes', 'roomLabel', OLD.roomLabel, NEW.roomLabel);
	END IF;
END//

-- Rooms Types Delete Trigger 
DROP TRIGGER IF EXISTS roomsTypesDelete//
CREATE TRIGGER roomsTypesDelete
	AFTER DELETE ON roomsTypes
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'roomsTypes', 'roomTypeID', OLD.roomTypeID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'roomsTypes', 'roomLabel', OLD.roomLabel, NULL);
END//

-- Room Supplies Triggers ===========================================================================================================

-- Rooms Supplies Insert Trigger 
DROP TRIGGER IF EXISTS roomSuppliesInsert//
CREATE TRIGGER roomSuppliesInsert
	AFTER INSERT ON roomSupplies
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'roomSupplies', 'roomID', NULL, NEW.roomID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'roomSupplies', 'supplyID', NULL, NEW.supplyID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'roomSupplies', 'quantity', NULL, NEW.quantity);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'roomSupplies', 'lastRestock', NULL, NEW.lastRestock);
END//

-- Rooms Supplies Update Trigger 
DROP TRIGGER IF EXISTS roomSuppliesUpdate//
CREATE TRIGGER roomSuppliesUpdate
	AFTER UPDATE ON roomSupplies
    FOR EACH ROW
BEGIN
	IF OLD.roomID <> NEW.roomID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'roomSupplies', 'roomID', OLD.roomID, NEW.roomID);
            ELSEIF OLD.supplyID <> NEW.supplyID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'roomSupplies', 'supplyID', OLD.supplyID, NEW.supplyID);
            ELSEIF OLD.quantity <> NEW.quantity THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'roomSupplies', 'quantity', OLD.quantity, NEW.quantity);
            ELSEIF OLD.lastRestock <> NEW.lastRestock THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'roomSupplies', 'lastRestock', OLD.lastRestock, NEW.lastRestock);
	END IF;
END//

-- Rooms Supplies Delete Trigger 
DROP TRIGGER IF EXISTS roomSuppliesDelete//
CREATE TRIGGER roomSuppliesDelete
	AFTER DELETE ON roomSupplies
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'roomSupplies', 'roomID', OLD.roomID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'roomSupplies', 'supplyID', OLD.supplyID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'roomSupplies', 'quantity', OLD.quantity, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'roomSupplies', 'lastRestock', OLD.lastRestock, NULL);
END//

-- Staff Supplies Triggers ===========================================================================================================

-- Staff Insert Trigger 
DROP TRIGGER IF EXISTS staffInsert//
CREATE TRIGGER staffInsert
	AFTER INSERT ON staff
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'staff', 'staffID', NULL, NEW.staffID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'staff', 'jobPosition', NULL, NEW.jobPosition);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'staff', 'userLogIn', NULL, NEW.userLogIn);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'staff', 'userRole', NULL, NEW.userRole);
END//

-- Staff Update Trigger 
DROP TRIGGER IF EXISTS staffUpdate//
CREATE TRIGGER staffUpdate
	AFTER UPDATE ON staff
    FOR EACH ROW
BEGIN
	IF OLD.staffID <> NEW.staffID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'staff', 'staffID', OLD.staffID, NEW.staffID);
            ELSEIF OLD.jobPosition <> NEW.jobPosition THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'staff', 'jobPosition', OLD.jobPosition, NEW.jobPosition);
            ELSEIF OLD.userLogIn <> NEW.userLogIn THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'staff', 'userLogIn', OLD.userLogIn, NEW.userLogIn);
            ELSEIF OLD.userRole <> NEW.userRole THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'staff', 'userRole', OLD.userRole, NEW.userRole);
	END IF;
END//

-- Staff Delete Trigger 
DROP TRIGGER IF EXISTS staffDelete//
CREATE TRIGGER staffDelete
	AFTER DELETE ON staff
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'staff', 'staffID', OLD.staffID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'staff', 'jobPosition', OLD.jobPosition, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'staff', 'userLogIn', OLD.userLogIn, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'staff', 'userRole', OLD.userRole, NULL);
END//

-- Staff Specialties Triggers ===========================================================================================================

-- Staff Specialties Insert Trigger 
DROP TRIGGER IF EXISTS staffSpecialtiesInsert//
CREATE TRIGGER staffSpecialtiesInsert
	AFTER INSERT ON staffSpecialties
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'staffSpecialties', 'staffNumber', NULL, NEW.staffNumber);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'staffSpecialties', 'medicalSpecialty', NULL, NEW.medicalSpecialty);
END//

-- Staff Specialties Update Trigger 
DROP TRIGGER IF EXISTS staffSpecialtiesUpdate//
CREATE TRIGGER staffSpecialtiesUpdate
	AFTER UPDATE ON staffSpecialties
    FOR EACH ROW
BEGIN
	IF OLD.staffNumber <> NEW.staffNumber THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'staffSpecialties', 'staffNumber', OLD.staffNumber, NEW.staffNumber);
            ELSEIF OLD.medicalSpecialty <> NEW.medicalSpecialty THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'staffSpecialties', 'medicalSpecialty', OLD.medicalSpecialty, NEW.medicalSpecialty);
	END IF;
END//

-- Staff Specialties Delete Trigger 
DROP TRIGGER IF EXISTS staffSpecialtiesDelete//
CREATE TRIGGER staffSpecialtiesDelete
	AFTER DELETE ON staffSpecialties
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'staffSpecialties', 'staffNumber', OLD.staffNumber, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'staffSpecialties', 'medicalSpecialty', OLD.medicalSpecialty, NULL);
END//

-- Supplies Triggers ===========================================================================================================

-- Supplies Insert Trigger 
DROP TRIGGER IF EXISTS suppliesInsert//
CREATE TRIGGER suppliesInsert
	AFTER INSERT ON supplies
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'supplies', 'supplyID', NULL, NEW.supplyID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'supplies', 'supplyName', NULL, NEW.supplyName);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'supplies', 'label', NULL, NEW.label);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'supplies', 'companySupplier', NULL, NEW.companySupplier);
END//

-- Supplies Update Trigger 
DROP TRIGGER IF EXISTS suppliesUpdate//
CREATE TRIGGER suppliesUpdate
	AFTER UPDATE ON supplies
    FOR EACH ROW
BEGIN
	IF OLD.supplyID <> NEW.supplyID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'supplies', 'supplyID', OLD.supplyID, NEW.supplyID);
            ELSEIF OLD.supplyName <> NEW.supplyName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'supplies', 'supplyName', OLD.supplyName, NEW.supplyName);
            ELSEIF OLD.label <> NEW.label THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'supplies', 'label', OLD.label, NEW.label);
            ELSEIF OLD.companySupplier <> NEW.companySupplier THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'supplies', 'companySupplier', OLD.companySupplier, NEW.companySupplier);
	END IF;
END//

-- Supplies Delete Trigger 
DROP TRIGGER IF EXISTS suppliesDelete//
CREATE TRIGGER suppliesDelete
	AFTER DELETE ON supplies
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'supplies', 'supplyID', OLD.supplyID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'supplies', 'supplyName', OLD.supplyName, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'supplies', 'label', OLD.label, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'supplies', 'companySupplier', OLD.companySupplier, NULL);
END//

-- Treatments Triggers ===========================================================================================================

-- Treatments Insert Trigger 
DROP TRIGGER IF EXISTS treatmentsInsert//
CREATE TRIGGER treatmentsInsert
	AFTER INSERT ON treatments
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'treatments', 'treatmentID', NULL, NEW.treatmentID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'treatments', 'treatmentName', NULL, NEW.treatmentName);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'treatments', 'treatmentDescription', NULL, NEW.treatmentDescription);
END//

-- Treatments Update Trigger 
DROP TRIGGER IF EXISTS treatmentsUpdate//
CREATE TRIGGER treatmentsUpdate
	AFTER UPDATE ON treatments
    FOR EACH ROW
BEGIN
	IF OLD.treatmentID <> NEW.treatmentID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'treatments', 'treatmentID', OLD.treatmentID, NEW.treatmentID);
            ELSEIF OLD.treatmentName <> NEW.treatmentName THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'treatments', 'treatmentName', OLD.treatmentName, NEW.treatmentName);
            ELSEIF OLD.treatmentDescription <> NEW.treatmentDescription THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'UPDATE', 'treatments', 'treatmentDescription', OLD.treatmentDescription, NEW.treatmentDescription);
	END IF;
END//

-- Treatments Delete Trigger 
DROP TRIGGER IF EXISTS treatmentsDelete//
CREATE TRIGGER treatmentsDelete
	AFTER DELETE ON treatments
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'treatments', 'treatmentID', OLD.treatmentID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'treatments', 'treatmentName', OLD.treatmentName, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'treatments', 'treatmentDescription', OLD.treatmentDescription, NULL);
END//

-- Visits Triggers ===========================================================================================================

-- Visits Insert Trigger 
DROP TRIGGER IF EXISTS visitsInsert//
CREATE TRIGGER visitsInsert
	AFTER INSERT ON visits
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'visitID', NULL, NEW.visitID);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'patient', NULL, NEW.patient);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'scheduledDateTime', NULL, NEW.scheduledDateTime);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'reasonOfVisit', NULL, NEW.reasonOfVisit);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'examinedBy', NULL, NEW.examinedBy);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'examinedIn', NULL, NEW.examinedIn);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'billOfServices', NULL, NEW.billOfServices);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'results', NULL, NEW.results);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'checkIn', NULL, NEW.checkIn);

END//

-- Visits Update Trigger 
DROP TRIGGER IF EXISTS visitsUpdate//
CREATE TRIGGER visitsUpdate
	AFTER UPDATE ON visits
    FOR EACH ROW
BEGIN
	IF OLD.visitID <> NEW.visitID THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'visitID', NULL, NEW.visitID);
            ELSEIF OLD.patient <> NEW.patient THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'patient', NULL, NEW.patient);
             ELSEIF OLD.scheduledDateTime <> NEW.scheduledDateTime THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'scheduledDateTime', NULL, NEW.scheduledDateTime);
             ELSEIF OLD.reasonOfVisit <> NEW.reasonOfVisit THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'reasonOfVisit', NULL, NEW.reasonOfVisit);
             ELSEIF OLD.examinedBy <> NEW.examinedBy THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'examinedBy', NULL, NEW.examinedBy);
             ELSEIF OLD.examinedIn <> NEW.examinedIn THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'examinedIn', NULL, NEW.examinedIn);
             ELSEIF OLD.billOfServices <> NEW.billOfServices THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'billOfServices', NULL, NEW.billOfServices);
             ELSEIF OLD.results <> NEW.results THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'results', NULL, NEW.results);
             ELSEIF OLD.checkIn <> NEW.checkIn THEN
		INSERT INTO audit VALUES
			(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'INSERT', 'visits', 'checkIn', NULL, NEW.checkIn);
	END IF;
END//

-- Visits Delete Trigger 
DROP TRIGGER IF EXISTS visitsDelete//
CREATE TRIGGER visitsDelete
	AFTER DELETE ON visits
    FOR EACH ROW
BEGIN
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'visits', 'visitID', OLD.visitID, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'visits', 'patient', OLD.patient, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'visits', 'scheduledDateTime', OLD.scheduledDateTime, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'visits', 'reasonOfVisit', OLD.reasonOfVisit, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'visits', 'examinedBy', OLD.examinedBy, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'visits', 'examinedIn', OLD.examinedIn, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'visits', 'billOfServices', OLD.billOfServices, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'visits', 'results', OLD.results, NULL);
	INSERT INTO audit VALUES
		(DEFAULT, CURRENT_USER(), CURRENT_TIMESTAMP(), 'DELETE', 'visits', 'checkIn', OLD.checkIn, NULL);
END//

DELIMITER ;