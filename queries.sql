/*Queries that provide answers to the questions from all projects.*/

select * from animals where name like '%mon';
-- output:
-- id |  name   | date_of_birth | escape_attempts | neutered | weight_kg
----+---------+---------------+-----------------+----------+-----------
--  1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
--  2 | Gabumon | 2018-11-15    |               2 | t        |         8
--  4 | Devimon | 2017-05-12    |               5 | t        |        11

select name from animals where date_of_birth between '2016-01-01' and '2019-12-31';
-- output:
-- name
-----------
-- Gabumon
-- Devimon

select name from animals where neutered = true and escape_attempts < 3;
-- output:
--  name
---------
-- Agumon
-- Gabumon

select date_of_birth from animals where name like 'Agumon' or name like'Pikachu';
-- output:
-- date_of_birth
---------------
-- 2020-02-03

select name, escape_attempts from animals where weight_kg > 10.5;
-- output:
-- name   | escape_attempts
---------+-----------------
-- Pikavhu |               1
-- Devimon |               5

select * from animals where neutered = true;
-- output:
-- id |  name   | date_of_birth | escape_attempts | neutered | weight_kg
----+---------+---------------+-----------------+----------+-----------
--  1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
--  2 | Gabumon | 2018-11-15    |               2 | t        |         8
--  4 | Devimon | 2017-05-12    |               5 | t        |        11

select * from animals where name != 'Gabumon';
-- output:
-- id |  name   | date_of_birth | escape_attempts | neutered | weight_kg
----+---------+---------------+-----------------+----------+-----------
--  1 | Agumon  | 2020-02-03    |               0 | t        |     10.23
--  3 | Pikavhu | 2021-01-07    |               1 | f        |     15.04
--  4 | Devimon | 2017-05-12    |               5 | t        |        11

select * from animals where weight_kg between 10.4 and 17.3;
-- output:
-- id |  name   | date_of_birth | escape_attempts | neutered | weight_kg
----+---------+---------------+-----------------+----------+-----------
--  3 | Pikavhu | 2021-01-07    |               1 | f        |     15.04
--  4 | Devimon | 2017-05-12    |               5 | t        |        11


/* ROLLBACK */

BEGIN;
UPDATE animals SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;
SELECT * from animals;

/* COMMIT */

BEGIN;
UPDATE animals SET species = 'digimon' WHERE name like '%mon';
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;
COMMIT;
SELECT * FROM animals;

/* DELETE ALL then rollback */

BEGIN;
DELETE FROM animals;
ROLLBACK;
SELECT * FROM animals;

/* Create a savepoint */

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-JAN-01';
SAVEPOINT updated_animal;
UPDATE animals SET weight_kg = weight_kg * -1;
SELECT * from animals;
ROLLBACK TO updated_animal;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

/* answer of the questions */

SELECT count(*) FROM animals;
SELECT count(*) FROM animals WHERE escape_attempts <= 0;
SELECT avg(weight_kg) FROM animals;
SELECT neutered, max(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, min(weight_kg), max(weight_kg) FROM animals GROUP BY species;
SELECT species, avg(escape_attempts) FROM animals WHERE date_of_birth BETWEEN '1900-JAN-01' AND '2001-JAN-01' GROUP BY species;
