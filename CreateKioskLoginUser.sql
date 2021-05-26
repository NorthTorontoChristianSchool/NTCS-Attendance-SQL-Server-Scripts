/*
AtteNTCS - Create Kiosk Login and User
Version 0.1.0

This SQL script creates a new kiosk login and user with the kiosk role.
Simply open this file in SSMS, replace the values below and click "Execute".
*/

-- REPLACE THE SAMPLE USERNAME AND SAMPLE PASSWORD BELOW
-- WITH A USERNAME AND PASSWORD OF YOUR CHOICE!!!
CREATE LOGIN YourUsernameHere WITH PASSWORD = 'YourPasswordHere';

-- Don't touch this
USE studentmanagement;
GO

-- REPLACE THE SAMPLE USERNAME BELOW WITH THE SAME USERNAME FROM ABOVE!!!
CREATE USER YourUsernameHere;

ALTER ROLE KioskRole
-- REPLACE THE SAMPLE USERNAME BELOW WITH THE SAME USERNAME FROM ABOVE!!!
	ADD MEMBER YourUsernameHere;