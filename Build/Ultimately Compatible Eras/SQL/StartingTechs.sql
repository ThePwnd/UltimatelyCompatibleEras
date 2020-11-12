-- Change free building at game start

UPDATE Civilization_FreeBuildingClasses
	SET BuildingClassType = 'BUILDINGCLASS_ELDER_HUT'
	WHERE BuildingClassType = 'BUILDINGCLASS_PALACE';

-- Change free tech at game start

UPDATE Civilization_FreeTechs
	SET TechType = 'TECH_SOCIAL_STRUCTURE'
	WHERE TechType = 'TECH_AGRICULTURE';