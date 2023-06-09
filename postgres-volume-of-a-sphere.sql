-- ***************************************************************
-- NOTE: In postgres, intger division truncates result.
-- ***************************************************************
SELECT 5/2 AS "Integer Division", 5.0/2 as "Real Number Division";

-- ***************************************************************
-- SQL statement to calculate the volume of a sphere.
-- ***************************************************************
SELECT ((4.0 / 3) * pi() * POWER(2.0, 3)) as "Volume of Sphere (cu. in.)";

-- ***************************************************************
-- NOTE: Delete the function from the database, if needed.
-- ***************************************************************
drop function calcspherevolume; 

-- ***************************************************************
-- Function to calculate the volume of a sphere.
-- ***************************************************************
CREATE OR REPLACE FUNCTION calcSphereVolume (r real)
RETURNS real AS $sphereVolume$
declare
	sphereVolume real;
BEGIN
	-- Volume of a sphere.
	SELECT ((4.0 / 3) * pi() * POWER($1, 3)) into sphereVolume;
   RETURN sphereVolume;
END;
$sphereVolume$ LANGUAGE plpgsql;

-- ***************************************************************
-- Usage.
-- ***************************************************************
select to_char(calcSphereVolume(2.0), '99.99') as "Volume of Sphere (cu. in.)";
