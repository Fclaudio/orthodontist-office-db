-- This file contains all the querys to create all the views for the database. 

USE orthodontistDB;

-- The Patient Infomation view provides information of the patient's name, contact information, and demographic.
DROP VIEW IF EXISTS patientInformation;
CREATE VIEW patientInformation AS
    SELECT patientID, honorific, firstName, middleName, lastName, street, city, state, zipCode, phoneNumber, emailAddress, dateOfBirth, sex
    FROM patients
    JOIN individuals ON (patientID = individualID)
    JOIN address ON (addressID = MailingAddress);

-- Staff Information view provides information of the staff member's name, contact information, and employee record.
DROP VIEW IF EXISTS staffInformation;
CREATE VIEW staffInformation AS
    SELECT staffID, honorific, firstName, middleName, lastName, street, city, state, zipCode, phoneNumber, emailAddress, jobPosition, userLogIn, userRole
    FROM staff
    JOIN individuals ON (staffID = individualID)
    JOIN address ON (addressID = mailingAddress);


-- The Company Information view provides information about the  company's name, contact information and type. 
DROP VIEW IF EXISTS companyInformation;
CREATE VIEW companyInformation AS
	SELECT companyID, companyName, CT.label, street, city, state, zipCode, phoneNumber, emailAddress
    FROM companies C
    JOIN address ON (addressID = mailingAddress)
	JOIN companyTypes CT ON (CT.companyTypeID = C.companyTypeID);

-- Visit Information combines information about a visit to the clinic, the patient who is visiting, the doctor
-- who is seeing the patient, and the room where the visit is taking place into a single view.
DROP VIEW IF EXISTS visitInformation;
CREATE VIEW visitInformation AS
    SELECT
		VisitID,
        P.patientID,
        P.firstName AS patientFirstName,
        P.middleName AS patientMiddleName,
        P.lastName AS patientLastName,
        P.street AS patientStreet,
        P.city AS patientCity,
        P.state AS patientState,
        P.zipCode AS patientZipCode,
        P.phoneNumber AS patientPhoneNumber,
        P.emailAddress AS patientEmailAddress,
        P.dateOfBirth AS patientDateOfBirth,
        P.sex AS patientSex,
        S.StaffID,
        S.jobPosition AS staffJobPosition,
        S.honorific AS staffHonorific,
        S.firstName AS staffFirstName,
        S.middleName AS staffMiddleName,
        S.lastName AS staffLastName,
        S.phoneNumber AS staffPhoneNumber,
        S.emailAddress AS staffEmailAddress,
        R.roomID,
        R.roomName,
        R.roomDescription,
        RT.roomLabel AS roomType,
        RT.roomTypeID,
        reasonOfVisit,
        scheduledDateTime,
        checkIn,
        B.totalDebt AS totalBalance,
        B.remainingBalance
    FROM visits V
    JOIN patientInformation P ON (V.patient = P.patientID)
    JOIN staffInformation S ON (V.examinedBy = S.staffID)
	JOIN rooms R ON (V.examinedIn = R.roomID)
    JOIN roomsTypes RT ON (R.roomType = RT.roomTypeID)
    JOIN billing B ON (visitID = B.billID);



-- Insurance Information combines information about an insurance policy, the patient it belongs to,
-- and the company that provides it into a single view.
DROP VIEW IF EXISTS insuranceInformation;
CREATE VIEW insuranceInformation AS
    SELECT
		insurancePolicyID,
		P.patientID,
        P.firstName AS patientFirstName,
        P.middleName AS patientMiddleName,
        P.lastName AS patientLastName,
        P.street AS patientStreet,
        P.city AS patientCity,
        P.state AS patientState,
        P.zipCode AS patientZipCode,
        P.phoneNumber AS patientPhoneNumber,
        P.emailAddress AS patientEmailAddress,
        P.dateOfBirth AS patientDateOfBirth,
        P.sex AS patientSex,
        C.companyID,
        C.companyName,
        C.street AS companyStreet,
        C.city AS companyCity,
        C.state AS companyState,
        C.zipCode AS companyZipCode,
        C.phoneNumber AS companyPhoneNumber,
        C.emailAddress AS companyEmailAddress,
        T.insurancePlanName,
        T.insurancePlanID,
        subscriptionNumber,
        expirationDate,
        applicableDeductible
    FROM insurance I
    JOIN patientInformation P ON (I.patientID = P.patientID)
    JOIN companyInformation C ON (I.companyID = C.companyID)
    JOIN insurancePlans T ON (I.insurancePlan = T.insurancePlanID);

-- Billing Information provides a unified view of items billed to patients' accounts.
DROP VIEW IF EXISTS billingInformation;
CREATE VIEW billingInformation AS
    SELECT 
    P.patientID,
	P.firstName AS patientFirstName,
	P.middleName AS patientMiddleName,
	P.lastName AS patientLastName,
    billID, 
    "Visit" AS BillableItemType, 
    V.patient, 
    remainingBalance, 
    descriptionOfServices
    FROM billing
    JOIN visits V ON (billing.billID = V.visitID)
    JOIN patientInformation P ON (V.patient = P.patientID)