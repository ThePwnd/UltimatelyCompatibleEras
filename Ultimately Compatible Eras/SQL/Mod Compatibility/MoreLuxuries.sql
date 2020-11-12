-- These rows should only exist if More Luxuries is enabled.
UPDATE Resources
	SET TechReveal = 'TECH_FISHERY'
	WHERE Type = 'RESOURCE_CORAL';

UPDATE Resources
	SET TechReveal = 'TECH_GATHERING'
	WHERE Type = 'RESOURCE_OLIVE';

UPDATE Resources
	SET TechReveal = 'TECH_RITUALS'
	WHERE Type = 'RESOURCE_PERFUME';

UPDATE Resources
	SET TechReveal = 'TECH_MINING'
	WHERE Type IN ('RESOURCE_AMBER', 'RESOURCE_JADE', 'RESOURCE_LAPIS');
	
UPDATE Resources
	SET TechReveal = 'TECH_AGRICULTURE'
	WHERE Type IN ('RESOURCE_COFFEE', 'RESOURCE_TEA', 'RESOURCE_TOBACCO');