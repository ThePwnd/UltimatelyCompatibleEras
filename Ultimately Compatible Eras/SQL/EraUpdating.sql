-- Create a temp Eras table, check to see if there are any eras that predate the Ancient Era, then insert the Prehistoric Era
/*
IF EXISTS (SELECT * FROM Eras WHERE ID > (SELECT ID FROM Eras WHERE Type='ERA_ANCIENT'))
	BEGIN
		CREATE TABLE TempEras AS
			SELECT * 
			FROM Eras 
			WHERE ID > (SELECT ID FROM Eras WHERE Type='ERA_ANCIENT')
			ORDER BY ID ASC;
		INSERT INTO TempEras
			SELECT *
			FROM Eras
			WHERE Type = 'ERA_PREHISTORIC';
	END
ELSE
*/

-- Create temp Eras table and place the Prehistoric Era as the first era in the table
CREATE TABLE TempEras AS
	SELECT *
	FROM Eras
	WHERE Type='ERA_PREHISTORIC';

-- Add all the eras after our new era into the temp table
INSERT INTO TempEras
	SELECT *
	FROM Eras
	WHERE ID >= (SELECT ID FROM Eras WHERE Type='ERA_ANCIENT')
		AND Type != 'ERA_PREHISTORIC'
	ORDER BY ID ASC;

-- Renumber the eras based on their (correct) order in the temp table
UPDATE TempEras SET ID=rowid-1;

-- Empty the Eras table
DELETE FROM Eras;

-- Copy everything back from the temp table into the Eras table in the correct order
INSERT INTO Eras
	SELECT *
	FROM TempEras
	ORDER BY rowid ASC;

-- Dispose of the temp table
DROP TABLE TempEras;

-- Give ourselves some more abbrevations, a total of 15 eras should be more than enough!
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_7_ABBREV', 'VIII');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_8_ABBREV', 'IX');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_9_ABBREV', 'X');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_10_ABBREV', 'XI');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_11_ABBREV', 'XII');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_12_ABBREV', 'XIII');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_13_ABBREV', 'XIV');
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) VALUES('TXT_KEY_ERA_14_ABBREV', 'XV');

-- Create a temp table to hold the names of the eras
CREATE TABLE IF NOT EXISTS Eras_Text(
	ID INTEGER NOT NULL,
	Type TEXT NOT NULL,
	Lang TEXT NOT NULL,
	Desc TEXT DEFAULT NULL,
	Short TEXT DEFAULT NULL
);
DELETE FROM Eras_Text;

-- Grab all the names of the eras for the EN_US language
INSERT INTO Eras_Text(ID, Type, Lang, Desc, Short)
	SELECT e.ID, e.Type, 'EN_US', t1.Text, t2.Text
	FROM Eras e, Language_EN_US t1, Language_EN_US t2
	WHERE e.Description=t1.Tag AND e.ShortDescription=t2.Tag;

-- Update the era names and abbreviations to the required format (as required by the tech tree and 'pedia)
UPDATE Eras SET
	Description='TXT_KEY_ERA_'||ID,
	ShortDescription='TXT_KEY_ERA_'||ID||'_SHORT',
	Abbreviation='TXT_KEY_ERA_'||ID||'_ABBREV';

-- Update the text entries corresponding to the new TXT_KEY's
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) 
	SELECT 'TXT_KEY_ERA_'||e.ID, et.Desc 
	FROM Eras e, Eras_Text et 
	WHERE e.Type = et.Type 
		AND et.Lang='EN_US';
INSERT OR REPLACE INTO Language_EN_US(Tag, Text) 
	SELECT 'TXT_KEY_ERA_'||e.ID||'_SHORT', et.Short 
	FROM Eras e, Eras_Text et 
	WHERE e.Type = et.Type 
		AND et.Lang='EN_US';

-- Dispose of the temp table
DROP TABLE Eras_Text;