-- ****************************************************************************
-- Basic MySQL database and user creation commands.
-- ****************************************************************************
CREATE DATABASE IF NOT EXISTS dbName;

-- Create user that runs only on localhost of the MySQL server.
-- NOTE: Granting ALL privileges is generally discouraged for security
-- reasons. It is better to grant only the required privileges. For some'
-- orgs, best practice is to allow most users the ability to run only 
-- stored procs and functions.
CREATE USER 'userName'@'localhost' IDENTIFIED BY 'userPwd';
GRANT ALL PRIVILEGES ON dbName.* TO 'userName'@'localhost';
FLUSH PRIVILEGES;

-- Create user that can access the MySQL server from any location.
-- This is generally not advised for security reasons.
CREATE USER 'userName'@'%' IDENTIFIED BY 'userPwd';
GRANT ALL PRIVILEGES ON dbName.* TO 'userName'@'%';
FLUSH PRIVILEGES;

-- Getting basic MySQL user info from the server.
SELECT user, host, plugin FROM mysql.user;
SHOW GRANTS for 'userName'@'localhost'; 
SELECT @@VERSION AS `MySQL Version`, @@REQUIRE_SECURE_TRANSPORT AS `SSL ONLY`;

-- ****************************************************************************
-- MySQL Procedure to create a MySQL user.
-- ****************************************************************************
DROP PROCEDURE IF EXISTS CreateNewUser; 
DELIMITER //
CREATE PROCEDURE CreateNewUser (
	IN username VARCHAR(50)
   ,IN host VARCHAR(50)
   ,IN pwd VARCHAR(64)
)
BEGIN
	SET @buffer = CONCAT("CREATE USER '", username,"'@'", host,"' IDENTIFIED BY '", pwd,"'");
	PREPARE stmt FROM @buffer;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

-- USAGE
-- CALL CreateNewUser('webuser', 'localhost', 'webuserpwd');

-- ****************************************************************************
-- MySQL Procedure to GRANT Privileges to a MySQL user.
-- ****************************************************************************
DROP PROCEDURE IF EXISTS SetUserPrivileges; 
DELIMITER //
CREATE PROCEDURE SetUserPrivileges (
	IN username VARCHAR(50)
   ,IN host VARCHAR(50)
   ,IN dbname VARCHAR(50)
)
BEGIN
	SET @buffer = CONCAT("GRANT ALL PRIVILEGES ON ", dbname,".* TO '", username,"'@'", host,"'");
	PREPARE stmt FROM @buffer;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
END //
DELIMITER ;

-- USAGE
-- CALL SetUserPrivileges('webuser', 'localhost', 'test');

-- ****************************************************************************
-- MySQL Stored Procedure to Create Database, new user, and grant privileges.
-- ****************************************************************************
DROP PROCEDURE IF EXISTS SetupNewDatabase;
DELIMITER //
CREATE PROCEDURE SetupNewDatabase (
	IN username VARCHAR(50)
   ,IN host VARCHAR(50)
   ,IN pwd VARCHAR(64)   
   ,IN dbname VARCHAR(64)
)
BEGIN
	SET @buffer = CONCAT("CREATE DATABASE ", dbname);
	PREPARE stmt FROM @buffer;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;

	CALL CreateNewUser(username, host, pwd);
	CALL SetUserPrivileges(username, host, dbname);
END //
DELIMITER ;

-- USAGE
-- CALL SetupNewdatabase('webuser', 'localhost', 'webuserpwd', 'test02');
-- SHOW DATABASES;
-- DROP DATABASE test02;
