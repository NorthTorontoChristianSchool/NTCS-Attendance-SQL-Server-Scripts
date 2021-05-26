/*
AtteNTCS - Delete Old Attendance Records
Version 0.1.0

This SQL script deletes records from the attendance table that are older than 1 year.
Warning: Make sure you back up the database if necessary!
Simply open this file in SSMS and click "Execute".
*/

-- Use the studentmanagement database
USE studentmanagement;
GO

-- Delete from the table where the date is older than 1 year
DELETE FROM AttendanceLog
WHERE LogTime < GETDATE() - 365;