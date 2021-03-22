-- This file contains all the querys to create all the tables for the orthodontist database. 

DROP DATABASE IF EXISTS orthodontistDB;
CREATE DATABASE orthodontistDB;
USE orthodontistDB;

CREATE TABLE address (
  addressID         INT            PRIMARY KEY   AUTO_INCREMENT,
  street            VARCHAR(255)   NOT NULL,  
  city              VARCHAR(255)   NOT NULL,
  state             CHAR(2)        NOT NULL,
  zipCode           VARCHAR(10)    NOT NULL,
  
  INDEX (addressID),
  INDEX (city),
  INDEX (state),
  INDEX (zipCode)
);

CREATE TABLE audit (
  logID 		 INT PRIMARY KEY auto_increment,
  userLog  		 VARCHAR(255) NOT NULL,
  taskTime	     TIMESTAMP    NOT NULL,
  taskType	     VARCHAR(255) NOT NULL,
  tableName		 VARCHAR(255) NOT NULL,
  columnName	 VARCHAR(55)  NOT NULL,
  previousValue  VARCHAR(255),
  newValue		 VARCHAR(255),
  
  INDEX (logID)
 );
 
CREATE TABLE individuals (
  individualID      INT            PRIMARY KEY   AUTO_INCREMENT,
  honorific			VARCHAR(10)	   NOT NULL,
  firstName         VARCHAR(255)   NOT NULL,  
  middleName        VARCHAR(1)     NOT NULL,
  lastName          VARCHAR(255)   NOT NULL,
  mailingAddress    INT            NOT NULL,
  phoneNumber       VARCHAR(255)   NOT NULL, 
  emailAddress      VARCHAR(255)   NOT NULL,
  
  INDEX (individualID),
  INDEX (mailingAddress),
  
  FOREIGN KEY (mailingAddress) REFERENCES address (addressID)
);

CREATE TABLE patients (
  patientID         INT            PRIMARY KEY,
  dateOfBirth       DATE           NOT NULL,  
  sex               CHAR(1)        NOT NULL,
  
  FOREIGN KEY (patientID) REFERENCES individuals (individualID)
);

CREATE TABLE patientConditions (
  patientID            INT            NOT NULL,
  conditionDescription VARCHAR(255)   NOT NULL,
  
  INDEX (patientID),
  
  FOREIGN KEY (patientID) REFERENCES patients (patientID)
);

CREATE TABLE emergencyContacts (
  contactID         INT            PRIMARY KEY,
  patientID         INT            NOT NULL, 
  relationToPatient VARCHAR(50)    NOT NULL,  
  
  INDEX (contactID),
  INDEX (patientID),
  
  FOREIGN KEY (contactID) REFERENCES individuals (individualID),
  FOREIGN KEY (patientID) REFERENCES patients (patientID)
);
  
  CREATE TABLE medicalSpecialties (
  specialtyID               INT            PRIMARY KEY   AUTO_INCREMENT,
  specialtyName             VARCHAR(255)   NOT NULL, 
  specialtyDescription      VARCHAR(255)   NOT NULL,
 
  INDEX (specialtyID)
 
 );
 
  CREATE TABLE staff (
  staffID      INT     PRIMARY KEY,
  jobPosition  VARCHAR(255) NOT NULL,
  userLogIn    VARCHAR(30) NOT NULL UNIQUE,
  userRole     VARCHAR(30) NOT NULL,

  INDEX (staffID),

  FOREIGN KEY (staffID) REFERENCES individuals (individualID)
 );
 
  CREATE TABLE staffSpecialties (
  staffNumber        INT     PRIMARY KEY,
  medicalSpecialty  INT  	 NOT NULL, 
  
  INDEX (staffNumber),
  INDEX (medicalSpecialty),
  
  FOREIGN KEY (staffNumber) REFERENCES staff (staffID),
  FOREIGN KEY (medicalSpecialty) REFERENCES medicalSpecialties (specialtyID)
 );
 
  CREATE TABLE companyTypes (
  companyTypeID            INT            PRIMARY KEY   AUTO_INCREMENT,
  label                    VARCHAR(255)   NOT NULL,
 
  INDEX(companyTypeID)
 
 );
 
 CREATE TABLE companies (
  companyID            INT            PRIMARY KEY   AUTO_INCREMENT,
  companyName          VARCHAR(255)   NOT NULL,
  companyTypeID        INT            NOT NULL,
  contactPerson        INT            NOT NULL,
  phoneNumber          VARCHAR(255)   NOT NULL,
  emailAddress         VARCHAR(255)   NOT NULL,
  mailingAddress	   INT            NOT NULL,
  
  INDEX (companyID),
  INDEX (mailingAddress), 
  
  FOREIGN KEY (companyTypeID) REFERENCES companyTypes (companyTypeID),
  FOREIGN KEY (mailingAddress) REFERENCES address (addressID),
  FOREIGN KEY (contactPerson) REFERENCES individuals (individualID)
 );
 
CREATE TABLE insurancePlans (
  insurancePlanID     INT            PRIMARY KEY   AUTO_INCREMENT,
  insurancePlanName	  VARCHAR(255)   NOT NULL,
  planCoverage        VARCHAR(500)   NOT NULL,
 
  INDEX (insurancePlanID)
 
 );
 
CREATE TABLE insurance (
  insurancePolicyID    INT            PRIMARY KEY   AUTO_INCREMENT,
  patientID			   INT            NOT NULL, 
  companyID            INT            NOT NULL, 
  insurancePlan        INT            NOT NULL,
  subscriptionNumber   VARCHAR(255)   NOT NULL, 
  expirationDate       DATE           NOT NULL,  
  applicableDeductible DECIMAL(9,2)   NOT NULL,
  
  INDEX (insurancePolicyID),
  INDEX (patientID),
  INDEX (companyID),
  INDEX (insurancePlan),
  
  FOREIGN KEY (patientID) REFERENCES patients (patientID),
  FOREIGN KEY (insurancePlan) REFERENCES insurancePlans (insurancePlanID),
  FOREIGN KEY (companyID) REFERENCES companies (companyID)
 );
 
  CREATE TABLE drugs (
  drugID        INT            PRIMARY KEY   AUTO_INCREMENT,
  genericName   VARCHAR(255)   NOT NULL, 
  brandName     VARCHAR(255)   NOT NULL,

  INDEX (drugID)
  
 );
 
  CREATE TABLE medications (
  medicationID    INT            PRIMARY KEY   AUTO_INCREMENT,
  drug			  INT 			 NOT NULL, 
  dosage          VARCHAR(255)   NOT NULL, 
  frequency       VARCHAR(255)   NOT NULL, 
  
  INDEX (medicationID),
  INDEX (drug),

  FOREIGN KEY (drug) REFERENCES drugs (drugID)
 );
  
  CREATE TABLE roomsTypes (
  roomTypeID         INT            PRIMARY KEY   AUTO_INCREMENT,
  roomLabel  	     VARCHAR(255)   NOT NULL,
  
  INDEX (roomTypeID)
  
  );
 
  CREATE TABLE rooms (
  roomID             INT            PRIMARY KEY   AUTO_INCREMENT,
  roomName  	     VARCHAR(255)   NOT NULL, 
  roomType           INT            NOT NULL,
  roomDescription    VARCHAR(255)   NOT NULL,
  
  INDEX (roomID),
  INDEX (roomType),
  
  FOREIGN KEY (roomType) REFERENCES roomsTypes (roomTypeID)
  );
  
  CREATE TABLE equipmentTypes (
  equipmentID           INT            PRIMARY KEY   AUTO_INCREMENT,
  equipmentName         VARCHAR(255)   NOT NULL, 
  equipmentDescription  VARCHAR(255)   NOT NULL,
  
  INDEX (equipmentID)
  
  );
 
  CREATE TABLE roomEquipment (
  roomID				INT            NOT NULL,
  equipmentID           INT            NOT NULL,
  quantity              VARCHAR(255)   NOT NULL,
  
  INDEX (roomID),
  INDEX (equipmentID),
  
  FOREIGN KEY (roomID) REFERENCES rooms (roomID),
  FOREIGN KEY (equipmentID) REFERENCES equipmentTypes (equipmentID)
  );
 
  CREATE TABLE supplies (
  supplyID         INT            PRIMARY KEY   AUTO_INCREMENT,
  supplyName  	   VARCHAR(255)   NOT NULL,
  label       	   VARCHAR(255)   NOT NULL,
  companySupplier  INT            NOT NULL,
  
  INDEX (supplyID),
  INDEX (companySupplier),
  
  FOREIGN KEY (companySupplier) REFERENCES companies (companyID)
 );
   
  CREATE TABLE roomSupplies (
  roomID		   INT            NOT NULL,
  supplyID         INT            NOT NULL,
  quantity         INT            NOT NULL,
  lastRestock      DATE           NOT NULL,
  
  INDEX (roomID),
  INDEX (supplyID),
  
  FOREIGN KEY (roomID) REFERENCES rooms (roomID),
  FOREIGN KEY (supplyID) REFERENCES supplies (supplyID)
 );
  
  CREATE TABLE treatments (
  treatmentID             INT            PRIMARY KEY   AUTO_INCREMENT,
  treatmentName			  VARCHAR(255)   NOT NULL, 
  treatmentDescription    VARCHAR(255)   NOT NULL,
  
  INDEX (treatmentID)
  
 );

  CREATE TABLE billing (
  billID                INT             PRIMARY KEY   AUTO_INCREMENT,
  totalDebt	            DECIMAL(9,2)    NOT NULL, 
  dueDate               DATE            NULL,
  remainingBalance      DECIMAL(9,2)    NULL, 
  descriptionOfServices VARCHAR(255)    NOT NULL,
  
  INDEX (billID)
 );
 
CREATE TABLE visits (
  visitID           INT            PRIMARY KEY   AUTO_INCREMENT,
  patient           INT            NOT NULL,
  scheduledDateTime DATETIME       NOT NULL,  
  reasonOfVisit     VARCHAR(255)   NOT NULL,
  examinedBy        INT            NOT NULL,
  examinedIn        INT            NOT NULL,
  billOfServices    INT            NOT NULL,
  results           VARCHAR(255)   NULL,
  checkIn           VARCHAR(2)     NULL,
  
  INDEX (visitID),
  INDEX (patient),
  INDEX (examinedBy),
  INDEX (examinedIn),
  INDEX (billOfServices),
  
  FOREIGN KEY (patient) REFERENCES patients (patientID),
  FOREIGN KEY (examinedBy) REFERENCES staff (staffID),
  FOREIGN KEY (examinedIn) REFERENCES rooms(roomID),
  FOREIGN KEY (billOfServices) REFERENCES billing (billID)
);

  CREATE TABLE  prescriptions (
  prescriptionID  INT            PRIMARY KEY,
  prescribedBy   INT 			 NOT NULL, 
  patientID       INT			 NOT NULL,
  datePrescribed  INT            NOT NULL, 
  numberOfRefills INT            NOT NULL, 
  
  INDEX (prescriptionID),
  INDEX (prescribedBy),
  INDEX (patientID),
  INDEX (datePrescribed),
  
  FOREIGN KEY (prescriptionID) REFERENCES medications (medicationID),
  FOREIGN KEY (prescribedBy) REFERENCES staff (staffID),
  FOREIGN KEY (patientID) REFERENCES patients (patientID),
  FOREIGN KEY (datePrescribed) REFERENCES visits (visitID)
 );

  CREATE TABLE  patientTreatments (
  patientID       INT 		 PRIMARY KEY, 
  treatmentID     INT          NOT NULL,
  dateStarted     INT          NOT NULL, 
  orderedBy       INT 	       NOT NULL, 
  results         VARCHAR(500) NOT NULL, 
  
  INDEX (patientID),
  INDEX (treatmentID),
  INDEX (dateStarted),
  INDEX (orderedBy),
  
  FOREIGN KEY (patientID) REFERENCES patients (patientID),
  FOREIGN KEY (orderedBy) REFERENCES staff (staffID),
  FOREIGN KEY (treatmentID) REFERENCES treatments(treatmentID),
  FOREIGN KEY (dateStarted) REFERENCES visits (visitID)
  );

CREATE TABLE procedures (
  procedure_ID      INT            PRIMARY KEY   AUTO_INCREMENT,
  visit             INT            NOT NULL,
  patient           INT            NOT NULL,
  examinedBy        INT            NOT NULL,
  examinedIn        INT            NOT NULL,
  treatment         INT            NOT NULL, 
  
  INDEX (procedure_ID),
  INDEX (visit),
  INDEX (patient),
  INDEX (examinedBy),
  INDEX (examinedIn),
  INDEX (treatment),
  
  FOREIGN KEY (visit) REFERENCES visits (visitID),
  FOREIGN KEY (patient) REFERENCES patients (patientID),
  FOREIGN KEY (examinedBy) REFERENCES staff (staffID),
  FOREIGN KEY (examinedIn) REFERENCES rooms(roomID),
  FOREIGN KEY (treatment) REFERENCES  treatments (treatmentID)
);
