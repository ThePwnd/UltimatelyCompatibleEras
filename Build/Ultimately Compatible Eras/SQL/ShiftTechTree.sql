-- Shift tech tree to the right by 4 columns
UPDATE Technologies
	SET GridX = GridX + 4
	WHERE GridX >= (SELECT GridX
					FROM Technologies
					WHERE Era IN (	SELECT Type 
									FROM Eras
                                    WHERE ID > (SELECT ID 
												FROM Eras 
                                                WHERE Type='ERA_PREHISTORIC'
									  		   )
								 )
                    ORDER BY GridX LIMIT 1);