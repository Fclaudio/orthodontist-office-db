-- This file is to see all the user registered on MySQL.

-- See all the users.
SELECT USER 
FROM mysql.user;

-- See all the users and their account and password status.
SELECT 
    USER, 
    HOST, 
    ACCOUNT_LOCKED, 
    PASSWORD_EXPIRED
FROM
    MYSQL.user;
    
-- Show the access privilaeges for each user
SHOW GRANTS FOR 'smoore'@'%';
SHOW GRANTS FOR 'jsmith'@'%';
SHOW GRANTS FOR 'tjones'@'%';
SHOW GRANTS FOR 'apatricks'@'%';

-- Test query to manually drop the staff users. 
DROP USER 'apatricks'@'localhost';
DROP USER 'jsmith'@'localhost';
DROP USER 'smoore'@'localhost';
DROP USER 'tjones'@'localhost';
DROP USER 'swilliam'@'localhost';

-- Test Query used to manually drop the roles. 
DROP USER 'orthodontistDBClerical'@'%';
DROP USER 'orthodontistDBSupervisor'@'%';
DROP USER 'orthodontistDBMedical'@'%';
DROP USER 'orthodontistDBManager'@'%';
DROP USER 'orthodontistDBUser'@'%';

-- Test Queries for applying role to user
CREATE USER 'test1'@'localhost' IDENTIFIED BY '1234';
GRANT orthodontistDBClerical TO 'test1'@'localhost';
SET DEFAULT ROLE 'orthodontistDBClerical' TO 'test1'@'localhost';
DROP USER 'test1'@'localhost';
SHOW GRANTS FOR 'test1'@'localhost';