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

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'William Tatcher'
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(DISTINCT v.animal_id)
FROM visits v
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez';

SELECT vt.name, s.name AS specialty
FROM vets vt
LEFT JOIN specializations sp ON vt.id = sp.vet_id
LEFT JOIN species s ON sp.species_id = s.id;

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Stephanie Mendez'
    AND v.visit_date BETWEEN '2020-04-01' AND '2020-08-30';

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY COUNT(v.id) DESC
LIMIT 1;

SELECT a.name
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Maisy Smith'
ORDER BY v.visit_date ASC
LIMIT 1;

SELECT a.name AS animal_name, vt.name AS vet_name, v.visit_date
FROM animals a
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
ORDER BY v.visit_date DESC
LIMIT 1;

SELECT COUNT(v.id)
FROM visits v
JOIN animals a ON v.animal_id = a.id
JOIN vets vt ON v.vet_id = vt.id
LEFT JOIN specializations sp ON vt.id = sp.vet_id AND a.species_id = sp.species_id
WHERE sp.vet_id IS NULL;

SELECT s.name AS suggested_specialty
FROM animals a
JOIN species s ON a.species_id = s.id
JOIN visits v ON a.id = v.animal_id
JOIN vets vt ON v.vet_id = vt.id
WHERE vt.name = 'Maisy Smith'
GROUP BY s.name
ORDER BY COUNT(a.id) DESC
LIMIT 1;
