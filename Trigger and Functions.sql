SELECT * FROM synthea.SamanthaB_datalist;
use synthea


#Triggers 
delimiter $$
CREATE TRIGGER qualitySystolic1 BEFORE INSERT ON SamanthaB_datalist
FOR EACH ROW
BEGIN
IF NEW.systolic >= 300 THEN
SIGNAL SQLSTATE '45000'
SET MESSAGE_TEXT = 'ERROR: Systolic BP MUST BE BELOW 300 mg!';
END IF;
END; $$
delimiter ;

show triggers;

#Confirmation that trigger is working
INSERT INTO SamanthaB_datalist (patientUID, lastname, systolic, diastolic) 
VALUES (3436, 'Williams', 120, 70), (434, 'Joe', 200, 100), (7897, 'Sam', 210, 30), (6762, 'Josh', 100, 78);

#Functions 
##1 Class function 
DELIMITER $$
CREATE FUNCTION MedicationCost(cost DECIMAL(10,2))
RETURNS VARCHAR(20)
BEGIN
DECLARE drugCost VARCHAR(20);
IF cost >= 200 THEN
SET drugCost = "expensive";
ELSEIF cost < 200 THEN
SET drugCost = "cheap";
END IF;
-- return the drug cost category
RETURN (drugCost);
END
$$
DELIMITER;


##2 My created Function
DELIMITER |
CREATE FUNCTION ProcedureCost(cost DECIMAL(10,2))
RETURNS VARCHAR(20)
BEGIN
DECLARE drugCost VARCHAR(20);
IF cost >= 10000 THEN
SET drugCost = "high cost";
ELSEIF cost < 10000 THEN
SET drugCost = "low cost";
END IF;
-- return the drug cost category 
RETURN (drugCost);
END
|
DELIMITER ;



#confirmation that fuction is working 
SELECT
Description,
BASE_COST,
ProcedureCost(BASE_COST)
FROM
procedures;





