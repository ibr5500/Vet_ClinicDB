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

/* Project 4 */

-- Insert data to vets table
insert into vets (name, age, date_of_graduation)
values ('William Tatcher', 45, '2000-APR-23'),
('Maisy Smith', 26, '2019-JAN-17'),
('Stephanie Mendez', 64, '1981-MAY-04'),
('Jack Harkness', 38, '2008-JUN-08');

-- insert data to the specializations table
insert into specializations (species_id, vet_id)
VALUES (
  (
    SELECT id FROM species
    WHERE name like 'Pokemon'
  ),
  (
    SELECT id FROM vets
    WHERE name = 'William Tatcher'
  )
);

insert into specializations (species_id, vet_id)
VALUES (
  (
    SELECT id FROM species
    WHERE name like 'Pokemon'
  ),
  (
    SELECT id FROM vets
    WHERE name = 'Stephanie Mendez'
  )
);

insert into specializations (species_id, vet_id)
VALUES (
  (
    SELECT id FROM species
    WHERE name like 'Digimon'
  ),
  (
    SELECT id FROM vets
    WHERE name = 'Stephanie Mendez'
  )
);

insert into specializations (species_id, vet_id)
VALUES (
  (
    SELECT id FROM species
    WHERE name like 'Digimon'
  ),
  (
    SELECT id FROM vets
    WHERE name = 'Jack Harkness'
  )
);

-- Insert data to the visits table
INSERT into visits (animals_id, vet_id, date_of_visit)
VALUES (
  (
    SELECT id FROM animals WHERE name like 'Agumon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'William Tatcher'
  ),
  ('2020-MAY-24')
),
(
  (
    SELECT id FROM animals WHERE name like 'Agumon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Stephanie Mendez'
  ),
  ('2020-JUL-22')
),
(
  (
    SELECT id FROM animals WHERE name like 'Gabumon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Jack Harkness'
  ),
  ('2021-FEB-02')
),
(
  (
    SELECT id FROM animals WHERE name like 'Pikachu'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Maisy Smith'
  ),
  ('2020-JAN-05')
),
(
  (
    SELECT id FROM animals WHERE name like 'Pikachu'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Maisy Smith'
  ),
  ('2020-MAR-08')
),
(
  (
    SELECT id FROM animals WHERE name like 'Pikachu'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Maisy Smith'
  ),
  ('2020-MAY-14')
),
(
  (
    SELECT id FROM animals WHERE name like 'Devimon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Stephanie Mendez'
  ),
  ('2021-MAY-04')
),
(
  (
    SELECT id FROM animals WHERE name like 'Charmander'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Jack Harkness'
  ),
  ('2021-FEB-24')
),
(
  (
    SELECT id FROM animals WHERE name like 'Plantmon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Maisy Smith'
  ),
  ('2019-DEC-21')
),
(
  (
    SELECT id FROM animals WHERE name like 'Plantmon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'William Tatcher'
  ),
  ('2020-AUG-10')
),
(
  (
    SELECT id FROM animals WHERE name like 'Plantmon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Maisy Smith'
  ),
  ('2021-APR-07')
),
(
  (
    SELECT id FROM animals WHERE name like 'Squirtle'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Stephanie Mendez'
  ),
  ('2019-SEP-29')
),
(
  (
    SELECT id FROM animals WHERE name like 'Angemon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Jack Harkness'
  ),
  ('2020-OCT-03')
),
(
  (
    SELECT id FROM animals WHERE name like 'Angemon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Jack Harkness'
  ),
  ('2020-NOV-04')
),
(
  (
    SELECT id FROM animals WHERE name like 'Boarmon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Maisy Smith'
  ),
  ('2019-JAN-24')
),
(
  (
    SELECT id FROM animals WHERE name like 'Boarmon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Maisy Smith'
  ),
  ('2019-MAY-15')
),
(
  (
    SELECT id FROM animals WHERE name like 'Boarmon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Maisy Smith'
  ),
  ('2020-FEB-27')
),
(
  (
    SELECT id FROM animals WHERE name like 'Boarmon'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Maisy Smith'
  ),
  ('2020-AUG-03')
),
(
  (
    SELECT id FROM animals WHERE name like 'Blossom'
  ), 
  (
    SELECT id FROM vets WHERE name like 'Stephanie Mendez'
  ),
  ('2020-MAY-24')
),
(
  (
    SELECT id FROM animals WHERE name like 'Blossom'
  ), 
  (
    SELECT id FROM vets WHERE name like 'William Tatcher'
  ),
  ('2021-JAN-11')
);

/* project 4 */


-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (
  animals_id,
  vet_id,
  date_of_visit
) SELECT * FROM (
    SELECT id FROM animals
  ) animals_ids,
  ( 
    SELECT id FROM vets
  ) vets_ids,
  generate_series(
    '1980-01-01'::timestamp,
    '2021-01-01',
    '4 hours'
  ) 
  visit_timestamp;
