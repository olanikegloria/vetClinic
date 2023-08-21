/* Populate database with sample data. */
INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    ('Agumon', '2020-02-03', 0, true, 10.23),
    ('Gabumon', '2018-11-15', 2, true, 8),
    ('Pikachu', '2021-01-07', 1, false, 15.04),
    ('Devimon', '2017-05-12', 5, true, 11);

INSERT INTO animals (name, date_of_birth, escape_attempts, neutered, weight_kg)
VALUES
    ('Charmander', '2020-02-08', 0, false, -11),
    ('Plantmon', '2021-11-15', 2, true, -5.7),
    ('Squirtle', '1993-04-02', 3, false, -12.13),
    ('Angemon', '2005-06-12', 1, true, -45),
    ('Boarmon', '2005-06-07', 7, true, 20.4),
    ('Blossom', '1998-10-13', 3, true, 17),
    ('Ditto', '2022-05-14', 4, true, 22);

INSERT INTO owners (full_name, age)
VALUES
    ('Sam Smith', 34),
    ('Jennifer Orwell', 19),
    ('Bob', 45),
    ('Melody Pond', 77),
    ('Dean Winchester', 14),
    ('Jodie Whittaker', 38);

INSERT INTO species (name)
VALUES
    ('Pokemon'),
    ('Digimon');

-- Update animals with names ending in "mon" to have species_id = 2 (Digimon)
UPDATE animals
SET species_id = 2
WHERE name LIKE '%mon';

-- Update animals with other names to have species_id = 1 (Pokemon)
UPDATE animals
SET species_id = 1
WHERE species_id IS NULL;

-- Update animals with owners based on the provided information
UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Sam Smith')
WHERE name = 'Agumon';

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Jennifer Orwell')
WHERE name IN ('Gabumon', 'Pikachu');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Bob')
WHERE name IN ('Devimon', 'Plantmon');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Melody Pond')
WHERE name IN ('Charmander', 'Squirtle', 'Blossom');

UPDATE animals
SET owner_id = (SELECT id FROM owners WHERE full_name = 'Dean Winchester')
WHERE name IN ('Angemon', 'Boarmon');

  /* join table visit */

  INSERT INTO vets(name, age, date_of_graduation) 
    VALUES 
        ('William Tatcher', 45, '2000-04-23'),
        ('Maisy Smith', 26, '2019-01-17'),
        ('Stephanie Mendez', 64, '1981-05-04'),
        ('Jack Harkness', 38, '2008-06-08');



INSERT INTO specializations (vet_id, species_id)
VALUES
   (1, 1),        
   (3, 1),        
   (3, 2),
   (4, 2);


INSERT INTO visits (animal_id, vet_id, date_of_visit)
VALUES
   (1, 1, '2020-05-24'),
   (1, 3, '2020-07-22'),
   (2, 4, '2021-02-02'),
   (3, 2, '2020-01-05'),
   (3, 2, '2020-03-08'),
   (3, 2, '2020-05-14'),
   (4, 3, '2021-05-04'),
   (5, 4, '2021-02-24'),
   (6, 2, '2019-12-21'),
   (6, 1, '2020-08-10'),
   (6, 2, '2021-04-07'),
   (7, 3, '2019-09-29'),
   (8, 4, '2020-10-03'),
   (8, 4, '2020-11-04'),
   (9, 2, '2019-01-24'),
   (9, 2, '2019-05-15'),
   (9, 2, '2020-02-27'),
   (9, 2, '2020-08-03'),
   (10, 3, '2020-05-24'),
   (10, 1, '2021-01-11');

   -- The subsequent query is projected to contribute roughly 3,594,280 additional visits. This projection takes into account a scenario involving 10 animals, 4 vets, and an estimated usage of approximately 87,000 timestamps (equivalent to around 4 minutes).

INSERT INTO visits (animal_id, vet_id, date_of_visit)
SELECT * FROM (
SELECT id FROM animals
) AS animal_ids,
(
SELECT id FROM vets
) AS vets_ids,
generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') AS visit_timestamp;

-- Similarly, running this query will lead to the inclusion of approximately 2,500,000 owners in the database. Each owner's full_name will follow the pattern 'Owner <X>', and their respective emails will be in the format 'owner_<X>@mail.com' (~2 minutes approx.).

INSERT INTO owners (full_name, email)
SELECT 'Owner ' || generate_series(1, 2500000), 'owner_' || generate_series(1, 2500000) || '@mail.com';
