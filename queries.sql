/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered = true AND escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT * FROM animals WHERE neutered = true;
SELECT * FROM animals WHERE name != 'Gabumon';
SELECT * FROM animals WHERE weight_kg BETWEEN 10.4 AND 17.3;


BEGIN;
UPDATE animals
SET species = 'unspecified';
SELECT * FROM animals;
ROLLBACK;

-- Begin the transaction
BEGIN;

-- Update species to 'digimon' for animals with names ending in 'mon'
UPDATE animals SET species = 'digimon' WHERE name LIKE '%mon';

-- Update species to 'pokemon' for animals without a species
UPDATE animals SET species = 'pokemon' WHERE species IS NULL;

-- Verify the changes
SELECT * FROM animals;

-- Commit the transaction
COMMIT;

-- Verify that changes persist after commit
SELECT * FROM animals;


-- Begin the transaction
BEGIN;

-- Delete all records from the animals table
DELETE FROM animals;

-- Verify that records are deleted
SELECT * FROM animals;

-- Roll back the transaction
ROLLBACK;

SELECT * FROM animals;


-- Begin the transaction
BEGIN;

-- Delete animals born after Jan 1st, 2022
DELETE FROM animals WHERE date_of_birth > '2022-01-01';

-- Create a savepoint
SAVEPOINT my_savepoint;

-- Update weights to be their weight multiplied by -1
UPDATE animals SET weight_kg = weight_kg * -1;

-- Verify the changes
SELECT * FROM animals;

-- Roll back to the savepoint
ROLLBACK TO my_savepoint;

-- Update negative weights back to positive using the absolute value
UPDATE animals SET weight_kg = ABS(weight_kg) WHERE weight_kg < 0;

-- Verify the changes
SELECT * FROM animals;

-- Commit the transaction
COMMIT;


SELECT COUNT(*) FROM animals;
SELECT COUNT(*) FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) FROM animals;
SELECT neutered, MAX(escape_attempts) FROM animals GROUP BY neutered;
SELECT species, MIN(weight_kg) AS min_weight, MAX(weight_kg) AS max_weight
FROM animals GROUP BY species;
SELECT species, AVG(escape_attempts) AS avg_escape_attempts
FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Melody Pond';

SELECT a.name
FROM animals a
JOIN species s ON a.species_id = s.id
WHERE s.name = 'Pokemon';

SELECT o.full_name, a.name
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id;

SELECT s.name, COUNT(a.id) AS animal_count
FROM species s
LEFT JOIN animals a ON s.id = a.species_id
GROUP BY s.name;

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
JOIN species s ON a.species_id = s.id
WHERE o.full_name = 'Jennifer Orwell' AND s.name = 'Digimon';

SELECT a.name
FROM animals a
JOIN owners o ON a.owner_id = o.id
WHERE o.full_name = 'Dean Winchester' AND a.escape_attempts = 0;

SELECT o.full_name, COUNT(a.id) AS animal_count
FROM owners o
LEFT JOIN animals a ON o.id = a.owner_id
GROUP BY o.full_name
ORDER BY animal_count DESC
LIMIT 1;


-- My code starts from here

-- Calculate the number of visits for the animal with ID 4 and provide query execution details.
EXPLAIN ANALYZE SELECT COUNT(*) FROM visits WHERE animal_id = 4;

-- Retrieve visit records associated with the vet having ID 2 and display query execution details.
EXPLAIN ANALYZE SELECT * FROM visits WHERE vet_id = 2;

-- Fetch owner records with the specified email address ('owner_18327@mail.com') and include query execution details.
EXPLAIN ANALYZE SELECT * FROM owners WHERE email = 'owner_18327@mail.com';

