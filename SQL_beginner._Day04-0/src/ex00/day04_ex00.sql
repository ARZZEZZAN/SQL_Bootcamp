CREATE VIEW V_PERSONS_FEMALE AS 
	SELECT * FROM person WHERE person.gender = 
'FEMALE'; 

CREATE VIEW V_PERSONS_MALE AS 
	SELECT * FROM person WHERE person.gender = 
'MALE'; 