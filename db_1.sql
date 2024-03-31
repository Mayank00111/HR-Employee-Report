DESCRIBE human_resources;

SELECT * FROM human_resources;

SET sql_safe_updates = 0;

UPDATE human_resources
SET termdate = date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
WHERE termdate IS NOT NULL AND termdate != '';

SELECT termdate FROM human_resources;


UPDATE human_resources
SET termdate = IF(termdate IS NOT NULL AND TERMDATE != '',
date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC')),'0000-00-00')
WHERE TRUE;

SELECT termdate FROM human_resources;

SET sql_mode = 'ALLOW_INVALID_DATES';

ALTER TABLE human_resources
MODIFY COLUMN termdate DATE;

SELECT termdate FROM human_resources;

DESCRIBE human_resources;

ALTER TABLE human_resources ADD COLUMN age INT;

UPDATE human_resources
SET age = timestampdiff(YEAR,birthdate,CURDATE());

SELECT birthdate,age FROM human_resources;




