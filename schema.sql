/* Database schema to keep the structure of entire database. */
/* project 1 */
create table animals (
    id int GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal
);

/* project 2 */
/* Add a column species of type string to your animals table. */

ALTER TABLE animals ADD species VARCHAR(100);

/* project 3 */

-- Delete species column from animals table

ALTER TABLE animals DROP COLUMN species;

-- Create species table

CREATE TABLE species (
    id int GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50)
);

-- Create owners table

CREATE TABLE owners (
    id int GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(100),
    age int
);

-- Add column species_id which is a foreign key referencing species table

ALTER TABLE animals ADD species_id INT;
ALTER TABLE animals ADD FOREIGN KEY (species_id) REFERENCES species(id) ON DELETE CASCADE;

-- Add column owner_id which is a foreign key referencing the owners table

ALTER TABLE animals ADD owner_id INT;
ALTER TABLE animals ADD FOREIGN KEY (owner_id) REFERENCES owners(id) ON DELETE CASCADE;

/* Project 4 */

-- Create vets table.
CREATE TABLE vets (
    id int GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    age int,
    date_of_graduation date
);

-- Create specializations table

CREATE TABLE specializations (
    id int GENERATED ALWAYS AS IDENTITY,
    species_id int NOT NULL,
    vet_id int NOT null,
    FOREIGN KEY (species_id) 
        REFERENCES species(id) ON DELETE CASCADE, 
    FOREIGN KEY (vet_id) 
        REFERENCES vets(id) ON DELETE CASCADE
);

-- Create visits table
CREATE TABLE visits (
    id int GENERATED ALWAYS AS IDENTITY,
    animals_id int NOT NULL,
    vet_id int NOT null,
    date_of_visit date,
    FOREIGN KEY (animals_id)
        REFERENCES animals(id) ON DELETE CASCADE,
    FOREIGN KEY (vet_id)
        REFERENCES vets(id) ON DELETE CASCADE
);

-- Add an email column to your owners table
ALTER TABLE owners ADD COLUMN email VARCHAR(120);

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
