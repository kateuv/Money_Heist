CREATE DATABASE Money_heist;

USE Money_heist;

/*Finding out all table names*/
SHOW TABLES; 

/*Creating a table*/
CREATE TABLE Robbers (
Nickname varchar(50),
FirstName varchar(50),
LastName varchar(50),
Gender varchar(50),
Age INT
);

/*Populating a table*/
INSERT INTO Robbers
VALUE
("Lisbon", "Raquel", "Murillo", "F", 40),
("Tokyo", "Silene", "Oliveira", "F", 30),
("Berlin", "Andrés", "Fonollosa", "M", 41),
("Rio", "Aníbal", "Cortés", "M", 23),
("Denver", "Daniel", "Ramos", "M", 20),
("Nairobi", "Ágata", "Jiménez", "F", 33),
("Moscow", "Agustín", "Ramos", "M", 50),
("Stockholm", "Mónica", "Gaztambide", "F", 30),
("The Professor", "Sergio", "Marquina", "M", 40),
("Oslo", "Radko", "Dragic", "M", 41),
("Helsinki", "Mirko", "Dragic", "M", 40);


/*Normalising the database*/
CREATE TABLE Names (
Nickname varchar(50),
FirstName varchar(50),
LastName varchar(50)
);

INSERT INTO Names
VALUE
("Lisbon", "Raquel", "Murillo"),
("Tokyo", "Silene", "Oliveira"),
("Rio", "Aníbal", "Cortés"),
("Denver", "Daniel", "Ramos"),
("Nairobi", "Ágata", "Jiménez"),
("Moscow", "Agustín", "Ramos"),
("Stockholm", "Mónica", "Gaztambide"),
("The Professor", "Sergio", "Marquina"),
("Oslo", "Radko", "Dragic"),
("Helsinki", "Mirko", "Dragic"),
("Berlin", "Andrés", "Fonollosa");

CREATE TABLE Gender (
Nickname varchar(50),
Gender varchar(50)
);

INSERT INTO Gender
VALUES
("Lisbon", "F"),
("Tokyo", "F"),
("Rio", "M"),
("Denver", "M"),
("Nairobi", "F"),
("Moscow", "M"),
("Stockholm", "F"),
("The Professor", "M"),
("Oslo", "M"),
("Helsinki", "M"),
("Berlin", "M");

CREATE TABLE Age (
Nickname varchar(50),
Age INT
);

INSERT INTO Age
VALUE
("Lisbon", 40),
("Tokyo", 30),
("Rio", 23),
("Denver", 20),
("Nairobi", 33),
("Moscow", 50),
("Stockholm", 30),
("The Professor", 40),
("Oslo", 41),
("Helsinki", 40),
("Berlin", 41);


/*Find nicknames of all robbers who are older than 40 years old*/
SELECT Nickname, Age
FROM Age
WHERE Age > 40;

/*One of the characters had a birthday so we want to update their age*/
UPDATE Age
SET Age = 31
WHERE Nickname = "Tokyo";

/*We check if the age has been updated*/
SELECT Nickname, Age
FROM Age
WHERE Nickname = "Tokyo";

/*Looking for all the female robbers*/
SELECT *
FROM Gender
WHERE Gender = "F";

/*Want to check the order of robbers from the youngest to oldest*/
SELECT Nickname, Age
FROM Age
ORDER BY Age;

/*Finding the robber with the longest last name*/
SELECT FirstName, LastName
FROM Names
WHERE LENGTH(LastName) = (SELECT MAX(LENGTH(LastName))
     FROM Names);

/*Creating a function which checks the age of the robbers and places them in a category based on their age*/
DELIMITER //
CREATE FUNCTION Age_Range (
  Age int)
RETURNS varchar(50)
DETERMINISTIC
BEGIN
    DECLARE AgeRange varchar(50);
  IF Age < 40 THEN
      SET AgeRange = "Young";
    ELSEIF (Age >= 40) THEN
      SET AgeRange = "Old";
    END IF;
	RETURN AgeRange;
    END//Age
   DELIMITER ;
  SELECT Nickname, Age,
  Age_Range(Age)
  FROM Age;
  
/*Checking which robbers have the same last name, if any*/ 
SELECT LastName, COUNT(*)
FROM Names
GROUP BY LastName
HAVING COUNT(*) > 1;

/*Finding robbers who are male and older than 40*/
SELECT Nickname
FROM Robbers
WHERE Age > 40 AND Gender = "M";

/*INNER JOIN*/
SELECT *
FROM Age
INNER JOIN Gender
ON Age.nickname = Gender.nickname
INNER JOIN Names
ON Gender.nickname = Names.nickname;

/*Setting primary and foreign keys*/
ALTER TABLE Names
ADD PRIMARY KEY (nickname); 

ALTER TABLE Age
ADD FOREIGN KEY (nickname) REFERENCES Names(nickname);

ALTER TABLE Gender
ADD FOREIGN KEY (nickname) REFERENCES Names(nickname); 

SELECT * FROM Age
WHERE age < (SELECT AVG(age) FROM Age);

SELECT * FROM Names
WHERE LastName IN ('Dragic', 'Ramos');

/*Creating a view*/
create view `female-robbers` as
select *
from Gender
where gender = 'F';

select * from `female-robbers`;
