-- Add a new trail
CREATE OR ALTER PROCEDURE dbo.AddTrail
    @TrailName NVARCHAR(100),
    @Distance FLOAT,
    @ElevationGain INT,
    @EstimatedTime INT,
    @Difficulty NVARCHAR(50),
    @TrailInfo NVARCHAR(MAX),
    @UserID INT,
    @Description NVARCHAR(MAX),
    @CreatedBy INT
AS
BEGIN
    INSERT INTO dbo.Trail (TrailName, Distance, ElevationGain, EstimatedTime, Difficulty, TrailInfo, UserID, Description, CreatedBy, CreatedAt)
    VALUES (@TrailName, @Distance, @ElevationGain, @EstimatedTime, @Difficulty, @TrailInfo, @UserID, @Description, @CreatedBy, GETDATE());
END;
GO

-- Add a trail location
CREATE OR ALTER PROCEDURE dbo.AddTrailLocation
    @TrailID INT,
    @LocationLat FLOAT,
    @LocationLon FLOAT,
    @PointOrder INT
AS
BEGIN
    INSERT INTO dbo.TrailLocation (TrailID, LocationLat, LocationLon, PointOrder)
    VALUES (@TrailID, @LocationLat, @LocationLon, @PointOrder);
END;
GO
