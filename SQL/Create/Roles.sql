-- This file defines roles for users of the orthodontist database.

USE orthodontistDB;

DROP ROLE IF EXISTS 'orthodontistDBManager';
DROP ROLE IF EXISTS 'orthodontistDBSupervisor';
DROP ROLE IF EXISTS 'orthodontistDBMedical';
DROP ROLE IF EXISTS 'orthodontistDBClerical';
DROP ROLE IF EXISTS 'orthodontistDBUser';

-- All users can read from any table in the orthodontist database.
CREATE ROLE 'orthodontistDBUser';
GRANT SELECT ON orthodontistDB.* TO 'orthodontistDBUser';


-- Orthodontist or database managers can modify information from any table in the orthodontist database.
CREATE ROLE 'orthodontistDBManager';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.* TO 'orthodontistDBManager';
GRANT CREATE USER ON *.* TO 'orthodontistDBManager';
GRANT 'orthodontistDBUser' TO 'orthodontistDBManager';

-- Supervisors in the case of a small orthodontist office are orthodontist assistants with higher privileges and responsabilities
-- Supervisors can modify information related to staff, rooms, and equipment.
CREATE ROLE 'orthodontistDBSupervisor';
GRANT 'orthodontistDBUser' TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.address TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.companies TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.companytypes TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.individuals TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.insurance TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.insurancePlans TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.procedures TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.roomEquipment TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.rooms TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.roomsTypes TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.roomSupplies TO 'orthodontistDBSupervisor';

-- Basic functions performed by the other medical staff.
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.billing TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.drugs TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.medications TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.patientConditions TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.patients TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.prescriptions TO 'orthodontistDBSupervisor';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.procedures TO 'orthodontistDBSupervisor';

-- Medical staff can modify information related to the
-- procedures performed on and prescriptions given to the orthodontist's patients.
CREATE ROLE 'orthodontistDBMedical';
GRANT 'orthodontistDBUser' TO 'orthodontistDBMedical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.billing TO 'orthodontistDBMedical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.drugs TO 'orthodontistDBMedical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.medications TO 'orthodontistDBMedical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.patientConditions TO 'orthodontistDBMedical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.patients TO 'orthodontistDBMedical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.prescriptions TO 'orthodontistDBMedical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.procedures TO 'orthodontistDBMedical';

-- Secretaries and receptionist fall under clerical staff, these can modify information related to patients,
-- their insurance policies, their medical histories, and their visits.
CREATE ROLE 'orthodontistDBClerical';
-- GRANT SHOW DATABASES ON *.* TO 'orthodontistDBClerical';
GRANT 'orthodontistDBUser' TO 'orthodontistDBClerical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.address TO 'orthodontistDBClerical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.billing TO 'orthodontistDBClerical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.companies TO 'orthodontistDBClerical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.emergencyContacts TO 'orthodontistDBClerical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.individuals TO 'orthodontistDBClerical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.insurancePlans TO 'orthodontistDBClerical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.patientConditions TO 'orthodontistDBClerical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.patients TO 'orthodontistDBClerical';
GRANT INSERT, UPDATE, DELETE ON orthodontistDB.visits TO 'orthodontistDBClerical';
