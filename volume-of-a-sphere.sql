-- NOTE: Return labels assume measurements are made in inches.
--       So, set your own labels according to your selected unit of measure.

-- ******************************************************************
-- Volume of a sphere from a SELECT command.
-- ******************************************************************
SELECT ((4.0 / 3) * pi() * POWER(2, 3)) AS `Volume (cubic inches)`;

-- ******************************************************************
-- Volume of a sphere using a stored functoin.
-- ******************************************************************
DROP FUNCTION IF EXISTS calcSphereVolume;
DELIMITER //
CREATE FUNCTION calcSphereVolume(r real)
RETURNS real
DETERMINISTIC
BEGIN
 	-- Volume of a sphere.
	RETURN (SELECT ((4.0 / 3) * pi() * POWER(r, 3)));
END //

DELIMITER ;

-- USAGE
SELECT calcSphereVolume(2) AS `Volume (cubic inches)`;
