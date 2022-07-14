/* Populate database with sample data. */

insert into animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
values ('Agumon', '2020-FEB-3', 0, true, 10.23),
('Gabumon', '2018-NOV-15', 2, true, 8),
('Pikavhu', '2021-JAN-7', 1, false,15.04),
('Devimon', '2017-MAY-12', 5, true, 11);

/* Adding more animals to the table */

insert into animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
values ('Charmander', '2020-FEB-8', 0, false, 11),
('Plantmon', '2021-NOV-15', 2, true, 5.7),
('Squirtle', '1993-APR-2', 3, false, 12.13),
('Angemon', '2005-JUN-12', 1, true, 45),
('Boarmon', '2005-JUN-7', 7, true, 20.4),
('Blossom', '1998-OCT-13', 3, true, 17),
('Ditto', '2022-MAY-14', 4, true, 22);

-- Adding data to owners table

insert into owners (full_name, age)
values ('Sam Smith', 34),
('Jennifer Orwell', 19),
('Bob', 45),
('Melody Pond', 77),
('Dean Winchester', 14),
('Jodie Whittaker', 38);

-- Adding data to species table

insert into species (name)
values ('Pokemon'),
('Digimon');

-- Update species Id based on the last three letters

UPDATE animals SET species_id = 2 WHERE name like '%mon';

-- Update the null species Id

UPDATE animals SET species_id = 1 WHERE name not like '%mon';

-- Updathe owner_id in the animals table based on the owners id (owners table)

UPDATE animals SET owner_id = (
  SELECT id from owners WHERE full_name = 'Sam Smith'
) WHERE name like 'Agumon';

UPDATE animals SET owner_id = (
  SELECT id from owners WHERE full_name = 'Jennifer Orwell'
) WHERE name like 'Gabumon' or name like 'Pikachu';

UPDATE animals SET owner_id = (
  SELECT id from owners WHERE full_name = 'Bob'
) WHERE name like 'Devimon' or name like 'Plantmon';

UPDATE animals SET owner_id = (
  SELECT id from owners WHERE full_name = 'Melody Pond'
) WHERE name like 'Charmander' or name like 'Blossom' or name like 'Squirtle';

UPDATE animals SET owner_id = (
  SELECT id from owners WHERE full_name = 'Dean Winchester'
) WHERE name like 'Angemon' or name like 'Boarmon';
