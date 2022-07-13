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

