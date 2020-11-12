INSERT INTO Buildings	(Type,						BuildingClass,					Cost,	PrereqTech,		Help,									Description,						Civilopedia,							Strategy,									ArtDefineTag,				MinAreaSize,	NeverCapture,	IconAtlas,				PortraitIndex)
	VALUES				('BUILDING_SAILING_YIELDS',	'BUILDINGCLASS_SAILING_YIELDS',	-1,		NULL,	'TXT_KEY_BUILDING_SAILING_YIELDS_HELP',	'TXT_KEY_BUILDING_SAILING_YIELDS',	'TXT_KEY_BUILDING_SAILING_YIELDS_TEXT',	'TXT_KEY_BUILDING_SAILING_YIELDS_STRATEGY',	'ART_DEF_BUILDING_PALACE',	-1,				1,				'UNIT_ACTION_ATLAS',	6);
INSERT INTO Building_RiverPlotYieldChanges	(BuildingType,				YieldType,		Yield)
	VALUES									('BUILDING_SAILING_YIELDS',	'YIELD_GOLD',	1);
INSERT INTO Building_SeaPlotYieldChanges	(BuildingType,				YieldType,		Yield)
	VALUES									('BUILDING_SAILING_YIELDS',	'YIELD_GOLD',	1);
INSERT INTO BuildingClasses	(Type,								DefaultBuilding,			Description)
	VALUES					('BUILDINGCLASS_SAILING_YIELDS',	'BUILDING_SAILING_YIELDS',	'TXT_KEY_BUILDING_SAILING_YIELDS');
INSERT INTO Language_en_US	(Tag,											Text)
	VALUES					('TXT_KEY_BUILDING_SAILING_YIELDS',				'Coast & River Yields'),
							('TXT_KEY_BUILDING_SAILING_YIELDS_TEXT',		'This building will automatically upgrade any coast and river tiles within your cities to grant +1 gold when worked.'),
							('TXT_KEY_BUILDING_SAILING_YIELDS_HELP',		'This building will automatically upgrade any coast and river tiles within your cities to grant +1 gold when worked.'),
							('TXT_KEY_BUILDING_SAILING_YIELDS_STRATEGY',	'This building will automatically upgrade any coast and river tiles within your cities to grant +1 gold when worked.');

UPDATE Terrain_RiverYieldChanges
	SET Yield = 0
		WHERE YieldType = 'YIELD_GOLD'
			AND EXISTS (SELECT 1 FROM Feature_YieldChanges WHERE FeatureType = 'FEATURE_RIVER');
UPDATE Feature_YieldChanges
	SET Yield = 0
		WHERE FeatureType = 'FEATURE_RIVER'
			AND YieldType = 'YIELD_GOLD'
			AND EXISTS (SELECT 1 FROM Feature_YieldChanges WHERE FeatureType = 'FEATURE_RIVER');
UPDATE Feature_RiverYieldChanges
	SET Yield = 0
		WHERE YieldType = 'YIELD_GOLD'
			AND EXISTS (SELECT 1 FROM Feature_YieldChanges WHERE FeatureType = 'FEATURE_RIVER');
UPDATE Terrain_Yields
	SET Yield = 0
		WHERE TerrainType = 'TERRAIN_COAST'
			AND YieldType = 'YIELD_GOLD'
			AND EXISTS (SELECT 1 FROM Feature_YieldChanges WHERE FeatureType = 'FEATURE_RIVER');
UPDATE Buildings
	SET Cost = 0, PrereqTech = 'TECH_SAILING'
		WHERE Type = 'BUILDING_SAILING_YIELDS'
			AND EXISTS (SELECT 1 FROM Feature_YieldChanges WHERE FeatureType = 'FEATURE_RIVER');