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

/* project 3 */

-- What animals belong to Melody Pond?
SELECT * FROM animals
JOIN owners on animals.owner_id = owners.id
WHERE full_name like 'Melody Pond';

-- List of all animals that are pokemon (their type is Pokemon).
SELECT * FROM animals
JOIN species on animals.species_id = species.id
WHERE species.name like 'Pokemon';

-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name, name FROM animals
JOIN owners on animals.owner_id = owners.id;

-- How many animals are there per species?
SELECT species.name, count(*)  FROM animals
JOIN species on animals.species_id = species.id GROUP by species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT * FROM animals
JOIN owners on animals.owner_id = owners.id
JOIN species on animals.species_id = species.id
WHERE species.name like 'Digimon' AND owners.full_name like 'Jennifer Orwell';

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT * FROM animals
JOIN owners on animals.owner_id = owners.id
WHERE owners.full_name like 'Dean Winchester' AND escape_attempts = 0;

-- Who owns the most animals?
SELECT owners.full_name, count(*) FROM animals
JOIN owners on animals.owner_id = owners.id
GROUP BY owners.full_name
ORDER BY count DESC LIMIT 1;

/* Project 4 */

-- Who was the last animal seen by William Tatcher?
SELECT animals.name, visits.date_of_visit FROM animals
INNER JOIN visits on animals.id = visits.animals_id
INNER JOIN vets on vets.id = visits.vet_id
WHERE vets.name = 'William Tatcher'
ORDER by date_of_visit DESC LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT count(*) as differnt_animals FROM animals
INNER JOIN visits on animals.id = visits.animals_id
INNER JOIN vets on vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez';

-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name, species.name FROM vets
LEFT JOIN specializations on vets.id = specializations.vet_id
LEFT JOIN species on species.id = specializations.species_id

-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT animals.name, visits.date_of_visit FROM animals
INNER JOIN visits on animals.id = visits.animals_id
INNER JOIN vets on vets.id = visits.vet_id
WHERE vets.name = 'Stephanie Mendez' AND 
date_of_visit BETWEEN '2020-APR-1' AND '2020-AUG-30';

-- What animal has the most visits to vets?
SELECT animals.name, count(animals.name) FROM animals
INNER JOIN visits on animals.id = visits.animals_id
GROUP BY animals.name
ORDER BY count DESC LIMIT 1;

-- Who was Maisy Smith's first visit?
SELECT animals.name, visits.date_of_visit FROM animals
INNER JOIN visits on animals.id = visits.animals_id
INNER JOIN vets on vets.id = visits.vet_id
WHERE vets.name = 'Maisy Smith'
GROUP BY animals.name, visits.date_of_visit
ORDER BY visits.date_of_visit ASC LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT visits.date_of_visit, animals.*, vets.*, species.name FROM animals
INNER JOIN visits on animals.id = visits.animals_id
INNER JOIN vets on vets.id = visits.vet_id
INNER JOIN species on species.id = animals.species_id
GROUP BY animals.id, vets.id, visits.date_of_visit, species.name
ORDER BY visits.date_of_visit DESC LIMIT 1;

-- How many visits were with a vet that did not specialize in that animal's species?
SELECT vets.name, count(visits.*) FROM vets
LEFT JOIN specializations on specializations.vet_id = vets.id
LEFT JOIN visits on visits.vet_id = vets.id
WHERE specializations.vet_id is null
GROUP BY vets.name;

-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT species.name, vets.name, count(visits.*) FROM animals
LEFT JOIN visits on visits.animals_id = animals.id
LEFT JOIN vets on visits.vet_id = vets.id
LEFT JOIN species on animals.species_id = species.id
WHERE vets.name like 'Maisy Smith'
GROUP BY species.name, vets.name
ORDER BY count DESC LIMIT 1;
