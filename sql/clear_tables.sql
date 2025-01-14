-- Clear data from TrailLocation first (dependent table)
DELETE FROM dbo.TrailLocation;

-- Clear data from Trail
DELETE FROM dbo.Trail;

-- Clear data from Users
DELETE FROM dbo.Users;

-- Clear data from TrailLog (if exists)
DELETE FROM dbo.TrailLog;
