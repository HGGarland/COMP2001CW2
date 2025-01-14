-- Ensure PasswordHash exists in dbo.Users
IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'Users' AND COLUMN_NAME = 'PasswordHash'
)
BEGIN
    ALTER TABLE dbo.Users ADD PasswordHash NVARCHAR(255);
END;

-- Ensure Description, CreatedBy, and CreatedAt exist in dbo.Trail
IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'Trail' AND COLUMN_NAME = 'Description'
)
BEGIN
    ALTER TABLE dbo.Trail ADD Description NVARCHAR(MAX);
END;

IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'Trail' AND COLUMN_NAME = 'CreatedBy'
)
BEGIN
    ALTER TABLE dbo.Trail ADD CreatedBy INT;
END;

IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'Trail' AND COLUMN_NAME = 'CreatedAt'
)
BEGIN
    ALTER TABLE dbo.Trail ADD CreatedAt DATETIME DEFAULT GETDATE();
END;

-- Ensure LocationLat, LocationLon, and PointOrder exist in dbo.TrailLocation
IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TrailLocation' AND COLUMN_NAME = 'LocationLat'
)
BEGIN
    ALTER TABLE dbo.TrailLocation ADD LocationLat FLOAT NOT NULL;
END;

IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TrailLocation' AND COLUMN_NAME = 'LocationLon'
)
BEGIN
    ALTER TABLE dbo.TrailLocation ADD LocationLon FLOAT NOT NULL;
END;

IF NOT EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TrailLocation' AND COLUMN_NAME = 'PointOrder'
)
BEGIN
    ALTER TABLE dbo.TrailLocation ADD PointOrder INT NOT NULL;
END;

-- Drop redundant Latitude and Longitude columns if they exist
IF EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TrailLocation' AND COLUMN_NAME = 'Latitude'
)
BEGIN
    ALTER TABLE dbo.TrailLocation DROP COLUMN Latitude;
END;

IF EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.COLUMNS
    WHERE TABLE_NAME = 'TrailLocation' AND COLUMN_NAME = 'Longitude'
)
BEGIN
    ALTER TABLE dbo.TrailLocation DROP COLUMN Longitude;
END;
