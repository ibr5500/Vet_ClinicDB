/* Database schema to keep the structure of entire database. */

create table animals (
    id int GENERATED ALWAYS AS IDENTITY,
    name varchar(100),
    date_of_birth date,
    escape_attempts int,
    neutered boolean,
    weight_kg decimal
);

/* Add a column species of type string to your animals table. */

ALTER TABLE animals ADD species VARCHAR(100);
