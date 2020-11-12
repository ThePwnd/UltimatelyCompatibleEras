-- Relocate techs to their absolute positions
UPDATE Technologies
	SET GridX = GridX + (
						 SELECT GridX - 4
						 FROM Technologies
						 WHERE Era IN (
									   SELECT Type
									   FROM Eras
									   WHERE ID >= (
												   SELECT ID
												   FROM Eras
												   WHERE Type = 'ERA_ANCIENT';
												  )
									  )
						 ORDER BY GridX LIMIT 1
						)
	WHERE Era = 'ERA_PREHISTORIC';

-- Reassign transitional techs to their appropriate eras

UPDATE Technologies
	SET Era = 'ERA_ANCIENT'
	WHERE Type IN ('TECH_TRADING','TECH_AGRICULTURE','TECH_ANIMAL_HUSBANDRY','TECH_ARCHERY','TECH_BUILDING','TECH_SAILING','TECH_WEAVING','TECH_CALENDAR','TECH_POTTERY','TECH_THE_WHEEL','TECH_TRAPPING','TECH_PROTECTIVE_BUILDING','TECH_DECORATIVE_BUILDING','TECH_CARTOGRAPHY','TECH_BELIEFS','TECH_WRITING','TECH_ARITHMETIC','TECH_HORSEBACK_RIDING','TECH_MASONRY','TECH_BRONZE_WORKING');