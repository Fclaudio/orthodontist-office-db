===== CREATE THE DATABASE =====

The scripts in the 'Create' folders will construct the database.
The following should be run in this order:

1. Tables.sql
2. Triggers.sql
3. Roles.sql
4. Views.sql

==== ADD STORED PROCEDURES ====

The scripts in the 'Stores Procedures' folder will add the
stored procedures to the database and can be executed in any
order.

- Company Procedures.sql
- Patient Procedures.sql
- Staff Procedures.sql
- Treatment Procedures.sql
- Visit Procedures.sql

==== LOAD SAMPLE DATA =========

To populate the tables inside the database run the
'Sample Data.sql'.

If wanted to test the role privilegues using the log in and 
password credentials from one of the staff members preferably the 
'Manager' and 'Clerical' roles, as those were the ones tested and
run the corresponding file inside the user connection. 

To verify that the users were created and their roles use
the 'Test User.sql'file. 

==== AUDITING =================

All logs for the insert, update and delete statements
will be stored in the audit table. 
