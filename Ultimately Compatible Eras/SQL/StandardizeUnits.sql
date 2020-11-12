--This locks all custom warrior type units behind the Bronze Working tech
UPDATE Units
	SET PrereqTech = 'TECH_BRONZE_WORKING'
	WHERE Class = 'UNITCLASS_WARRIOR';

--This locks all custom scout type units behind the Scouting tech if UEM is enabled.
UPDATE Units
	SET PrereqTech = 'TECH_SCOUTING'
	WHERE Class = 'UNITCLASS_SCOUT';

--This locks all custom worker type units behind the Basic Tools tech if UEM is enabled.
UPDATE Units
	SET PrereqTech = 'TECH_BASIC_TOOLS'
	WHERE Class = 'UNITCLASS_WORKER';