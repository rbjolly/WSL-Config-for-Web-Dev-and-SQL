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
