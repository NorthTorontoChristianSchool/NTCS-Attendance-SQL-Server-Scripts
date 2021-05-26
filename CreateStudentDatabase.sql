/*
AtteNTCS - Create Student Database
Version 0.1.0

This SQL script creates the studentmanagement database and the tables.
It also creates roles for office staff and kiosk users.
Use for initial setup of the system.
Simply open this file in SSMS and click "Execute".
*/

-- Create the database
IF NOT EXISTS (SELECT * FROM sys.databases WHERE name = 'studentmanagement')
CREATE DATABASE studentmanagement;
ELSE
PRINT('studentmanagement database already exists.');
GO

USE studentmanagement;
GO

-- Create the tables
IF OBJECT_ID('Students', 'U') IS NULL
CREATE TABLE Students (
	StudentID varchar(900) NOT NULL PRIMARY KEY,
	FamilyID varchar(900),
	LastName varchar(8000),
	FirstName varchar(8000),
	Homeroom varchar(255),
	StudentEmail varchar(8000),
	KioskPersonalMessage varchar(8000),
	KioskMessageStartDate datetime2(0),
	KioskMessageExpiryDate datetime2(0),
);
ELSE
PRINT('Students table already exists.');

IF OBJECT_ID('Families', 'U') IS NULL
CREATE TABLE Families (
	FamilyID varchar(900) NOT NULL PRIMARY KEY,
	Parent1FirstName varchar(8000),
	Parent1LastName varchar(8000),
	Parent1Email varchar(8000),
	Parent2FirstName varchar(8000),
	Parent2LastName varchar(8000),
	Parent2Email varchar(8000),
);
ELSE
PRINT('Families table already exists.');

IF OBJECT_ID('AttendanceLog', 'U') IS NULL
CREATE TABLE AttendanceLog (
	LogTime datetime2(2),
	StudentID varchar(8000),
	ScanLocation varchar(8000),
	ScanType tinyint,
	/*
	Scan Types:
	0 - Sign In
	1 - Sign Out
	2 - Excused Absence
	*/
);
ELSE
PRINT('AttendanceLog table already exists.');

IF OBJECT_ID('KioskPublicMessages', 'U') IS NULL
CREATE TABLE KioskPublicMessages (
	DisplayOrder int,
	DisplayMessage varchar(8000),
	StartDate datetime2(0),
	ExpiryDate datetime2(0),
);
ELSE
PRINT('KioskPublicMessages table already exists.');


USE studentmanagement;
GO

-- Create the role for office staff
IF DATABASE_PRINCIPAL_ID('OfficeStaffRole') IS NULL
CREATE ROLE OfficeStaffRole;
ELSE
PRINT('OfficeStaffRole role already exists.');

GRANT SELECT, UPDATE, DELETE, INSERT ON Students TO OfficeStaffRole;
GRANT SELECT, UPDATE, DELETE, INSERT ON Families TO OfficeStaffRole;
GRANT SELECT, UPDATE, DELETE, INSERT ON AttendanceLog TO OfficeStaffRole;
GRANT SELECT, UPDATE, DELETE, INSERT ON KioskPublicMessages TO OfficeStaffRole;

USE studentmanagement;
GO

-- Create the role for kiosks
IF DATABASE_PRINCIPAL_ID('KioskRole') IS NULL
CREATE ROLE KioskRole;
ELSE
PRINT('KioskRole role already exists.');

GRANT SELECT ON Students TO KioskRole;
GRANT SELECT ON Families TO KioskRole;
GRANT SELECT, INSERT ON AttendanceLog TO KioskRole;
GRANT SELECT ON KioskPublicMessages TO KioskRole;
